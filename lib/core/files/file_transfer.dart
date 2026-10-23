import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Сохранение, отправка и выбор файлов. Интерфейс отделён от плагинов,
/// чтобы в тестах подменять его.
abstract interface class FileTransfer {
  /// Системный диалог «Сохранить как». `false` — пользователь отменил.
  Future<bool> save({
    required String fileName,
    required Uint8List bytes,
    required String mimeType,
  });

  /// Системное меню «Поделиться» (мессенджер, почта, облако).
  Future<void> share({
    required String fileName,
    required Uint8List bytes,
    required String mimeType,
  });

  /// Выбор файла; `null` — пользователь отменил.
  Future<Uint8List?> pick();
}

class PlatformFileTransfer implements FileTransfer {
  const PlatformFileTransfer();

  @override
  Future<bool> save({
    required String fileName,
    required Uint8List bytes,
    required String mimeType,
  }) async {
    final uri = await FilePicker.saveFile(
      fileName: fileName,
      bytes: bytes,
      mimeType: mimeType,
    );
    return uri != null;
  }

  @override
  Future<void> share({
    required String fileName,
    required Uint8List bytes,
    required String mimeType,
  }) async {
    // Меню «Поделиться» работает с файлами на диске — пишем во временную папку.
    final dir = await getTemporaryDirectory();
    final file = File(p.join(dir.path, fileName));
    await file.writeAsBytes(bytes, flush: true);
    await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path, mimeType: mimeType)]),
    );
  }

  @override
  Future<Uint8List?> pick() async {
    final files = await FilePicker.pickFiles();
    if (files.isEmpty) return null;
    return files.single.readAsBytes();
  }
}
