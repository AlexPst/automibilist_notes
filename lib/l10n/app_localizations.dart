import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ru')];

  /// No description provided for @appTitle.
  ///
  /// In ru, this message translates to:
  /// **'Дневник автомобилиста'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In ru, this message translates to:
  /// **'Главная'**
  String get navHome;

  /// No description provided for @navFuel.
  ///
  /// In ru, this message translates to:
  /// **'Заправки'**
  String get navFuel;

  /// No description provided for @navExpenses.
  ///
  /// In ru, this message translates to:
  /// **'Расходы'**
  String get navExpenses;

  /// No description provided for @navService.
  ///
  /// In ru, this message translates to:
  /// **'ТО'**
  String get navService;

  /// No description provided for @navStats.
  ///
  /// In ru, this message translates to:
  /// **'Статистика'**
  String get navStats;

  /// No description provided for @homeTitle.
  ///
  /// In ru, this message translates to:
  /// **'Главная'**
  String get homeTitle;

  /// No description provided for @fuelTitle.
  ///
  /// In ru, this message translates to:
  /// **'Заправки'**
  String get fuelTitle;

  /// No description provided for @expensesTitle.
  ///
  /// In ru, this message translates to:
  /// **'Расходы'**
  String get expensesTitle;

  /// No description provided for @serviceTitle.
  ///
  /// In ru, this message translates to:
  /// **'ТО и напоминания'**
  String get serviceTitle;

  /// No description provided for @statsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Статистика'**
  String get statsTitle;

  /// No description provided for @placeholderSoon.
  ///
  /// In ru, this message translates to:
  /// **'Раздел появится в следующих версиях'**
  String get placeholderSoon;

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In ru, this message translates to:
  /// **'Изменить'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// No description provided for @carsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Автомобили'**
  String get carsTitle;

  /// No description provided for @carsManage.
  ///
  /// In ru, this message translates to:
  /// **'Управление автомобилями'**
  String get carsManage;

  /// No description provided for @carSelect.
  ///
  /// In ru, this message translates to:
  /// **'Выбрать автомобиль'**
  String get carSelect;

  /// No description provided for @carAdd.
  ///
  /// In ru, this message translates to:
  /// **'Добавить автомобиль'**
  String get carAdd;

  /// No description provided for @carNewTitle.
  ///
  /// In ru, this message translates to:
  /// **'Новый автомобиль'**
  String get carNewTitle;

  /// No description provided for @carEditTitle.
  ///
  /// In ru, this message translates to:
  /// **'Редактирование'**
  String get carEditTitle;

  /// No description provided for @carNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Автомобиль не найден'**
  String get carNotFound;

  /// No description provided for @carActive.
  ///
  /// In ru, this message translates to:
  /// **'Активный'**
  String get carActive;

  /// No description provided for @carDeleteTitle.
  ///
  /// In ru, this message translates to:
  /// **'Удалить автомобиль?'**
  String get carDeleteTitle;

  /// No description provided for @carDeleteMessage.
  ///
  /// In ru, this message translates to:
  /// **'«{name}» и все его записи будут удалены без возможности восстановления.'**
  String carDeleteMessage(String name);

  /// No description provided for @carSaveError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось сохранить автомобиль'**
  String get carSaveError;

  /// No description provided for @onboardingTitle.
  ///
  /// In ru, this message translates to:
  /// **'Добавьте первый автомобиль'**
  String get onboardingTitle;

  /// No description provided for @onboardingText.
  ///
  /// In ru, this message translates to:
  /// **'Укажите марку, модель и пробег — и можно вести учёт заправок, расходов и ТО.'**
  String get onboardingText;

  /// No description provided for @carBrand.
  ///
  /// In ru, this message translates to:
  /// **'Марка'**
  String get carBrand;

  /// No description provided for @carModel.
  ///
  /// In ru, this message translates to:
  /// **'Модель'**
  String get carModel;

  /// No description provided for @carYear.
  ///
  /// In ru, this message translates to:
  /// **'Год выпуска'**
  String get carYear;

  /// No description provided for @carPlate.
  ///
  /// In ru, this message translates to:
  /// **'Госномер'**
  String get carPlate;

  /// No description provided for @carFuelType.
  ///
  /// In ru, this message translates to:
  /// **'Тип топлива'**
  String get carFuelType;

  /// No description provided for @carTankVolume.
  ///
  /// In ru, this message translates to:
  /// **'Объём бака, л'**
  String get carTankVolume;

  /// No description provided for @carInitialMileage.
  ///
  /// In ru, this message translates to:
  /// **'Начальный пробег, км'**
  String get carInitialMileage;

  /// No description provided for @carInitialMileageValue.
  ///
  /// In ru, this message translates to:
  /// **'Начальный пробег: {value} км'**
  String carInitialMileageValue(String value);

  /// No description provided for @carTankVolumeValue.
  ///
  /// In ru, this message translates to:
  /// **'Бак {value} л'**
  String carTankVolumeValue(String value);

  /// No description provided for @carYearValue.
  ///
  /// In ru, this message translates to:
  /// **'{year} г.'**
  String carYearValue(String year);

  /// No description provided for @photoFromCamera.
  ///
  /// In ru, this message translates to:
  /// **'Сделать снимок'**
  String get photoFromCamera;

  /// No description provided for @photoFromGallery.
  ///
  /// In ru, this message translates to:
  /// **'Выбрать из галереи'**
  String get photoFromGallery;

  /// No description provided for @photoRemove.
  ///
  /// In ru, this message translates to:
  /// **'Удалить фото'**
  String get photoRemove;

  /// No description provided for @photoPickError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось получить фото'**
  String get photoPickError;

  /// No description provided for @photoHint.
  ///
  /// In ru, this message translates to:
  /// **'Нажмите, чтобы добавить фото'**
  String get photoHint;

  /// No description provided for @errorRequired.
  ///
  /// In ru, this message translates to:
  /// **'Обязательное поле'**
  String get errorRequired;

  /// No description provided for @errorTooLong.
  ///
  /// In ru, this message translates to:
  /// **'Не длиннее {max} символов'**
  String errorTooLong(int max);

  /// No description provided for @errorNotNumber.
  ///
  /// In ru, this message translates to:
  /// **'Введите число'**
  String get errorNotNumber;

  /// No description provided for @errorRange.
  ///
  /// In ru, this message translates to:
  /// **'Допустимо от {min} до {max}'**
  String errorRange(String min, String max);

  /// No description provided for @fuelAi92.
  ///
  /// In ru, this message translates to:
  /// **'АИ-92'**
  String get fuelAi92;

  /// No description provided for @fuelAi95.
  ///
  /// In ru, this message translates to:
  /// **'АИ-95'**
  String get fuelAi95;

  /// No description provided for @fuelAi98.
  ///
  /// In ru, this message translates to:
  /// **'АИ-98'**
  String get fuelAi98;

  /// No description provided for @fuelAi100.
  ///
  /// In ru, this message translates to:
  /// **'АИ-100'**
  String get fuelAi100;

  /// No description provided for @fuelDiesel.
  ///
  /// In ru, this message translates to:
  /// **'Дизель'**
  String get fuelDiesel;

  /// No description provided for @fuelLpg.
  ///
  /// In ru, this message translates to:
  /// **'Газ (пропан)'**
  String get fuelLpg;

  /// No description provided for @fuelCng.
  ///
  /// In ru, this message translates to:
  /// **'Метан'**
  String get fuelCng;

  /// No description provided for @fuelEmptyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Пока нет заправок'**
  String get fuelEmptyTitle;

  /// No description provided for @fuelEmptyText.
  ///
  /// In ru, this message translates to:
  /// **'Нажмите «+», чтобы добавить первую заправку'**
  String get fuelEmptyText;

  /// No description provided for @fuelAdd.
  ///
  /// In ru, this message translates to:
  /// **'Добавить заправку'**
  String get fuelAdd;

  /// No description provided for @fuelNewTitle.
  ///
  /// In ru, this message translates to:
  /// **'Новая заправка'**
  String get fuelNewTitle;

  /// No description provided for @fuelEditTitle.
  ///
  /// In ru, this message translates to:
  /// **'Заправка'**
  String get fuelEditTitle;

  /// No description provided for @fuelNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Запись не найдена'**
  String get fuelNotFound;

  /// No description provided for @fuelSaveError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось сохранить заправку'**
  String get fuelSaveError;

  /// No description provided for @fuelDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата'**
  String get fuelDate;

  /// No description provided for @fuelMileage.
  ///
  /// In ru, this message translates to:
  /// **'Пробег, км'**
  String get fuelMileage;

  /// No description provided for @fuelLiters.
  ///
  /// In ru, this message translates to:
  /// **'Литры'**
  String get fuelLiters;

  /// No description provided for @fuelPrice.
  ///
  /// In ru, this message translates to:
  /// **'Цена за литр, {currency}'**
  String fuelPrice(String currency);

  /// No description provided for @fuelTotal.
  ///
  /// In ru, this message translates to:
  /// **'Сумма, {currency}'**
  String fuelTotal(String currency);

  /// No description provided for @fuelAutoCalcHint.
  ///
  /// In ru, this message translates to:
  /// **'Заполните любые два поля — третье посчитается само'**
  String get fuelAutoCalcHint;

  /// No description provided for @fuelFullTank.
  ///
  /// In ru, this message translates to:
  /// **'Полный бак'**
  String get fuelFullTank;

  /// No description provided for @fuelFullTankHint.
  ///
  /// In ru, this message translates to:
  /// **'Заправились до полного — нужно для расчёта расхода'**
  String get fuelFullTankHint;

  /// No description provided for @fuelStation.
  ///
  /// In ru, this message translates to:
  /// **'АЗС'**
  String get fuelStation;

  /// No description provided for @fuelComment.
  ///
  /// In ru, this message translates to:
  /// **'Комментарий'**
  String get fuelComment;

  /// No description provided for @fuelDeleteTitle.
  ///
  /// In ru, this message translates to:
  /// **'Удалить заправку?'**
  String get fuelDeleteTitle;

  /// No description provided for @fuelDeleteMessage.
  ///
  /// In ru, this message translates to:
  /// **'Запись будет удалена без возможности восстановления.'**
  String get fuelDeleteMessage;

  /// No description provided for @fuelPartial.
  ///
  /// In ru, this message translates to:
  /// **'Неполный бак'**
  String get fuelPartial;

  /// No description provided for @fuelAvgConsumption.
  ///
  /// In ru, this message translates to:
  /// **'Средний расход'**
  String get fuelAvgConsumption;

  /// No description provided for @fuelAvgConsumptionEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Появится после двух заправок до полного бака'**
  String get fuelAvgConsumptionEmpty;

  /// No description provided for @consumptionValue.
  ///
  /// In ru, this message translates to:
  /// **'{value} {unit}'**
  String consumptionValue(String value, String unit);

  /// No description provided for @mileageValue.
  ///
  /// In ru, this message translates to:
  /// **'{value} км'**
  String mileageValue(String value);

  /// No description provided for @fuelMileageMinHint.
  ///
  /// In ru, this message translates to:
  /// **'Не меньше {value} км'**
  String fuelMileageMinHint(String value);

  /// No description provided for @errorMileageBelowInitial.
  ///
  /// In ru, this message translates to:
  /// **'Меньше начального пробега авто ({value} км)'**
  String errorMileageBelowInitial(String value);

  /// No description provided for @errorMileageBelowPrevious.
  ///
  /// In ru, this message translates to:
  /// **'Меньше, чем в более ранней записи ({value} км)'**
  String errorMileageBelowPrevious(String value);

  /// No description provided for @errorMileageAboveNext.
  ///
  /// In ru, this message translates to:
  /// **'Больше, чем в более поздней записи ({value} км)'**
  String errorMileageAboveNext(String value);

  /// No description provided for @errorPositive.
  ///
  /// In ru, this message translates to:
  /// **'Должно быть больше нуля'**
  String get errorPositive;

  /// No description provided for @fuelLitersLine.
  ///
  /// In ru, this message translates to:
  /// **'{liters} л × {price}'**
  String fuelLitersLine(String liters, String price);

  /// No description provided for @expensesEmptyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Пока нет расходов'**
  String get expensesEmptyTitle;

  /// No description provided for @expensesEmptyText.
  ///
  /// In ru, this message translates to:
  /// **'Нажмите «+», чтобы добавить мойку, ремонт, страховку и другие траты'**
  String get expensesEmptyText;

  /// No description provided for @expensesNothingFound.
  ///
  /// In ru, this message translates to:
  /// **'Нет расходов по выбранному фильтру'**
  String get expensesNothingFound;

  /// No description provided for @expensesResetFilter.
  ///
  /// In ru, this message translates to:
  /// **'Сбросить фильтр'**
  String get expensesResetFilter;

  /// No description provided for @expenseAdd.
  ///
  /// In ru, this message translates to:
  /// **'Добавить расход'**
  String get expenseAdd;

  /// No description provided for @expenseNewTitle.
  ///
  /// In ru, this message translates to:
  /// **'Новый расход'**
  String get expenseNewTitle;

  /// No description provided for @expenseEditTitle.
  ///
  /// In ru, this message translates to:
  /// **'Расход'**
  String get expenseEditTitle;

  /// No description provided for @expenseNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Запись не найдена'**
  String get expenseNotFound;

  /// No description provided for @expenseSaveError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось сохранить расход'**
  String get expenseSaveError;

  /// No description provided for @expenseDeleteTitle.
  ///
  /// In ru, this message translates to:
  /// **'Удалить расход?'**
  String get expenseDeleteTitle;

  /// No description provided for @expenseDeleteMessage.
  ///
  /// In ru, this message translates to:
  /// **'Запись будет удалена без возможности восстановления.'**
  String get expenseDeleteMessage;

  /// No description provided for @expenseDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата'**
  String get expenseDate;

  /// No description provided for @expenseCategory.
  ///
  /// In ru, this message translates to:
  /// **'Категория'**
  String get expenseCategory;

  /// No description provided for @expenseAmount.
  ///
  /// In ru, this message translates to:
  /// **'Сумма, {currency}'**
  String expenseAmount(String currency);

  /// No description provided for @expenseMileage.
  ///
  /// In ru, this message translates to:
  /// **'Пробег, км'**
  String get expenseMileage;

  /// No description provided for @expenseComment.
  ///
  /// In ru, this message translates to:
  /// **'Комментарий'**
  String get expenseComment;

  /// No description provided for @expensesTotal.
  ///
  /// In ru, this message translates to:
  /// **'Итого'**
  String get expensesTotal;

  /// No description provided for @expensesCount.
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, one{{count} запись} few{{count} записи} many{{count} записей} other{{count} записи}}'**
  String expensesCount(int count);

  /// No description provided for @periodAll.
  ///
  /// In ru, this message translates to:
  /// **'Всё время'**
  String get periodAll;

  /// No description provided for @periodMonth.
  ///
  /// In ru, this message translates to:
  /// **'Этот месяц'**
  String get periodMonth;

  /// No description provided for @periodYear.
  ///
  /// In ru, this message translates to:
  /// **'Этот год'**
  String get periodYear;

  /// No description provided for @periodCustom.
  ///
  /// In ru, this message translates to:
  /// **'Период…'**
  String get periodCustom;

  /// No description provided for @periodRange.
  ///
  /// In ru, this message translates to:
  /// **'{from} – {to}'**
  String periodRange(String from, String to);

  /// No description provided for @categoryWash.
  ///
  /// In ru, this message translates to:
  /// **'Мойка'**
  String get categoryWash;

  /// No description provided for @categoryRepair.
  ///
  /// In ru, this message translates to:
  /// **'Ремонт'**
  String get categoryRepair;

  /// No description provided for @categoryParts.
  ///
  /// In ru, this message translates to:
  /// **'Запчасти'**
  String get categoryParts;

  /// No description provided for @categoryInsurance.
  ///
  /// In ru, this message translates to:
  /// **'Страховка'**
  String get categoryInsurance;

  /// No description provided for @categoryFines.
  ///
  /// In ru, this message translates to:
  /// **'Штрафы'**
  String get categoryFines;

  /// No description provided for @categoryParking.
  ///
  /// In ru, this message translates to:
  /// **'Парковка'**
  String get categoryParking;

  /// No description provided for @categoryTax.
  ///
  /// In ru, this message translates to:
  /// **'Налог'**
  String get categoryTax;

  /// No description provided for @categoryOther.
  ///
  /// In ru, this message translates to:
  /// **'Другое'**
  String get categoryOther;

  /// No description provided for @serviceTabReminders.
  ///
  /// In ru, this message translates to:
  /// **'Напоминания'**
  String get serviceTabReminders;

  /// No description provided for @serviceTabHistory.
  ///
  /// In ru, this message translates to:
  /// **'История'**
  String get serviceTabHistory;

  /// No description provided for @remindersEmptyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Нет напоминаний'**
  String get remindersEmptyTitle;

  /// No description provided for @remindersEmptyText.
  ///
  /// In ru, this message translates to:
  /// **'Добавьте напоминание о замене масла, ОСАГО или смене резины — приложение подскажет, когда пора'**
  String get remindersEmptyText;

  /// No description provided for @historyEmptyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Нет записей ТО'**
  String get historyEmptyTitle;

  /// No description provided for @historyEmptyText.
  ///
  /// In ru, this message translates to:
  /// **'Записывайте сюда выполненные работы: замену масла, фильтров, ремонт'**
  String get historyEmptyText;

  /// No description provided for @reminderAdd.
  ///
  /// In ru, this message translates to:
  /// **'Добавить напоминание'**
  String get reminderAdd;

  /// No description provided for @reminderCustom.
  ///
  /// In ru, this message translates to:
  /// **'Своё напоминание'**
  String get reminderCustom;

  /// No description provided for @reminderNewTitle.
  ///
  /// In ru, this message translates to:
  /// **'Новое напоминание'**
  String get reminderNewTitle;

  /// No description provided for @reminderEditTitle.
  ///
  /// In ru, this message translates to:
  /// **'Напоминание'**
  String get reminderEditTitle;

  /// No description provided for @reminderNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Напоминание не найдено'**
  String get reminderNotFound;

  /// No description provided for @reminderTitle.
  ///
  /// In ru, this message translates to:
  /// **'Вид работ'**
  String get reminderTitle;

  /// No description provided for @reminderIntervalKm.
  ///
  /// In ru, this message translates to:
  /// **'Каждые, км'**
  String get reminderIntervalKm;

  /// No description provided for @reminderIntervalMonths.
  ///
  /// In ru, this message translates to:
  /// **'Каждые, мес.'**
  String get reminderIntervalMonths;

  /// No description provided for @reminderIntervalHint.
  ///
  /// In ru, this message translates to:
  /// **'Заполните пробег, срок или оба — сработает то, что наступит раньше'**
  String get reminderIntervalHint;

  /// No description provided for @reminderLastDone.
  ///
  /// In ru, this message translates to:
  /// **'Последний раз — дата'**
  String get reminderLastDone;

  /// No description provided for @reminderLastDoneMileage.
  ///
  /// In ru, this message translates to:
  /// **'Последний раз — пробег, км'**
  String get reminderLastDoneMileage;

  /// No description provided for @reminderAdvanceDays.
  ///
  /// In ru, this message translates to:
  /// **'Предупредить за, дней'**
  String get reminderAdvanceDays;

  /// No description provided for @reminderAdvanceKm.
  ///
  /// In ru, this message translates to:
  /// **'Предупредить за, км'**
  String get reminderAdvanceKm;

  /// No description provided for @reminderNextDue.
  ///
  /// In ru, this message translates to:
  /// **'Следующий срок: {due}'**
  String reminderNextDue(String due);

  /// No description provided for @reminderDeleteTitle.
  ///
  /// In ru, this message translates to:
  /// **'Удалить напоминание?'**
  String get reminderDeleteTitle;

  /// No description provided for @reminderDeleteMessage.
  ///
  /// In ru, this message translates to:
  /// **'Записи ТО останутся в истории.'**
  String get reminderDeleteMessage;

  /// No description provided for @reminderDone.
  ///
  /// In ru, this message translates to:
  /// **'Выполнено'**
  String get reminderDone;

  /// No description provided for @reminderSaveError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось сохранить напоминание'**
  String get reminderSaveError;

  /// No description provided for @reminderEveryKm.
  ///
  /// In ru, this message translates to:
  /// **'каждые {km} км'**
  String reminderEveryKm(String km);

  /// No description provided for @reminderEveryMonths.
  ///
  /// In ru, this message translates to:
  /// **'каждые {months} мес.'**
  String reminderEveryMonths(String months);

  /// No description provided for @reminderOr.
  ///
  /// In ru, this message translates to:
  /// **' или '**
  String get reminderOr;

  /// No description provided for @errorIntervalRequired.
  ///
  /// In ru, this message translates to:
  /// **'Укажите интервал в км или месяцах'**
  String get errorIntervalRequired;

  /// No description provided for @errorMileageForKm.
  ///
  /// In ru, this message translates to:
  /// **'Нужен для интервала по пробегу'**
  String get errorMileageForKm;

  /// No description provided for @dueInDays.
  ///
  /// In ru, this message translates to:
  /// **'через {count, plural, one{{count} день} few{{count} дня} many{{count} дней} other{{count} дня}}'**
  String dueInDays(int count);

  /// No description provided for @dueToday.
  ///
  /// In ru, this message translates to:
  /// **'сегодня'**
  String get dueToday;

  /// No description provided for @overdueDays.
  ///
  /// In ru, this message translates to:
  /// **'просрочено на {count, plural, one{{count} день} few{{count} дня} many{{count} дней} other{{count} дня}}'**
  String overdueDays(int count);

  /// No description provided for @dueInKm.
  ///
  /// In ru, this message translates to:
  /// **'через {km} км'**
  String dueInKm(String km);

  /// No description provided for @dueNowKm.
  ///
  /// In ru, this message translates to:
  /// **'пора'**
  String get dueNowKm;

  /// No description provided for @overdueKm.
  ///
  /// In ru, this message translates to:
  /// **'просрочено на {km} км'**
  String overdueKm(String km);

  /// No description provided for @notificationChannelName.
  ///
  /// In ru, this message translates to:
  /// **'Напоминания'**
  String get notificationChannelName;

  /// No description provided for @notificationChannelDescription.
  ///
  /// In ru, this message translates to:
  /// **'Сроки ТО, страховки и смены резины'**
  String get notificationChannelDescription;

  /// No description provided for @notifSoonTitle.
  ///
  /// In ru, this message translates to:
  /// **'Скоро: {title}'**
  String notifSoonTitle(String title);

  /// No description provided for @notifDueTitle.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня срок: {title}'**
  String notifDueTitle(String title);

  /// No description provided for @notifMileageDueTitle.
  ///
  /// In ru, this message translates to:
  /// **'Пора: {title}'**
  String notifMileageDueTitle(String title);

  /// No description provided for @notifDateBody.
  ///
  /// In ru, this message translates to:
  /// **'{car} · срок {date}'**
  String notifDateBody(String car, String date);

  /// No description provided for @notifMileageBody.
  ///
  /// In ru, this message translates to:
  /// **'{car} · срок {due} км, сейчас {current} км'**
  String notifMileageBody(String car, String due, String current);

  /// No description provided for @notifTestTitle.
  ///
  /// In ru, this message translates to:
  /// **'Проверка уведомлений'**
  String get notifTestTitle;

  /// No description provided for @notifTestBody.
  ///
  /// In ru, this message translates to:
  /// **'Если вы видите это сообщение — уведомления работают'**
  String get notifTestBody;

  /// No description provided for @notifTestMenu.
  ///
  /// In ru, this message translates to:
  /// **'Тестовое уведомление через 1 минуту'**
  String get notifTestMenu;

  /// No description provided for @notifTestScheduled.
  ///
  /// In ru, this message translates to:
  /// **'Уведомление придёт примерно через минуту'**
  String get notifTestScheduled;

  /// No description provided for @mileageAlertSnack.
  ///
  /// In ru, this message translates to:
  /// **'Подходит срок: {titles}'**
  String mileageAlertSnack(String titles);

  /// No description provided for @open.
  ///
  /// In ru, this message translates to:
  /// **'Открыть'**
  String get open;

  /// No description provided for @serviceRecordAdd.
  ///
  /// In ru, this message translates to:
  /// **'Добавить запись ТО'**
  String get serviceRecordAdd;

  /// No description provided for @serviceRecordNewTitle.
  ///
  /// In ru, this message translates to:
  /// **'Новая запись ТО'**
  String get serviceRecordNewTitle;

  /// No description provided for @serviceRecordEditTitle.
  ///
  /// In ru, this message translates to:
  /// **'Запись ТО'**
  String get serviceRecordEditTitle;

  /// No description provided for @serviceRecordNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Запись не найдена'**
  String get serviceRecordNotFound;

  /// No description provided for @serviceRecordReminder.
  ///
  /// In ru, this message translates to:
  /// **'Напоминание'**
  String get serviceRecordReminder;

  /// No description provided for @serviceRecordNoReminder.
  ///
  /// In ru, this message translates to:
  /// **'Без напоминания'**
  String get serviceRecordNoReminder;

  /// No description provided for @serviceRecordReminderHint.
  ///
  /// In ru, this message translates to:
  /// **'Следующий срок напоминания посчитается от этой записи'**
  String get serviceRecordReminderHint;

  /// No description provided for @serviceRecordTitle.
  ///
  /// In ru, this message translates to:
  /// **'Вид работ'**
  String get serviceRecordTitle;

  /// No description provided for @serviceRecordDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата'**
  String get serviceRecordDate;

  /// No description provided for @serviceRecordMileage.
  ///
  /// In ru, this message translates to:
  /// **'Пробег, км'**
  String get serviceRecordMileage;

  /// No description provided for @serviceRecordCost.
  ///
  /// In ru, this message translates to:
  /// **'Стоимость, {currency}'**
  String serviceRecordCost(String currency);

  /// No description provided for @serviceRecordStation.
  ///
  /// In ru, this message translates to:
  /// **'СТО'**
  String get serviceRecordStation;

  /// No description provided for @serviceRecordComment.
  ///
  /// In ru, this message translates to:
  /// **'Комментарий'**
  String get serviceRecordComment;

  /// No description provided for @serviceRecordDeleteTitle.
  ///
  /// In ru, this message translates to:
  /// **'Удалить запись ТО?'**
  String get serviceRecordDeleteTitle;

  /// No description provided for @serviceRecordDeleteMessage.
  ///
  /// In ru, this message translates to:
  /// **'Запись будет удалена без возможности восстановления. Срок напоминания не изменится.'**
  String get serviceRecordDeleteMessage;

  /// No description provided for @serviceRecordSaveError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось сохранить запись'**
  String get serviceRecordSaveError;

  /// No description provided for @currentMileageHint.
  ///
  /// In ru, this message translates to:
  /// **'Текущий пробег: {value} км'**
  String currentMileageHint(String value);

  /// No description provided for @templateOil.
  ///
  /// In ru, this message translates to:
  /// **'Замена масла'**
  String get templateOil;

  /// No description provided for @templateAirFilter.
  ///
  /// In ru, this message translates to:
  /// **'Воздушный фильтр'**
  String get templateAirFilter;

  /// No description provided for @templateCabinFilter.
  ///
  /// In ru, this message translates to:
  /// **'Салонный фильтр'**
  String get templateCabinFilter;

  /// No description provided for @templateFuelFilter.
  ///
  /// In ru, this message translates to:
  /// **'Топливный фильтр'**
  String get templateFuelFilter;

  /// No description provided for @templateOsago.
  ///
  /// In ru, this message translates to:
  /// **'ОСАГО'**
  String get templateOsago;

  /// No description provided for @templateInspection.
  ///
  /// In ru, this message translates to:
  /// **'Техосмотр'**
  String get templateInspection;

  /// No description provided for @templateSummerTyres.
  ///
  /// In ru, this message translates to:
  /// **'Летняя резина'**
  String get templateSummerTyres;

  /// No description provided for @templateWinterTyres.
  ///
  /// In ru, this message translates to:
  /// **'Зимняя резина'**
  String get templateWinterTyres;

  /// No description provided for @loading.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка…'**
  String get loading;

  /// No description provided for @homeMileage.
  ///
  /// In ru, this message translates to:
  /// **'Пробег'**
  String get homeMileage;

  /// No description provided for @homeAvgConsumption.
  ///
  /// In ru, this message translates to:
  /// **'Средний расход'**
  String get homeAvgConsumption;

  /// No description provided for @homeMonthSpending.
  ///
  /// In ru, this message translates to:
  /// **'Расходы за {month}'**
  String homeMonthSpending(String month);

  /// No description provided for @homeFuel.
  ///
  /// In ru, this message translates to:
  /// **'Топливо'**
  String get homeFuel;

  /// No description provided for @homeService.
  ///
  /// In ru, this message translates to:
  /// **'ТО'**
  String get homeService;

  /// No description provided for @homeOtherExpenses.
  ///
  /// In ru, this message translates to:
  /// **'Прочие расходы'**
  String get homeOtherExpenses;

  /// No description provided for @homeUpcoming.
  ///
  /// In ru, this message translates to:
  /// **'Ближайшие напоминания'**
  String get homeUpcoming;

  /// No description provided for @homeNoReminders.
  ///
  /// In ru, this message translates to:
  /// **'Напоминаний пока нет'**
  String get homeNoReminders;

  /// No description provided for @homeAllReminders.
  ///
  /// In ru, this message translates to:
  /// **'Все напоминания'**
  String get homeAllReminders;

  /// No description provided for @noValue.
  ///
  /// In ru, this message translates to:
  /// **'—'**
  String get noValue;

  /// No description provided for @statsPeriodMonth.
  ///
  /// In ru, this message translates to:
  /// **'Месяц'**
  String get statsPeriodMonth;

  /// No description provided for @statsPeriodYear.
  ///
  /// In ru, this message translates to:
  /// **'Год'**
  String get statsPeriodYear;

  /// No description provided for @statsPeriodAll.
  ///
  /// In ru, this message translates to:
  /// **'Всё время'**
  String get statsPeriodAll;

  /// No description provided for @statsTotal.
  ///
  /// In ru, this message translates to:
  /// **'Всего потрачено'**
  String get statsTotal;

  /// No description provided for @statsDistance.
  ///
  /// In ru, this message translates to:
  /// **'Пробег за период'**
  String get statsDistance;

  /// No description provided for @statsCostPerKm.
  ///
  /// In ru, this message translates to:
  /// **'Стоимость 1 км'**
  String get statsCostPerKm;

  /// No description provided for @statsFuelCostPerKm.
  ///
  /// In ru, this message translates to:
  /// **'из них топливо {value}'**
  String statsFuelCostPerKm(String value);

  /// No description provided for @costPerKmValue.
  ///
  /// In ru, this message translates to:
  /// **'{value}/км'**
  String costPerKmValue(String value);

  /// No description provided for @statsByCategory.
  ///
  /// In ru, this message translates to:
  /// **'По категориям'**
  String get statsByCategory;

  /// No description provided for @statsByMonth.
  ///
  /// In ru, this message translates to:
  /// **'По месяцам'**
  String get statsByMonth;

  /// No description provided for @statsConsumption.
  ///
  /// In ru, this message translates to:
  /// **'Расход топлива, {unit}'**
  String statsConsumption(String unit);

  /// No description provided for @statsAvgForPeriod.
  ///
  /// In ru, this message translates to:
  /// **'Средний за период: {value}'**
  String statsAvgForPeriod(String value);

  /// No description provided for @statsConsumptionEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Появится после двух заправок до полного бака'**
  String get statsConsumptionEmpty;

  /// No description provided for @statsEmptyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Нет данных за период'**
  String get statsEmptyTitle;

  /// No description provided for @statsEmptyText.
  ///
  /// In ru, this message translates to:
  /// **'Добавьте заправки или расходы — здесь появятся графики'**
  String get statsEmptyText;

  /// No description provided for @statsCatFuel.
  ///
  /// In ru, this message translates to:
  /// **'Топливо'**
  String get statsCatFuel;

  /// No description provided for @statsCatService.
  ///
  /// In ru, this message translates to:
  /// **'ТО'**
  String get statsCatService;

  /// No description provided for @statsCatRepair.
  ///
  /// In ru, this message translates to:
  /// **'Ремонт и запчасти'**
  String get statsCatRepair;

  /// No description provided for @statsCatInsurance.
  ///
  /// In ru, this message translates to:
  /// **'Страховка'**
  String get statsCatInsurance;

  /// No description provided for @statsCatTax.
  ///
  /// In ru, this message translates to:
  /// **'Налог'**
  String get statsCatTax;

  /// No description provided for @statsCatFines.
  ///
  /// In ru, this message translates to:
  /// **'Штрафы'**
  String get statsCatFines;

  /// No description provided for @statsCatWash.
  ///
  /// In ru, this message translates to:
  /// **'Мойка'**
  String get statsCatWash;

  /// No description provided for @statsCatOther.
  ///
  /// In ru, this message translates to:
  /// **'Парковка и другое'**
  String get statsCatOther;

  /// No description provided for @unitThousandRub.
  ///
  /// In ru, this message translates to:
  /// **'тыс. {currency}'**
  String unitThousandRub(String currency);

  /// No description provided for @unitRub.
  ///
  /// In ru, this message translates to:
  /// **'{currency}'**
  String unitRub(String currency);

  /// No description provided for @unitL100Km.
  ///
  /// In ru, this message translates to:
  /// **'л/100 км'**
  String get unitL100Km;

  /// No description provided for @unitKmPerL.
  ///
  /// In ru, this message translates to:
  /// **'км/л'**
  String get unitKmPerL;

  /// No description provided for @settingsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settingsTitle;

  /// No description provided for @settingsAppearance.
  ///
  /// In ru, this message translates to:
  /// **'Оформление'**
  String get settingsAppearance;

  /// No description provided for @settingsTheme.
  ///
  /// In ru, this message translates to:
  /// **'Тема'**
  String get settingsTheme;

  /// No description provided for @themeSystem.
  ///
  /// In ru, this message translates to:
  /// **'Системная'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In ru, this message translates to:
  /// **'Светлая'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In ru, this message translates to:
  /// **'Тёмная'**
  String get themeDark;

  /// No description provided for @settingsUnits.
  ///
  /// In ru, this message translates to:
  /// **'Единицы'**
  String get settingsUnits;

  /// No description provided for @settingsCurrency.
  ///
  /// In ru, this message translates to:
  /// **'Валюта'**
  String get settingsCurrency;

  /// No description provided for @settingsCurrencyHint.
  ///
  /// In ru, this message translates to:
  /// **'Меняется только знак — суммы не пересчитываются'**
  String get settingsCurrencyHint;

  /// No description provided for @currencyRub.
  ///
  /// In ru, this message translates to:
  /// **'Российский рубль'**
  String get currencyRub;

  /// No description provided for @currencyByn.
  ///
  /// In ru, this message translates to:
  /// **'Белорусский рубль'**
  String get currencyByn;

  /// No description provided for @currencyKzt.
  ///
  /// In ru, this message translates to:
  /// **'Казахстанский тенге'**
  String get currencyKzt;

  /// No description provided for @currencyUsd.
  ///
  /// In ru, this message translates to:
  /// **'Доллар США'**
  String get currencyUsd;

  /// No description provided for @currencyEur.
  ///
  /// In ru, this message translates to:
  /// **'Евро'**
  String get currencyEur;

  /// No description provided for @settingsConsumption.
  ///
  /// In ru, this message translates to:
  /// **'Расход топлива'**
  String get settingsConsumption;

  /// No description provided for @settingsData.
  ///
  /// In ru, this message translates to:
  /// **'Данные'**
  String get settingsData;

  /// No description provided for @backupCreate.
  ///
  /// In ru, this message translates to:
  /// **'Создать резервную копию'**
  String get backupCreate;

  /// No description provided for @backupCreateHint.
  ///
  /// In ru, this message translates to:
  /// **'Все автомобили, записи и фото в одном файле'**
  String get backupCreateHint;

  /// No description provided for @backupRestore.
  ///
  /// In ru, this message translates to:
  /// **'Восстановить из копии'**
  String get backupRestore;

  /// No description provided for @backupRestoreHint.
  ///
  /// In ru, this message translates to:
  /// **'Заменит текущие данные'**
  String get backupRestoreHint;

  /// No description provided for @csvExport.
  ///
  /// In ru, this message translates to:
  /// **'Отчёт в CSV'**
  String get csvExport;

  /// No description provided for @csvExportHint.
  ///
  /// In ru, this message translates to:
  /// **'Все записи активного автомобиля — для Excel'**
  String get csvExportHint;

  /// No description provided for @fileSave.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить в файл'**
  String get fileSave;

  /// No description provided for @fileShare.
  ///
  /// In ru, this message translates to:
  /// **'Отправить'**
  String get fileShare;

  /// No description provided for @fileSaved.
  ///
  /// In ru, this message translates to:
  /// **'Файл сохранён'**
  String get fileSaved;

  /// No description provided for @fileError.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось сохранить файл'**
  String get fileError;

  /// No description provided for @backupRestoreTitle.
  ///
  /// In ru, this message translates to:
  /// **'Восстановить данные?'**
  String get backupRestoreTitle;

  /// No description provided for @backupRestoreMessage.
  ///
  /// In ru, this message translates to:
  /// **'Копия от {date}:\n• автомобилей — {cars}\n• заправок — {fuel}\n• расходов — {expenses}\n• напоминаний — {reminders}\n• записей ТО — {records}\n\nТекущие данные будут заменены.'**
  String backupRestoreMessage(
    String date,
    int cars,
    int fuel,
    int expenses,
    int reminders,
    int records,
  );

  /// No description provided for @backupRestoreConfirm.
  ///
  /// In ru, this message translates to:
  /// **'Восстановить'**
  String get backupRestoreConfirm;

  /// No description provided for @backupRestored.
  ///
  /// In ru, this message translates to:
  /// **'Данные восстановлены'**
  String get backupRestored;

  /// No description provided for @backupInvalid.
  ///
  /// In ru, this message translates to:
  /// **'Это не резервная копия «Дневника автомобилиста» или файл повреждён'**
  String get backupInvalid;

  /// No description provided for @backupNewer.
  ///
  /// In ru, this message translates to:
  /// **'Копия создана более новой версией приложения — обновите приложение'**
  String get backupNewer;

  /// No description provided for @csvDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата'**
  String get csvDate;

  /// No description provided for @csvType.
  ///
  /// In ru, this message translates to:
  /// **'Тип'**
  String get csvType;

  /// No description provided for @csvCategory.
  ///
  /// In ru, this message translates to:
  /// **'Категория / вид работ'**
  String get csvCategory;

  /// No description provided for @csvAmount.
  ///
  /// In ru, this message translates to:
  /// **'Сумма, {currency}'**
  String csvAmount(String currency);

  /// No description provided for @csvMileage.
  ///
  /// In ru, this message translates to:
  /// **'Пробег, км'**
  String get csvMileage;

  /// No description provided for @csvLiters.
  ///
  /// In ru, this message translates to:
  /// **'Литры'**
  String get csvLiters;

  /// No description provided for @csvPrice.
  ///
  /// In ru, this message translates to:
  /// **'Цена за литр, {currency}'**
  String csvPrice(String currency);

  /// No description provided for @csvFullTank.
  ///
  /// In ru, this message translates to:
  /// **'Полный бак'**
  String get csvFullTank;

  /// No description provided for @csvPlace.
  ///
  /// In ru, this message translates to:
  /// **'АЗС / СТО'**
  String get csvPlace;

  /// No description provided for @csvComment.
  ///
  /// In ru, this message translates to:
  /// **'Комментарий'**
  String get csvComment;

  /// No description provided for @csvTypeFuel.
  ///
  /// In ru, this message translates to:
  /// **'Заправка'**
  String get csvTypeFuel;

  /// No description provided for @csvTypeExpense.
  ///
  /// In ru, this message translates to:
  /// **'Расход'**
  String get csvTypeExpense;

  /// No description provided for @csvTypeService.
  ///
  /// In ru, this message translates to:
  /// **'ТО'**
  String get csvTypeService;

  /// No description provided for @csvYes.
  ///
  /// In ru, this message translates to:
  /// **'да'**
  String get csvYes;

  /// No description provided for @csvNo.
  ///
  /// In ru, this message translates to:
  /// **'нет'**
  String get csvNo;

  /// No description provided for @onboardingRestore.
  ///
  /// In ru, this message translates to:
  /// **'Восстановить из резервной копии'**
  String get onboardingRestore;

  /// No description provided for @settingsPrivacy.
  ///
  /// In ru, this message translates to:
  /// **'Конфиденциальность'**
  String get settingsPrivacy;

  /// No description provided for @settingsAnalytics.
  ///
  /// In ru, this message translates to:
  /// **'Анонимная статистика'**
  String get settingsAnalytics;

  /// No description provided for @settingsAnalyticsHint.
  ///
  /// In ru, this message translates to:
  /// **'Отчёты о сбоях и о том, какими разделами пользуются. Ваши записи, суммы и пробег не передаются.'**
  String get settingsAnalyticsHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
