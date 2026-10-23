import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_providers.dart';
import '../startup/first_launch.dart';
import 'frosted_glass_loader.dart';

/// При первом запуске показывает поверх приложения экран загрузки
/// ([FrostedGlassLoader]) и плавно убирает его.
class FirstLaunchOverlay extends ConsumerStatefulWidget {
  const FirstLaunchOverlay({super.key, required this.child});

  final Widget child;

  /// Сколько держится экран загрузки.
  static const showFor = Duration(milliseconds: 2500);

  /// Длительность растворения.
  static const fadeOut = Duration(milliseconds: 400);

  @override
  ConsumerState<FirstLaunchOverlay> createState() => _FirstLaunchOverlayState();
}

class _FirstLaunchOverlayState extends ConsumerState<FirstLaunchOverlay> {
  late bool _visible = ref.read(isFirstLaunchProvider).value ?? false;
  bool _fading = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (_visible) {
      _timer = Timer(
        FirstLaunchOverlay.showFor,
        () => setState(() => _fading = true),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onFadedOut() {
    if (!_fading) return;
    setState(() => _visible = false);
    ref.read(settingsRepositoryProvider).markFirstLaunchDone();
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return widget.child;
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: _fading ? 0 : 1,
            duration: FirstLaunchOverlay.fadeOut,
            onEnd: _onFadedOut,
            child: const FrostedGlassLoader(),
          ),
        ),
      ],
    );
  }
}
