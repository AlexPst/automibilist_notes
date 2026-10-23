import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/analytics/analytics.dart';
import '../../../core/analytics/analytics_providers.dart';

import 'package:go_router/go_router.dart';

import '../../../core/notifications/notification_providers.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/confirm_delete_dialog.dart';
import '../../../core/widgets/date_field.dart';
import '../../../data/data_providers.dart';
import '../../../data/models/reminder.dart';
import '../../../data/models/reminder_draft.dart';
import '../../../l10n/app_localizations.dart';
import '../../cars/application/cars_providers.dart';
import '../../cars/presentation/car_validators.dart';
import '../application/service_providers.dart';
import '../domain/reminder_status.dart';
import '../domain/reminder_templates.dart';
import 'reminder_texts.dart';

/// Экран добавления (`reminderId == null`) или редактирования напоминания.
class ReminderFormScreen extends ConsumerWidget {
  const ReminderFormScreen({super.key, this.reminderId, this.template});

  final int? reminderId;

  /// Шаблон для нового напоминания.
  final ReminderTemplate? template;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    if (reminderId == null) {
      final car = ref.watch(activeCarProvider);
      final mileage = car == null
          ? null
          : ref.watch(currentMileageProvider(car.id));
      if (car == null || mileage == null) return const _Loading();
      return ReminderForm(
        carId: car.id,
        currentMileage: mileage,
        template: template,
      );
    }

