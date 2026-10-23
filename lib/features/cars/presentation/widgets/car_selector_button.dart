import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../data/data_providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../application/cars_providers.dart';
import '../car_texts.dart';
import 'car_avatar.dart';

/// Кнопка в AppBar: показывает активный автомобиль и позволяет сменить его.
class CarSelectorButton extends ConsumerWidget {
  const CarSelectorButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final car = ref.watch(activeCarProvider);
    if (car == null) return const SizedBox.shrink();

    return IconButton(
      tooltip: AppLocalizations.of(context).carSelect,
      icon: CarAvatar(car: car, radius: 16),
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        // Поверх нижней панели навигации.
        useRootNavigator: true,
        showDragHandle: true,
        builder: (_) => const _CarSelectorSheet(),
      ),
    );
  }
}

class _CarSelectorSheet extends ConsumerWidget {
  const _CarSelectorSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final cars = ref.watch(carsListProvider).value ?? const [];
    final active = ref.watch(activeCarProvider);

    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          for (final car in cars)
            ListTile(
              leading: CarAvatar(car: car),
              title: Text(carTitle(car)),
              subtitle: Text(carSubtitle(l10n, car)),
              trailing: car.id == active?.id
                  ? const Icon(Icons.check_circle)
                  : null,
              selected: car.id == active?.id,
              onTap: () {
                ref.read(settingsRepositoryProvider).setActiveCarId(car.id);
                Navigator.of(context).pop();
              },
            ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.garage_outlined),
            title: Text(l10n.carsManage),
            onTap: () {
              Navigator.of(context).pop();
              context.push(AppRoutes.cars);
            },
          ),
        ],
      ),
    );
  }
}
