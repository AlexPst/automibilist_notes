import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/analytics/analytics.dart';
import '../../../core/analytics/analytics_providers.dart';

import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/formatters.dart';
import '../../../data/data_providers.dart';
import '../../../data/models/car.dart';
import '../../../data/models/car_draft.dart';
import '../../../data/models/fuel_type.dart';
import '../../../l10n/app_localizations.dart';
import '../application/cars_providers.dart';
import 'car_texts.dart';
import 'car_validators.dart';
import 'widgets/car_avatar.dart';

/// Экран добавления (`carId == null`) или редактирования автомобиля.
class CarFormScreen extends ConsumerWidget {
  const CarFormScreen({super.key, this.carId, this.fromOnboarding = false});

  final int? carId;

  /// Форма открыта с онбординга: после сохранения первого авто
  /// роутер сам переводит на Главную.
  final bool fromOnboarding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (carId == null) return CarForm(fromOnboarding: fromOnboarding);

    final car = ref.watch(carByIdProvider(carId!));
    if (car == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.carEditTitle)),
        body: Center(child: Text(l10n.carNotFound)),
      );
    }
    return CarForm(car: car);
  }
}

class CarForm extends ConsumerStatefulWidget {
  const CarForm({super.key, this.car, this.fromOnboarding = false});

  final bool fromOnboarding;

  /// Редактируемый автомобиль; `null` — новый.
  final Car? car;

  @override
  ConsumerState<CarForm> createState() => _CarFormState();
}

class _CarFormState extends ConsumerState<CarForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _brand;
  late final TextEditingController _model;
  late final TextEditingController _year;
  late final TextEditingController _plate;
  late final TextEditingController _tankVolume;
  late final TextEditingController _mileage;
  late FuelType _fuelType;
  String? _photoPath;
  bool _saving = false;

  bool get _isNew => widget.car == null;

  @override
  void initState() {
    super.initState();
    final car = widget.car;
    _brand = TextEditingController(text: car?.brand);
    _model = TextEditingController(text: car?.model);
    _year = TextEditingController(text: car?.year?.toString());
    _plate = TextEditingController(text: car?.plateNumber);
    _tankVolume = TextEditingController(
      text: car?.tankVolume == null ? null : formatDecimal(car!.tankVolume!),
    );
    _mileage = TextEditingController(text: car?.initialMileage.toString());
    _fuelType = car?.fuelType ?? FuelType.ai95;
    _photoPath = car?.photoPath;
  }

  @override
  void dispose() {
    for (final c in [_brand, _model, _year, _plate, _tankVolume, _mileage]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final validators = CarValidators(l10n);
    const gap = SizedBox(height: 16);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? l10n.carNewTitle : l10n.carEditTitle),
      ),
      body: Form(
        key: _formKey,
        // Column, а не ListView: поля вне экрана должны существовать,
        // иначе Form их не проверит.
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: _PhotoPicker(
                  path: _photoPath,
                  onChanged: (path) => setState(() => _photoPath = path),
                ),
              ),
              gap,
              TextFormField(
                key: const Key('car_brand'),
                controller: _brand,
                decoration: InputDecoration(labelText: '${l10n.carBrand} *'),
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                validator: validators.brand,
              ),
              gap,
              TextFormField(
                key: const Key('car_model'),
                controller: _model,
                decoration: InputDecoration(labelText: '${l10n.carModel} *'),
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                validator: validators.model,
              ),
              gap,
              DropdownButtonFormField<FuelType>(
                key: const Key('car_fuel_type'),
                initialValue: _fuelType,
                decoration: InputDecoration(labelText: l10n.carFuelType),
                items: [
                  for (final type in FuelType.values)
                    DropdownMenuItem(
                      value: type,
                      child: Text(fuelTypeLabel(l10n, type)),
                    ),
                ],
                onChanged: (type) => setState(() => _fuelType = type!),
              ),
              gap,
              TextFormField(
                key: const Key('car_mileage'),
                controller: _mileage,
                decoration: InputDecoration(
                  labelText: '${l10n.carInitialMileage} *',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
                validator: validators.initialMileage,
              ),
              gap,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      key: const Key('car_year'),
                      controller: _year,
                      decoration: InputDecoration(labelText: l10n.carYear),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      textInputAction: TextInputAction.next,
                      validator: validators.year,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      key: const Key('car_tank'),
                      controller: _tankVolume,
                      decoration: InputDecoration(
                        labelText: l10n.carTankVolume,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                      ],
                      textInputAction: TextInputAction.next,
                      validator: validators.tankVolume,
                    ),
                  ),
                ],
              ),
              gap,
              TextFormField(
                key: const Key('car_plate'),
                controller: _plate,
                decoration: InputDecoration(labelText: l10n.carPlate),
                textCapitalization: TextCapitalization.characters,
                textInputAction: TextInputAction.done,
                validator: validators.plate,
              ),
              const SizedBox(height: 24),
              FilledButton(
                key: const Key('car_save'),
                onPressed: _saving ? null : _save,
                child: Text(l10n.save),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CarDraft _buildDraft() {
    final plate = normalizePlate(_plate.text);
    return CarDraft(
      brand: _brand.text.trim(),
      model: _model.text.trim(),
      fuelType: _fuelType,
      initialMileage: parseInt(_mileage.text)!,
      year: parseInt(_year.text),
      plateNumber: plate.isEmpty ? null : plate,
      tankVolume: parseDecimal(_tankVolume.text),
      photoPath: _photoPath,
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final draft = _buildDraft();
    final cars = ref.read(carsRepositoryProvider);
    try {
      if (_isNew) {
        final id = await cars.add(draft);
        ref.read(analyticsHolderProvider).log(AnalyticsEvent.carAdded);
        // Только что добавленный автомобиль сразу становится активным.
        await ref.read(settingsRepositoryProvider).setActiveCarId(id);
      } else {
        await cars.update(widget.car!.id, draft);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).carSaveError)),
      );
      return;
    }

    // С онбординга уводит роутер: закрывать экран самим нельзя —
    // это гонка с переходом на Главную.
    if (widget.fromOnboarding) return;
    if (mounted) context.pop();
  }
}

/// Фото автомобиля: нажатие открывает меню «камера / галерея / удалить».
class _PhotoPicker extends StatelessWidget {
  const _PhotoPicker({required this.path, required this.onChanged});

  final String? path;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        InkWell(
          customBorder: const CircleBorder(),
          onTap: () => _showMenu(context),
          child: CarPhotoCircle(path: path, radius: 48),
        ),
        const SizedBox(height: 8),
        Text(l10n.photoHint, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Future<void> _showMenu(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final source = await showModalBottomSheet<ImageSource?>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(l10n.photoFromCamera),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(l10n.photoFromGallery),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
            if (path != null)
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: Text(l10n.photoRemove),
                onTap: () {
                  Navigator.of(context).pop();
                  onChanged(null);
                },
              ),
          ],
        ),
      ),
    );
    if (source == null) return;

    try {
      final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1280,
        maxHeight: 1280,
        imageQuality: 85,
      );
      if (file != null) onChanged(file.path);
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.photoPickError)));
    }
  }
}
