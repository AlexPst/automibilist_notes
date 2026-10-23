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
import '../../../data/models/reminder.dart';
import '../../../data/models/service_record.dart';
import '../../../data/models/service_record_draft.dart';
import '../../../l10n/app_localizations.dart';
import '../../cars/application/cars_providers.dart';
import '../../cars/presentation/car_validators.dart';
import '../application/service_providers.dart';

/// Экран добавления (`recordId == null`) или редактирования записи ТО.
class ServiceRecordFormScreen extends ConsumerWidget {
  const ServiceRecordFormScreen({super.key, this.recordId, this.reminderId});

  final int? recordId;

  /// Напоминание, выбранное заранее (кнопка «Выполнено»).
  final int? reminderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    final ({int carId, ServiceRecord? record})? target;
    if (recordId == null) {
      final car = ref.watch(activeCarProvider);
      target = car == null ? null : (carId: car.id, record: null);
    } else {
      switch (ref.watch(serviceRecordProvider(recordId!))) {
        case AsyncData(value: final r?):
          target = (carId: r.carId, record: r);
        case AsyncData(value: null):
          return Scaffold(
            appBar: AppBar(title: Text(l10n.serviceRecordEditTitle)),
            body: Center(child: Text(l10n.serviceRecordNotFound)),
          );
        default:
          target = null;
      }
    }
    if (target == null) return const _Loading();

    final reminders = ref.watch(remindersProvider(target.carId)).value;
    final mileage = ref.watch(currentMileageProvider(target.carId));
    if (reminders == null || mileage == null) return const _Loading();

    return ServiceRecordForm(
      carId: target.carId,
      record: target.record,
      reminders: reminders,
      currentMileage: mileage,
      initialReminderId: reminderId,
    );
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

class ServiceRecordForm extends ConsumerStatefulWidget {
  const ServiceRecordForm({
    super.key,
    required this.carId,
    required this.reminders,
    required this.currentMileage,
    this.record,
    this.initialReminderId,
  });

  final int carId;
  final List<Reminder> reminders;
  final int currentMileage;

  /// Редактируемая запись; `null` — новая.
  final ServiceRecord? record;
  final int? initialReminderId;

  @override
  ConsumerState<ServiceRecordForm> createState() => _ServiceRecordFormState();
}

class _ServiceRecordFormState extends ConsumerState<ServiceRecordForm> {
  static const _maxCost = 10000000.0;

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _mileage;
  late final TextEditingController _cost;
  late final TextEditingController _station;
  late final TextEditingController _comment;
  late DateTime _date;
  int? _reminderId;
  bool _saving = false;

  bool get _isNew => widget.record == null;

  @override
  void initState() {
    super.initState();
    final r = widget.record;
    final now = DateTime.now();
    _reminderId = r?.reminderId ?? _existingReminder(widget.initialReminderId);
    _title = TextEditingController(
      text: r?.title ?? _reminderTitle(_reminderId),
    );
    _mileage = TextEditingController(
      text: (r?.mileage ?? widget.currentMileage).toString(),
    );
    _cost = TextEditingController(
      text: r?.cost == null ? null : formatInput(r!.cost!),
    );
    _station = TextEditingController(text: r?.station);
    _comment = TextEditingController(text: r?.comment);
    _date = r?.date ?? DateTime(now.year, now.month, now.day);
  }

  int? _existingReminder(int? id) =>
      widget.reminders.any((r) => r.id == id) ? id : null;

  String? _reminderTitle(int? id) {
    for (final r in widget.reminders) {
      if (r.id == id) return r.title;
    }
    return null;
  }

  @override
  void dispose() {
    for (final c in [_title, _mileage, _cost, _station, _comment]) {
      c.dispose();
    }
    super.dispose();
  }