    final reminder = ref.watch(reminderProvider(reminderId!));
    return switch (reminder) {
      AsyncData(value: final r?) => ReminderForm(
        carId: r.carId,
        currentMileage: ref.watch(currentMileageProvider(r.carId)),
        reminder: r,
      ),
      AsyncData(value: null) => Scaffold(
        appBar: AppBar(title: Text(l10n.reminderEditTitle)),
        body: Center(child: Text(l10n.reminderNotFound)),
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

class ReminderForm extends ConsumerStatefulWidget {
  const ReminderForm({
    super.key,
    required this.carId,
    required this.currentMileage,
    this.reminder,
    this.template,
  });

  final int carId;
  final int? currentMileage;

  /// Редактируемое напоминание; `null` — новое.
  final Reminder? reminder;
  final ReminderTemplate? template;

  @override
  ConsumerState<ReminderForm> createState() => _ReminderFormState();
}

class _ReminderFormState extends ConsumerState<ReminderForm> {
  static const _advanceDayOptions = [0, 1, 3, 7, 14, 30];
  static const _advanceKmOptions = [100, 300, 500, 1000, 2000];
  static const _maxIntervalKm = 1000000;
  static const _maxIntervalMonths = 120;

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _intervalKm;
  late final TextEditingController _intervalMonths;
  late final TextEditingController _lastMileage;
  late DateTime _lastDate;
  late int _advanceDays;
  late int _advanceKm;
  bool _saving = false;

  bool get _isNew => widget.reminder == null;

  @override
  void initState() {
    super.initState();
    final r = widget.reminder;
    final t = widget.template;
    final now = DateTime.now();
    String? text(int? v) => v?.toString();

    _title = TextEditingController(text: r?.title);
    _intervalKm = TextEditingController(
      text: text(r?.intervalKm ?? t?.intervalKm),
    );
    _intervalMonths = TextEditingController(
      text: text(r?.intervalMonths ?? t?.intervalMonths),
    );
    _lastMileage = TextEditingController(
      text: text(r == null ? widget.currentMileage : r.lastDoneMileage),
    );
    _lastDate = r?.lastDoneDate ?? DateTime(now.year, now.month, now.day);
    _advanceDays = r?.advanceDays ?? t?.advanceDays ?? 7;
    _advanceKm = r?.advanceKm ?? 500;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Название шаблона берётся из локализации — нужен context.
    final t = widget.template;
    if (t != null && _title.text.isEmpty) {
      _title.text = templateTitle(AppLocalizations.of(context), t);
    }
  }

  @override
  void dispose() {
    for (final c in [_title, _intervalKm, _intervalMonths, _lastMileage]) {
      c.dispose();
    }
    super.dispose();
  }

  bool get _hasInterval =>
      parseInt(_intervalKm.text) != null ||
      parseInt(_intervalMonths.text) != null;

  String? _validateInterval(String? value, int max, AppLocalizations l10n) {
    if (!_hasInterval) return l10n.errorIntervalRequired;
    if (value == null || value.trim().isEmpty) return null;
    final number = parseInt(value);
    if (number == null) return l10n.errorNotNumber;
    if (number < 1 || number > max) {
      return l10n.errorRange('1', formatInt(max));
    }
    return null;
  }

  String? _validateLastMileage(String? value, AppLocalizations l10n) {
    final needed = parseInt(_intervalKm.text) != null;
    if (value == null || value.trim().isEmpty) {
      return needed ? l10n.errorMileageForKm : null;
    }
    final number = parseInt(value);
    if (number == null) return l10n.errorNotNumber;
    if (number > CarValidators.maxMileage) {
      return l10n.errorRange('0', formatInt(CarValidators.maxMileage));
    }
    return null;
  }

  ReminderDraft _draft() {
    return ReminderDraft(
      carId: widget.carId,
      title: _title.text.trim(),
      intervalKm: parseInt(_intervalKm.text),
      intervalMonths: parseInt(_intervalMonths.text),
      lastDoneDate: _lastDate,
      lastDoneMileage: parseInt(_lastMileage.text),
      advanceDays: _advanceDays,
      advanceKm: _advanceKm,
    );
  }

  /// «Следующий срок: 15 мар. 2027 г. или 26 000 км».
  String? _preview(AppLocalizations l10n) {
    final d = _draft();
    final months = d.intervalMonths;
    final km = d.intervalKm;
    final parts = [
      if (months != null && months > 0)
        formatDate(addMonths(d.lastDoneDate, months)),
      if (km != null && d.lastDoneMileage != null)
        l10n.mileageValue(formatInt(d.lastDoneMileage! + km)),
    ];
    return parts.isEmpty
        ? null
        : l10n.reminderNextDue(parts.join(l10n.reminderOr));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const gap = SizedBox(height: 16);
    final digits = [FilteringTextInputFormatter.digitsOnly];
    final preview = _preview(l10n);

    List<int> withCurrent(List<int> options, int current) =>
        options.contains(current) ? options : ([...options, current]..sort());

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? l10n.reminderNewTitle : l10n.reminderEditTitle),
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
              TextFormField(
                key: const Key('reminder_title'),
                controller: _title,
                decoration: InputDecoration(
                  labelText: '${l10n.reminderTitle} *',
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? l10n.errorRequired : null,
              ),
              gap,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      key: const Key('reminder_interval_km'),
                      controller: _intervalKm,
                      decoration: InputDecoration(
                        labelText: l10n.reminderIntervalKm,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: digits,
                      validator: (v) =>
                          _validateInterval(v, _maxIntervalKm, l10n),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      key: const Key('reminder_interval_months'),
                      controller: _intervalMonths,
                      decoration: InputDecoration(
                        labelText: l10n.reminderIntervalMonths,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: digits,
                      validator: (v) =>
                          _validateInterval(v, _maxIntervalMonths, l10n),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
                child: Text(
                  l10n.reminderIntervalHint,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              gap,
              DateField(
                key: const Key('reminder_last_date'),
                label: l10n.reminderLastDone,
                date: _lastDate,
                onChanged: (date) => setState(() => _lastDate = date),
              ),
              gap,
              TextFormField(
                key: const Key('reminder_last_mileage'),
                controller: _lastMileage,
                decoration: InputDecoration(
                  labelText: l10n.reminderLastDoneMileage,
                  helperText: widget.currentMileage == null
                      ? null
                      : l10n.currentMileageHint(
                          formatInt(widget.currentMileage!),
                        ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: digits,
                validator: (v) => _validateLastMileage(v, l10n),
                onChanged: (_) => setState(() {}),
              ),
              gap,
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      initialValue: _advanceDays,
                      decoration: InputDecoration(
                        labelText: l10n.reminderAdvanceDays,
                      ),
                      items: [
                        for (final d in withCurrent(
                          _advanceDayOptions,
                          _advanceDays,
                        ))
                          DropdownMenuItem(value: d, child: Text('$d')),
                      ],
                      onChanged: (v) => setState(() => _advanceDays = v!),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      initialValue: _advanceKm,
                      decoration: InputDecoration(
                        labelText: l10n.reminderAdvanceKm,
                      ),
                      items: [
                        for (final km in withCurrent(
                          _advanceKmOptions,
                          _advanceKm,
                        ))
                          DropdownMenuItem(
                            value: km,
                            child: Text(formatInt(km)),
                          ),
                      ],
                      onChanged: (v) => setState(() => _advanceKm = v!),
                    ),
                  ),
                ],
              ),
              if (preview != null) ...[
                gap,
                Text(
                  preview,
                  key: const Key('reminder_preview'),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
              const SizedBox(height: 24),
              FilledButton(
                key: const Key('reminder_save'),
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

    final repository = ref.read(remindersRepositoryProvider);
    try {
      final draft = _draft();
      if (_isNew) {
        await repository.add(draft);
        ref.read(analyticsHolderProvider).log(AnalyticsEvent.reminderAdded);
      } else {
        await repository.update(widget.reminder!.id, draft);
        ref.invalidate(reminderProvider(widget.reminder!.id));
      }
      // Без разрешения уведомления не придут (Android 13+).
      await ref.read(notificationServiceProvider).requestPermission();
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).reminderSaveError)),
      );
      return;
    }
    if (mounted) context.pop();
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await confirmDelete(
      context,
      title: l10n.reminderDeleteTitle,
      message: l10n.reminderDeleteMessage,
    );
    if (!confirmed) return;
    await ref.read(remindersRepositoryProvider).delete(widget.reminder!.id);
    if (mounted) context.pop();
  }
}
