import 'dart:io';

import 'package:path/path.dart' as p;

/// Хранит фотографии автомобилей в папке приложения.
///
/// В базе сохраняется только имя файла: полный путь к папке приложения
/// может измениться (например, после восстановления из копии).
class CarPhotoStorage {
  CarPhotoStorage(Directory appDirectory)
    : directory = Directory(p.join(appDirectory.path, 'car_photos'));

  final Directory directory;

  File resolve(String fileName) => File(p.join(directory.path, fileName));

  /// Копирует файл в папку приложения и возвращает имя копии.
  Future<String> import(String sourcePath) async {
    await directory.create(recursive: true);
    final extension = p.extension(sourcePath).toLowerCase();
    final fileName = 'car_${DateTime.now().microsecondsSinceEpoch}$extension';
    await File(sourcePath).copy(resolve(fileName).path);
    return fileName;
  }

  Future<void> delete(String fileName) async {
    final file = resolve(fileName);
    if (await file.exists()) await file.delete();
  }
}