  void _onReminderChanged(int? id) {
    setState(() {
      // Название подставляется, если пользователь его ещё не менял.
      final previous = _reminderTitle(_reminderId);
      if (_title.text.trim().isEmpty || _title.text == previous) {
        _title.text = _reminderTitle(id) ?? '';
      }
      _reminderId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const gap = SizedBox(height: 16);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isNew ? l10n.serviceRecordNewTitle : l10n.serviceRecordEditTitle,
        ),
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
              if (widget.reminders.isNotEmpty) ...[
                DropdownButtonFormField<int?>(
                  key: const Key('record_reminder'),
                  initialValue: _reminderId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: l10n.serviceRecordReminder,
                    helperText: _reminderId == null
                        ? null
                        : l10n.serviceRecordReminderHint,
                    helperMaxLines: 2,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(l10n.serviceRecordNoReminder),
                    ),
                    for (final r in widget.reminders)
                      DropdownMenuItem(
                        value: r.id,
                        child: Text(r.title, overflow: TextOverflow.ellipsis),
                      ),
                  ],
                  onChanged: _onReminderChanged,
                ),
                gap,
              ],
              TextFormField(
                key: const Key('record_title'),
                controller: _title,
                decoration: InputDecoration(
                  labelText: '${l10n.serviceRecordTitle} *',
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? l10n.errorRequired : null,
              ),
              gap,
              DateField(
                key: const Key('record_date'),
                label: l10n.serviceRecordDate,
                date: _date,
                onChanged: (date) => setState(() => _date = date),
              ),
              gap,
              TextFormField(
                key: const Key('record_mileage'),
                controller: _mileage,
                decoration: InputDecoration(
                  labelText: '${l10n.serviceRecordMileage} *',
                  helperText: l10n.currentMileageHint(
                    formatInt(widget.currentMileage),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return l10n.errorRequired;
                  final n = parseInt(v);
                  if (n == null) return l10n.errorNotNumber;
                  if (n > CarValidators.maxMileage) {
                    return l10n.errorRange(
                      '0',
                      formatInt(CarValidators.maxMileage),
                    );
                  }
                  return null;
                },
              ),
              gap,
              TextFormField(
                key: const Key('record_cost'),
                controller: _cost,
                decoration: InputDecoration(
                  labelText: l10n.serviceRecordCost(currencySymbol),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                ],
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  final n = parseDecimal(v);
                  if (n == null) return l10n.errorNotNumber;
                  if (n < 0 || n > _maxCost) {
                    return l10n.errorRange('0', formatInt(_maxCost.toInt()));
                  }
                  return null;
                },
              ),
              gap,
              TextFormField(
                key: const Key('record_station'),
                controller: _station,
                decoration: InputDecoration(
                  labelText: l10n.serviceRecordStation,
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
              gap,
              TextFormField(
                key: const Key('record_comment'),
                controller: _comment,
                decoration: InputDecoration(
                  labelText: l10n.serviceRecordComment,
                ),
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              FilledButton(
                key: const Key('record_save'),
                onPressed: _saving ? null : _save,
                child: Text(l10n.save),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    String? optional(TextEditingController c) {
      final text = c.text.trim();
      return text.isEmpty ? null : text;
    }

    final draft = ServiceRecordDraft(
      carId: widget.carId,
      reminderId: _reminderId,
      title: _title.text.trim(),
      date: _date,
      mileage: parseInt(_mileage.text)!,
      cost: parseDecimal(_cost.text),
      station: optional(_station),
      comment: optional(_comment),
    );

    final repository = ref.read(serviceRepositoryProvider);
    try {
      if (_isNew) {
        await repository.add(draft);
        ref
            .read(analyticsHolderProvider)
            .log(AnalyticsEvent.serviceRecordAdded);
      } else {
        await repository.update(widget.record!.id, draft);
        ref.invalidate(serviceRecordProvider(widget.record!.id));
      }
      if (_reminderId != null) ref.invalidate(reminderProvider(_reminderId!));
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).serviceRecordSaveError),
        ),
      );
      return;
    }
    if (mounted) context.pop();
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await confirmDelete(
      context,
      title: l10n.serviceRecordDeleteTitle,
      message: l10n.serviceRecordDeleteMessage,
    );
    if (!confirmed) return;
    await ref.read(serviceRepositoryProvider).delete(widget.record!.id);
    if (mounted) context.pop();
  }
}
