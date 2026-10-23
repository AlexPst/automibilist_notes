import 'package:flutter/material.dart';

/// Цвета графиков. Восемь категориальных цветов в проверенном порядке:
/// соседние цвета различимы и при нарушениях цветовосприятия.
/// Для тёмной темы — те же оттенки, подобранные под тёмный фон.
abstract final class ChartPalette {
  static const _light = [
    Color(0xFF2A78D6), // синий
    Color(0xFFEB6834), // оранжевый
    Color(0xFF1BAF7A), // бирюзовый
    Color(0xFFEDA100), // жёлтый
    Color(0xFFE87BA4), // розовый
    Color(0xFF008300), // зелёный
    Color(0xFF6250D6), // фиолетовый
    Color(0xFFE34948), // красный
  ];

  static const _dark = [
    Color(0xFF3987E5),
    Color(0xFFD95926),
    Color(0xFF199E70),
    Color(0xFFC98500),
    Color(0xFFD55181),
    Color(0xFF008300),
    Color(0xFF9085E9),
    Color(0xFFE66767),
  ];

  static const slotCount = 8;

  /// Цвет по номеру слота (0–7) для текущей темы.
  static Color slot(BuildContext context, int index) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return (dark ? _dark : _light)[index];
  }

  /// Цвет одиночного ряда данных.
  static Color primary(BuildContext context) => slot(context, 0);
}
