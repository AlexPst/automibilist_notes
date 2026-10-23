import 'package:cardiary/data/repositories/settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_database.dart';

void main() {
  late SettingsRepository repository;

  setUp(() {
    repository = SettingsRepository(createTestDatabase().settingsDao);
  });

  test('активный автомобиль по умолчанию не выбран', () async {
    expect(await repository.watchActiveCarId().first, isNull);
  });

  test('выбор активного автомобиля сохраняется и перезаписывается', () async {
    await repository.setActiveCarId(3);
    expect(await repository.watchActiveCarId().first, 3);

    await repository.setActiveCarId(7);
    expect(await repository.watchActiveCarId().first, 7);
  });
}
