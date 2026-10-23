import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/analytics/analytics.dart';
import '../../../core/analytics/analytics_providers.dart';

import 'package:go_router/go_router.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/widgets/confirm_delete_dialog.dart';
import '../../../core/widgets/date_field.dart';
import '../../../data/data_providers.dart';
import '../../../data/models/car.dart';
import '../../../data/models/fuel_entry.dart';
import '../../../data/models/fuel_entry_draft.dart';
import '../../../l10n/app_localizations.dart';
import '../../cars/application/cars_providers.dart';
import '../application/fuel_providers.dart';
import '../domain/fuel_amount_calculator.dart';
import '../domain/fuel_consumption.dart';
import '../domain/mileage_validation.dart';
import 'fuel_validators.dart';

/// Экран добавления (`entryId == null`) или редактирования заправки.
class FuelFormScreen extends ConsumerWidget {
  const FuelFormScreen({super.key, this.entryId});

  final int? entryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final cars = ref.watch(carsListProvider).value;

    if (entryId == null) {
      final car = ref.watch(activeCarProvider);
      if (car == null) return const _Loading();
      return FuelForm(car: car);
    }

    final entry = ref.watch(fuelEntryProvider(entryId!));
    return switch (entry) {
      AsyncData(value: final entry?) when cars != null => FuelForm(
        car: cars.firstWhere((c) => c.id == entry.carId),
        entry: entry,
      ),
      AsyncData(value: null) => Scaffold(
        appBar: AppBar(title: Text(l10n.fuelEditTitle)),
        body: Center(child: Text(l10n.fuelNotFound)),
      ),
      _ => const _Loading(),
    };
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}

class FuelForm extends ConsumerStatefulWidget {
  const FuelForm({super.key, required this.car, this.entry});

  final Car car;

  /// Редактируемая заправка; `null` — новая.
  final FuelEntry? entry;

  @override
  ConsumerState<FuelForm> createState() => _FuelFormState();
}

class _FuelFormState extends ConsumerState<FuelForm> {
  final _formKey = GlobalKey<FormState>();
  final _calculator = FuelAmountCalculator();
  late final TextEditingController _mileage;
  late final TextEditingController _liters;
  late final TextEditingController _price;
  late final TextEditingController _total;
  late final TextEditingController _station;
  late final TextEditingController _comment;
  late DateTime _date;
  late bool _isFullTank;
  bool _saving = false;

  bool get _isNew => widget.entry == null;

  @override
  void initState() {
    super.initState();
    final entry = widget.entry;
    final now = DateTime.now();
    _date = entry?.date ?? DateTime(now.year, now.month, now.day);
    _isFullTank = entry?.isFullTank ?? true;
    _mileage = TextEditingController(text: entry?.mileage.toString());
    _liters = TextEditingController(
      text: entry == null ? null : formatInput(entry.liters),
    );
    _price = TextEditingController(
      text: entry == null ? null : formatInput(entry.pricePerLiter),
    );
    _total = TextEditingController(
      text: entry == null ? null : formatInput(entry.totalCost),
    );
    _station = TextEditingController(text: entry?.station);
    _comment = TextEditingController(text: entry?.comment);

    if (entry != null) {
      // При редактировании цена и литры считаются «введёнными»:
      // исправили сумму — пересчитаются литры.
      _calculator
        ..markEdited(FuelAmountField.liters)
        ..markEdited(FuelAmountField.price);
    } else {
      _prefillFromLastEntry();
    }
  }

  /// Для новой заправки подставляет цену и АЗС из последней.
  void _prefillFromLastEntry() {
    final entries = ref.read(fuelEntriesProvider(widget.car.id)).value;
    if (entries == null || entries.isEmpty) return;
    final last = entries.reduce(
      (a, b) => compareFuelEntries(a, b) >= 0 ? a : b,
    );
    _price.text = formatInput(last.pricePerLiter);
    _station.text = last.station ?? '';
    _calculator.markEdited(FuelAmountField.price);
  }

  @override
  void dispose() {
    for (final c in [_mileage, _liters, _price, _total, _station, _comment]) {
      c.dispose();
    }
    super.dispose();
  }

  void _onAmountChanged(FuelAmountField field) {
    final result = _calculator.onEdited(
      field,
      liters: parseDecimal(_liters.text),
      price: parseDecimal(_price.text),
      total: parseDecimal(_total.text),
    );
    if (result == null) return;
    final controller = switch (result.field) {
      FuelAmountField.liters => _liters,
      FuelAmountField.price => _price,
      FuelAmountField.total => _total,
    };
    controller.text = formatInput(result.value);
  }

