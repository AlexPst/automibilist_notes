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
import '../../../data/models/expense.dart';
import '../../../data/models/expense_category.dart';
import '../../../data/models/expense_draft.dart';
import '../../../l10n/app_localizations.dart';
import '../../cars/application/cars_providers.dart';
import '../../cars/presentation/car_validators.dart';
import '../application/expenses_providers.dart';
import 'expense_category_ui.dart';

/// Экран добавления (`expenseId == null`) или редактирования расхода.
class ExpenseFormScreen extends ConsumerWidget {
  const ExpenseFormScreen({super.key, this.expenseId});

  final int? expenseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    if (expenseId == null) {
      final car = ref.watch(activeCarProvider);
      if (car == null) return const _Loading();
      return ExpenseForm(carId: car.id);
    }

    return switch (ref.watch(expenseProvider(expenseId!))) {
      AsyncData(value: final expense?) => ExpenseForm(
        carId: expense.carId,
        expense: expense,
      ),
      AsyncData(value: null) => Scaffold(
        appBar: AppBar(title: Text(l10n.expenseEditTitle)),
        body: Center(child: Text(l10n.expenseNotFound)),
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

class ExpenseForm extends ConsumerStatefulWidget {
  const ExpenseForm({super.key, required this.carId, this.expense});

  final int carId;

  /// Редактируемый расход; `null` — новый.
  final Expense? expense;

  @override
  ConsumerState<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends ConsumerState<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _amount;
  late final TextEditingController _mileage;
  late final TextEditingController _comment;
  late DateTime _date;
  ExpenseCategory? _category;
  bool _saving = false;

  bool get _isNew => widget.expense == null;

  static const _maxAmount = 10000000.0;

  @override
  void initState() {
    super.initState();
    final expense = widget.expense;
    final now = DateTime.now();
    _date = expense?.date ?? DateTime(now.year, now.month, now.day);
    _category = expense?.category;
    _amount = TextEditingController(
      text: expense == null ? null : formatInput(expense.amount),
    );
    _mileage = TextEditingController(text: expense?.mileage?.toString());
    _comment = TextEditingController(text: expense?.comment);
  }

  @override
  void dispose() {
    _amount.dispose();
    _mileage.dispose();
    _comment.dispose();
    super.dispose();
  }

  String? _validateAmount(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) return l10n.errorRequired;
    final amount = parseDecimal(value);
    if (amount == null) return l10n.errorNotNumber;
    if (amount <= 0) return l10n.errorPositive;
    if (amount > _maxAmount) {
      return l10n.errorRange('0', formatInt(_maxAmount.toInt()));
    }
    return null;
  }

  String? _validateMileage(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) return null;
    final mileage = parseInt(value);
    if (mileage == null) return l10n.errorNotNumber;
    if (mileage > CarValidators.maxMileage) {
      return l10n.errorRange('0', formatInt(CarValidators.maxMileage));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const gap = SizedBox(height: 16);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? l10n.expenseNewTitle : l10n.expenseEditTitle),
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
                key: const Key('expense_date'),
                label: l10n.expenseDate,
                date: _date,
                onChanged: (date) => setState(() => _date = date),
              ),
              gap,
              DropdownButtonFormField<ExpenseCategory>(
                key: const Key('expense_category'),
                initialValue: _category,
                decoration: InputDecoration(
                  labelText: '${l10n.expenseCategory} *',
                ),
                items: [
                  for (final category in ExpenseCategory.values)
                    DropdownMenuItem(
                      value: category,
                      child: Row(
                        children: [
                          Icon(expenseCategoryIcon(category), size: 20),
                          const SizedBox(width: 12),
                          Text(expenseCategoryLabel(l10n, category)),
                        ],
                      ),
                    ),
                ],
                validator: (value) => value == null ? l10n.errorRequired : null,
                onChanged: (value) => setState(() => _category = value),
              ),
              gap,
              TextFormField(
                key: const Key('expense_amount'),
                controller: _amount,
                decoration: InputDecoration(
                  labelText: '${l10n.expenseAmount(currencySymbol)} *',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                ],
                textInputAction: TextInputAction.next,
                validator: (value) => _validateAmount(value, l10n),
              ),
              gap,
              TextFormField(
                key: const Key('expense_mileage'),
                controller: _mileage,
                decoration: InputDecoration(labelText: l10n.expenseMileage),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
                validator: (value) => _validateMileage(value, l10n),
              ),
              gap,
              TextFormField(
                key: const Key('expense_comment'),
                controller: _comment,
                decoration: InputDecoration(labelText: l10n.expenseComment),
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              FilledButton(
                key: const Key('expense_save'),
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

    final comment = _comment.text.trim();
    final draft = ExpenseDraft(
      carId: widget.carId,
      date: _date,
      category: _category!,
      amount: parseDecimal(_amount.text)!,
      mileage: parseInt(_mileage.text),
      comment: comment.isEmpty ? null : comment,
    );

    final repository = ref.read(expensesRepositoryProvider);
    try {
      if (_isNew) {
        await repository.add(draft);
        ref.read(analyticsHolderProvider).log(AnalyticsEvent.expenseAdded);
      } else {
        await repository.update(widget.expense!.id, draft);
        ref.invalidate(expenseProvider(widget.expense!.id));
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).expenseSaveError)),
      );
      return;
    }
    if (mounted) context.pop();
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await confirmDelete(
      context,
      title: l10n.expenseDeleteTitle,
      message: l10n.expenseDeleteMessage,
    );
    if (!confirmed) return;
    await ref.read(expensesRepositoryProvider).delete(widget.expense!.id);
    if (mounted) context.pop();
  }
}
