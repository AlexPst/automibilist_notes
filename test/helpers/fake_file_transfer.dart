import 'dart:typed_data';

import 'package:cardiary/core/files/file_transfer.dart';

/// Запоминает сохранённые файлы и отдаёт заданный файл при выборе.
class FakeFileTransfer implements FileTransfer {
  final saved = <String, Uint8List>{};
  final shared = <String, Uint8List>{};
  Uint8List? fileToPick;

  @override
  Future<bool> save({
    required String fileName,
    required Uint8List bytes,
    required String mimeType,
  }) async {
    saved[fileName] = bytes;
    return true;
  }

  @override
  Future<void> share({
    required String fileName,
    required Uint8List bytes,
    required String mimeType,
  }) async {
    shared[fileName] = bytes;
  }

  @override
  Future<Uint8List?> pick() async => fileToPick;
}