  MileageBounds _mileageBounds() {
    final entries =
        ref.watch(fuelEntriesProvider(widget.car.id)).value ?? const [];
    return MileageBounds.forDate(
      entries: entries,
      date: _date,
      initialMileage: widget.car.initialMileage,
      excludeId: widget.entry?.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final validators = FuelValidators(l10n);
    final bounds = _mileageBounds();
    const gap = SizedBox(height: 16);
    const decimalKeyboard = TextInputType.numberWithOptions(decimal: true);
    final decimalOnly = [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))];

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? l10n.fuelNewTitle : l10n.fuelEditTitle),
        actions: [
          if (!_isNew)
            IconButton(
              tooltip: l10n.delete,
              icon: const Icon(Icons.delete_outline),
              onPressed: _delete,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DateField(
                key: const Key('fuel_date'),
                label: l10n.fuelDate,
                date: _date,
                onChanged: (date) => setState(() => _date = date),
              ),
              gap,
              TextFormField(
                key: const Key('fuel_mileage'),
                controller: _mileage,
                decoration: InputDecoration(
                  labelText: '${l10n.fuelMileage} *',
                  helperText: l10n.fuelMileageMinHint(formatInt(bounds.min)),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
                validator: (value) => validators.mileage(value, bounds),
              ),
              gap,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      key: const Key('fuel_liters'),
                      controller: _liters,
                      decoration: InputDecoration(
                        labelText: '${l10n.fuelLiters} *',
                      ),
                      keyboardType: decimalKeyboard,
                      inputFormatters: decimalOnly,
                      textInputAction: TextInputAction.next,
                      validator: validators.liters,
                      onChanged: (_) =>
                          _onAmountChanged(FuelAmountField.liters),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      key: const Key('fuel_price'),
                      controller: _price,
                      decoration: InputDecoration(
                        labelText: '${l10n.fuelPrice(currencySymbol)} *',
                      ),
                      keyboardType: decimalKeyboard,
                      inputFormatters: decimalOnly,
                      textInputAction: TextInputAction.next,
                      validator: validators.price,
                      onChanged: (_) => _onAmountChanged(FuelAmountField.price),
                    ),
                  ),
                ],
              ),
              gap,
              TextFormField(
                key: const Key('fuel_total'),
                controller: _total,
                decoration: InputDecoration(
                  labelText: '${l10n.fuelTotal(currencySymbol)} *',
                  helperText: l10n.fuelAutoCalcHint,
                ),
                keyboardType: decimalKeyboard,
                inputFormatters: decimalOnly,
                textInputAction: TextInputAction.next,
                validator: validators.total,
                onChanged: (_) => _onAmountChanged(FuelAmountField.total),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                key: const Key('fuel_full_tank'),
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.fuelFullTank),
                subtitle: Text(l10n.fuelFullTankHint),
                value: _isFullTank,
                onChanged: (value) => setState(() => _isFullTank = value),
              ),
              const SizedBox(height: 8),
              TextFormField(
                key: const Key('fuel_station'),
                controller: _station,
                decoration: InputDecoration(labelText: l10n.fuelStation),
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
              ),
              gap,
              TextFormField(
                key: const Key('fuel_comment'),
                controller: _comment,
                decoration: InputDecoration(labelText: l10n.fuelComment),
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              FilledButton(
                key: const Key('fuel_save'),
                onPressed: _saving ? null : _save,
                child: Text(l10n.save),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FuelEntryDraft _buildDraft() {
    String? optional(TextEditingController c) {
      final text = c.text.trim();
      return text.isEmpty ? null : text;
    }

    return FuelEntryDraft(
      carId: widget.car.id,
      date: _date,
      mileage: parseInt(_mileage.text)!,
      liters: parseDecimal(_liters.text)!,
      pricePerLiter: parseDecimal(_price.text)!,
      totalCost: parseDecimal(_total.text)!,
      isFullTank: _isFullTank,
      station: optional(_station),
      comment: optional(_comment),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final repository = ref.read(fuelRepositoryProvider);
    try {
      final draft = _buildDraft();
      if (_isNew) {
        await repository.add(draft);
        ref.read(analyticsHolderProvider).log(AnalyticsEvent.fuelAdded);
      } else {
        await repository.update(widget.entry!.id, draft);
        ref.invalidate(fuelEntryProvider(widget.entry!.id));
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).fuelSaveError)),
      );
      return;
    }
    if (mounted) context.pop();
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await confirmDelete(
      context,
      title: l10n.fuelDeleteTitle,
      message: l10n.fuelDeleteMessage,
    );
    if (!confirmed) return;
    await ref.read(fuelRepositoryProvider).delete(widget.entry!.id);
    if (mounted) context.pop();
  }
}
