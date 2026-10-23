import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/widgets/confirm_delete_dialog.dart';
import '../../../data/data_providers.dart';
import '../../../data/models/car.dart';
import '../../../l10n/app_localizations.dart';
import '../application/cars_providers.dart';
import 'car_texts.dart';
import 'widgets/car_avatar.dart';

/// Список автомобилей: выбор активного, редактирование, удаление.
class CarsScreen extends ConsumerWidget {
  const CarsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final cars = ref.watch(carsListProvider).value ?? const [];
    final active = ref.watch(activeCarProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.carsTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.carNew),
        icon: const Icon(Icons.add),
        label: Text(l10n.carAdd),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 88),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          final isActive = car.id == active?.id;
          return ListTile(
            leading: CarAvatar(car: car),
            title: Text(carTitle(car)),
            subtitle: Text(
              isActive
                  ? '${l10n.carActive} · ${carSubtitle(l10n, car)}'
                  : carSubtitle(l10n, car),
            ),
            selected: isActive,
            onTap: () =>
                ref.read(settingsRepositoryProvider).setActiveCarId(car.id),
            trailing: _CarMenu(car: car),
          );
        },
      ),
    );
  }
}

enum _CarAction { edit, delete }

class _CarMenu extends ConsumerWidget {
  const _CarMenu({required this.car});

  final Car car;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return PopupMenuButton<_CarAction>(
      onSelected: (action) => switch (action) {
        _CarAction.edit => context.push(AppRoutes.carEdit(car.id)),
        _CarAction.delete => _confirmDelete(context, ref),
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: _CarAction.edit, child: Text(l10n.edit)),
        PopupMenuItem(value: _CarAction.delete, child: Text(l10n.delete)),
      ],
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await confirmDelete(
      context,
      title: l10n.carDeleteTitle,
      message: l10n.carDeleteMessage(carTitle(car)),
    );
    if (confirmed) await ref.read(carsRepositoryProvider).delete(car.id);
  }
}
