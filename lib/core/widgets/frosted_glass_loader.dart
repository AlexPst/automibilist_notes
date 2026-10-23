import 'dart:ui';

import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Экран загрузки: матовое стекло поверх интерфейса, по центру —
/// иконка приложения и анимация.
///
/// [icon] и [animation] — места под будущие иконку и анимацию;
/// пока они не заданы, показываются заглушки.
class FrostedGlassLoader extends StatelessWidget {
  const FrostedGlassLoader({super.key, this.icon, this.animation});

  final Widget? icon;
  final Widget? animation;

  /// Сила размытия того, что под стеклом.
  static const blurSigma = 24.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Semantics(
      label: l10n.loading,
      liveRegion: true,
      // Пока идёт загрузка, интерфейс под стеклом недоступен.
      child: AbsorbPointer(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: DecoratedBox(
              // Полупрозрачная заливка делает стекло «матовым»
              // и оставляет контраст для иконки в обеих темах.
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colors.surface.withValues(alpha: 0.6),
                    colors.primaryContainer.withValues(alpha: 0.4),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon ?? const _IconPlaceholder(),
                    const SizedBox(height: 24),
                    Text(
                      l10n.appTitle,
                      style: theme.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    animation ?? const _AnimationPlaceholder(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Заглушка: иконку приложения подставим позже.
class _IconPlaceholder extends StatelessWidget {
  const _IconPlaceholder();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Icon(Icons.directions_car, size: 56, color: colors.onPrimary),
    );
  }
}

/// Заглушка: анимацию загрузки подставим позже.
class _AnimationPlaceholder extends StatelessWidget {
  const _AnimationPlaceholder();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: LinearProgressIndicator(borderRadius: BorderRadius.circular(4)),
    );
  }
}
