import 'package:cardiary/features/cars/presentation/car_validators.dart';
import 'package:cardiary/l10n/app_localizations_ru.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = AppLocalizationsRu();
  final v = CarValidators(l10n, now: DateTime(2026, 10, 21));

  group('марка и модель', () {
    test('обязательны', () {
      expect(v.brand(''), l10n.errorRequired);
      expect(v.brand('   '), l10n.errorRequired);
      expect(v.model(null), l10n.errorRequired);
    });

    test('ограничены по длине', () {
      expect(v.brand('a' * 50), isNull);
      expect(v.brand('a' * 51), l10n.errorTooLong(50));
    });

    test('корректные значения проходят', () {
      expect(v.brand('Lada'), isNull);
      expect(v.model('Vesta SW Cross'), isNull);
    });
  });

  group('год', () {
    test('необязателен', () => expect(v.year(''), isNull));

    test('от 1900 до следующего года', () {
      expect(v.year('1900'), isNull);
      expect(v.year('2027'), isNull);
      expect(v.year('1899'), l10n.errorRange('1900', '2027'));
      expect(v.year('2028'), l10n.errorRange('1900', '2027'));
    });

    test('не число', () => expect(v.year('20a1'), l10n.errorNotNumber));
  });

  group('объём бака', () {
    test('необязателен', () => expect(v.tankVolume(''), isNull));

    test('принимает запятую и точку', () {
      expect(v.tankVolume('45,5'), isNull);
      expect(v.tankVolume('45.5'), isNull);
    });

    test('от 1 до 300', () {
      expect(v.tankVolume('0,5'), isNotNull);
      expect(v.tankVolume('301'), isNotNull);
      expect(v.tankVolume('300'), isNull);
    });

    test('не число', () => expect(v.tankVolume('1,2,3'), l10n.errorNotNumber));
  });

  group('начальный пробег', () {
    test('обязателен', () {
      expect(v.initialMileage(''), l10n.errorRequired);
    });

    test('ноль допустим', () => expect(v.initialMileage('0'), isNull));

    test('не больше 9 999 999', () {
      expect(v.initialMileage('9999999'), isNull);
      expect(v.initialMileage('10000000'), isNotNull);
    });
  });

  group('госномер', () {
    test('необязателен', () => expect(v.plate(''), isNull));

    test('ограничен по длине', () {
      expect(v.plate('А 123 ВС 777'), isNull);
      expect(v.plate('А 123 ВС 7777'), l10n.errorTooLong(12));
    });

    test('нормализуется: верхний регистр, одиночные пробелы', () {
      expect(normalizePlate('  а 123  вс   77 '), 'А 123 ВС 77');
    });
  });
}
