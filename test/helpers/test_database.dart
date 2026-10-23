import 'dart:io';

import 'package:cardiary/data/database/app_database.dart';
import 'package:cardiary/data/storage/car_photo_storage.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// Пустая база в памяти; закрывается автоматически после теста.
AppDatabase createTestDatabase() {
  final db = AppDatabase(
    DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ),
  );
  addTearDown(db.close);
  return db;
}

/// Хранилище фото во временной папке; папка удаляется после теста.
CarPhotoStorage createTestPhotoStorage() {
  final dir = Directory.systemTemp.createTempSync('cardiary_test_');
  addTearDown(() => dir.deleteSync(recursive: true));
  return CarPhotoStorage(dir);
}
