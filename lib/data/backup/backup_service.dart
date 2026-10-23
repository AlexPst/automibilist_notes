import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../database/app_database.dart';
import '../storage/car_photo_storage.dart';

/// Почему файл нельзя восстановить.
enum BackupProblem {
  /// Это не резервная копия приложения или файл повреждён.
  invalidFile,

  /// Копия сделана более новой версией приложения.
  newerVersion,
}

class BackupException implements Exception {
  const BackupException(this.problem, [this.details]);

  final BackupProblem problem;
  final Object? details;

  @override
  String toString() => 'BackupException($problem, $details)';
}

/// Прочитанная и проверенная копия — можно показать сводку и восстановить.
class Backup {
  const Backup._(this._json);

  final Map<String, Object?> _json;

  DateTime get createdAt => DateTime.parse(_json['createdAt']! as String);

  int count(String table) => (_json[table]! as List).length;

  int get cars => count(BackupService.carsKey);
  int get fuelEntries => count(BackupService.fuelKey);
  int get expenses => count(BackupService.expensesKey);
  int get reminders => count(BackupService.remindersKey);
  int get serviceRecords => count(BackupService.serviceKey);
}

/// Резервная копия всех данных в одном JSON-файле, включая фото.
///
/// Строки таблиц сохраняются через `toJson()` drift — формат совпадает
/// со схемой базы, поэтому в файл пишется её версия. Когда схема
/// изменится, старые копии нужно будет переводить на новую версию здесь же.
class BackupService {
  BackupService(this._db, this._photos);

  final AppDatabase _db;
  final CarPhotoStorage _photos;

  static const format = 'cardiary-backup';
  static const carsKey = 'cars';
  static const fuelKey = 'fuelEntries';
  static const expensesKey = 'expenses';
  static const remindersKey = 'reminders';
  static const serviceKey = 'serviceRecords';
  static const settingsKey = 'settings';
  static const photosKey = 'photos';

  /// Ключ настройки, которую не переносим: экран первого запуска
  /// после восстановления показывать не нужно.
  static const _firstLaunchKey = 'first_launch_done';

  /// «cardiary-2026-10-23.json».
  static String fileName(DateTime now) =>
      'cardiary-${now.year}-${_two(now.month)}-${_two(now.day)}.json';

  static String _two(int n) => n.toString().padLeft(2, '0');

  Future<Uint8List> export(DateTime now) async {
    final cars = await _db.select(_db.cars).get();

    final photos = <String, String>{};
    for (final car in cars) {
      final name = car.photoFileName;
      if (name == null) continue;
      final file = _photos.resolve(name);
      if (await file.exists()) {
        photos[name] = base64Encode(await file.readAsBytes());
      }
    }

    final json = <String, Object?>{
      'format': format,
      'schemaVersion': _db.schemaVersion,
      'createdAt': now.toIso8601String(),
      carsKey: [for (final r in cars) r.toJson()],
      fuelKey: [
        for (final r in await _db.select(_db.fuelEntries).get()) r.toJson(),
      ],
      expensesKey: [
        for (final r in await _db.select(_db.expenses).get()) r.toJson(),
      ],
      remindersKey: [
        for (final r in await _db.select(_db.reminders).get()) r.toJson(),
      ],
      serviceKey: [
        for (final r in await _db.select(_db.serviceRecords).get()) r.toJson(),
      ],
      settingsKey: [
        for (final r in await _db.select(_db.settings).get())
          if (r.key != _firstLaunchKey) r.toJson(),
      ],
      photosKey: photos,
    };
    return utf8.encode(const JsonEncoder.withIndent(' ').convert(json));
  }

  /// Читает и проверяет файл, не трогая текущие данные.
  Backup read(Uint8List bytes) {
    final Object? decoded;
    try {
      decoded = jsonDecode(utf8.decode(bytes));
    } on FormatException catch (e) {
      throw BackupException(BackupProblem.invalidFile, e);
    }
    if (decoded is! Map<String, Object?> || decoded['format'] != format) {
      throw const BackupException(BackupProblem.invalidFile);
    }
    final version = decoded['schemaVersion'];
    if (version is! int) {
      throw const BackupException(BackupProblem.invalidFile);
    }
    if (version > _db.schemaVersion) {
      throw const BackupException(BackupProblem.newerVersion);
    }
    for (final key in [
      carsKey,
      fuelKey,
      expensesKey,
      remindersKey,
      serviceKey,
      settingsKey,
    ]) {
      if (decoded[key] is! List) {
        throw BackupException(BackupProblem.invalidFile, key);
      }
    }
    if (decoded[photosKey] is! Map || decoded['createdAt'] is! String) {
      throw const BackupException(BackupProblem.invalidFile);
    }
    return Backup._(decoded);
  }

  /// Заменяет все данные содержимым копии. Если что-то пойдёт не так,
  /// транзакция откатится и текущие данные останутся.
  Future<void> restore(Backup backup) async {
    final json = backup._json;
    List<Map<String, dynamic>> rows(String key) =>
        (json[key]! as List).cast<Map<String, dynamic>>();

    try {
      await _db.transaction(() async {
        // Сначала зависимые таблицы, потом автомобили.
        await _db.delete(_db.serviceRecords).go();
        await _db.delete(_db.reminders).go();
        await _db.delete(_db.expenses).go();
        await _db.delete(_db.fuelEntries).go();
        await _db.delete(_db.cars).go();
        await (_db.delete(
          _db.settings,
        )..where((s) => s.key.isNotValue(_firstLaunchKey))).go();

        await _db.batch((b) {
          b.insertAll(_db.cars, rows(carsKey).map(CarRecord.fromJson));
          b.insertAll(
            _db.fuelEntries,
            rows(fuelKey).map(FuelEntryRecord.fromJson),
          );
          b.insertAll(
            _db.expenses,
            rows(expensesKey).map(ExpenseRecord.fromJson),
          );
          b.insertAll(
            _db.reminders,
            rows(remindersKey).map(ReminderRecord.fromJson),
          );
          b.insertAll(
            _db.serviceRecords,
            rows(serviceKey).map(ServiceRecordRow.fromJson),
          );
          b.insertAll(
            _db.settings,
            rows(settingsKey).map(SettingEntry.fromJson),
          );
        });
      });
    } on Object catch (e) {
      // Неверные поля в строках (например, файл правили вручную).
      throw BackupException(BackupProblem.invalidFile, e);
    }

    await _restorePhotos((json[photosKey]! as Map).cast<String, String>());
  }

  /// Записывает фото из копии и убирает фото, которых в ней нет.
  Future<void> _restorePhotos(Map<String, String> photos) async {
    final dir = _photos.directory;
    if (await dir.exists()) {
      await for (final entity in dir.list()) {
        if (entity is File) await entity.delete();
      }
    }
    for (final MapEntry(key: name, value: data) in photos.entries) {
      // Имя берём только как имя файла — без путей из копии.
      final safeName = name.split(RegExp(r'[/\\]')).last;
      await dir.create(recursive: true);
      await _photos.resolve(safeName).writeAsBytes(base64Decode(data));
    }
  }
}
