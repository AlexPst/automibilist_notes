import 'package:cardiary/core/utils/formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('целые числа разделяются по разрядам', () {
    // В ru_RU разделитель разрядов — неразрывный пробел.
    expect(formatInt(125000).replaceAll(' ', ' '), '125 000');
  });

  test('дробные — с запятой', () {
    expect(formatDecimal(45.5), '45,5');
    expect(formatDecimal(50), '50');
  });

  test('разбор чисел, введённых пользователем', () {
    expect(parseDecimal('45,5'), 45.5);
    expect(parseDecimal(' 45.5 '), 45.5);
    expect(parseDecimal('1 000,25'), 1000.25);
    expect(parseDecimal(''), isNull);
    expect(parseDecimal('abc'), isNull);
    expect(parseInt('12 000'), 12000);
    expect(parseInt('12,5'), isNull);
  });
}
