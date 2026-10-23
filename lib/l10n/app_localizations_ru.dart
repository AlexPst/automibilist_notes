// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Дневник автомобилиста';

  @override
  String get navHome => 'Главная';

  @override
  String get navFuel => 'Заправки';

  @override
  String get navExpenses => 'Расходы';

  @override
  String get navService => 'ТО';

  @override
  String get navStats => 'Статистика';

  @override
  String get homeTitle => 'Главная';

  @override
  String get fuelTitle => 'Заправки';

  @override
  String get expensesTitle => 'Расходы';

  @override
  String get serviceTitle => 'ТО и напоминания';

  @override
  String get statsTitle => 'Статистика';

  @override
  String get placeholderSoon => 'Раздел появится в следующих версиях';

  @override
  String get cancel => 'Отмена';

  @override
  String get save => 'Сохранить';

  @override
  String get edit => 'Изменить';

  @override
  String get delete => 'Удалить';

  @override
  String get carsTitle => 'Автомобили';

  @override
  String get carsManage => 'Управление автомобилями';

  @override
  String get carSelect => 'Выбрать автомобиль';

  @override
  String get carAdd => 'Добавить автомобиль';

  @override
  String get carNewTitle => 'Новый автомобиль';

  @override
  String get carEditTitle => 'Редактирование';

  @override
  String get carNotFound => 'Автомобиль не найден';

  @override
  String get carActive => 'Активный';

  @override
  String get carDeleteTitle => 'Удалить автомобиль?';

  @override
  String carDeleteMessage(String name) {
    return '«$name» и все его записи будут удалены без возможности восстановления.';
  }

  @override
  String get carSaveError => 'Не удалось сохранить автомобиль';

  @override
  String get onboardingTitle => 'Добавьте первый автомобиль';

  @override
  String get onboardingText =>
      'Укажите марку, модель и пробег — и можно вести учёт заправок, расходов и ТО.';

  @override
  String get carBrand => 'Марка';

  @override
  String get carModel => 'Модель';

  @override
  String get carYear => 'Год выпуска';

  @override
  String get carPlate => 'Госномер';

  @override
  String get carFuelType => 'Тип топлива';

  @override
  String get carTankVolume => 'Объём бака, л';

  @override
  String get carInitialMileage => 'Начальный пробег, км';

  @override
  String carInitialMileageValue(String value) {
    return 'Начальный пробег: $value км';
  }

  @override
  String carTankVolumeValue(String value) {
    return 'Бак $value л';
  }

  @override
  String carYearValue(String year) {
    return '$year г.';
  }

  @override
  String get photoFromCamera => 'Сделать снимок';

  @override
  String get photoFromGallery => 'Выбрать из галереи';

  @override
  String get photoRemove => 'Удалить фото';

  @override
  String get photoPickError => 'Не удалось получить фото';

  @override
  String get photoHint => 'Нажмите, чтобы добавить фото';

  @override
  String get errorRequired => 'Обязательное поле';

  @override
  String errorTooLong(int max) {
    return 'Не длиннее $max символов';
  }

  @override
  String get errorNotNumber => 'Введите число';

  @override
  String errorRange(String min, String max) {
    return 'Допустимо от $min до $max';
  }

  @override
  String get fuelAi92 => 'АИ-92';

  @override
  String get fuelAi95 => 'АИ-95';

  @override
  String get fuelAi98 => 'АИ-98';

  @override
  String get fuelAi100 => 'АИ-100';

  @override
  String get fuelDiesel => 'Дизель';

  @override
  String get fuelLpg => 'Газ (пропан)';

  @override
  String get fuelCng => 'Метан';

  @override
  String get fuelEmptyTitle => 'Пока нет заправок';

  @override
  String get fuelEmptyText => 'Нажмите «+», чтобы добавить первую заправку';

  @override
  String get fuelAdd => 'Добавить заправку';

  @override
  String get fuelNewTitle => 'Новая заправка';

  @override
  String get fuelEditTitle => 'Заправка';

  @override
  String get fuelNotFound => 'Запись не найдена';

  @override
  String get fuelSaveError => 'Не удалось сохранить заправку';

  @override
  String get fuelDate => 'Дата';

  @override
  String get fuelMileage => 'Пробег, км';

  @override
  String get fuelLiters => 'Литры';

  @override
  String fuelPrice(String currency) {
    return 'Цена за литр, $currency';
  }

  @override
  String fuelTotal(String currency) {
    return 'Сумма, $currency';
  }

  @override
  String get fuelAutoCalcHint =>
      'Заполните любые два поля — третье посчитается само';

  @override
  String get fuelFullTank => 'Полный бак';

  @override
  String get fuelFullTankHint =>
      'Заправились до полного — нужно для расчёта расхода';

  @override
  String get fuelStation => 'АЗС';

  @override
  String get fuelComment => 'Комментарий';

  @override
  String get fuelDeleteTitle => 'Удалить заправку?';

  @override
  String get fuelDeleteMessage =>
      'Запись будет удалена без возможности восстановления.';

  @override
  String get fuelPartial => 'Неполный бак';

  @override
  String get fuelAvgConsumption => 'Средний расход';

  @override
  String get fuelAvgConsumptionEmpty =>
      'Появится после двух заправок до полного бака';

  @override
  String consumptionValue(String value, String unit) {
    return '$value $unit';
  }

  @override
  String mileageValue(String value) {
    return '$value км';
  }

  @override
  String fuelMileageMinHint(String value) {
    return 'Не меньше $value км';
  }

  @override
  String errorMileageBelowInitial(String value) {
    return 'Меньше начального пробега авто ($value км)';
  }

  @override
  String errorMileageBelowPrevious(String value) {
    return 'Меньше, чем в более ранней записи ($value км)';
  }

  @override
  String errorMileageAboveNext(String value) {
    return 'Больше, чем в более поздней записи ($value км)';
  }

  @override
  String get errorPositive => 'Должно быть больше нуля';

  @override
  String fuelLitersLine(String liters, String price) {
    return '$liters л × $price';
  }

  @override
  String get expensesEmptyTitle => 'Пока нет расходов';

  @override
  String get expensesEmptyText =>
      'Нажмите «+», чтобы добавить мойку, ремонт, страховку и другие траты';

  @override
  String get expensesNothingFound => 'Нет расходов по выбранному фильтру';

  @override
  String get expensesResetFilter => 'Сбросить фильтр';

  @override
  String get expenseAdd => 'Добавить расход';

  @override
  String get expenseNewTitle => 'Новый расход';

  @override
  String get expenseEditTitle => 'Расход';

  @override
  String get expenseNotFound => 'Запись не найдена';

  @override
  String get expenseSaveError => 'Не удалось сохранить расход';

  @override
  String get expenseDeleteTitle => 'Удалить расход?';

  @override
  String get expenseDeleteMessage =>
      'Запись будет удалена без возможности восстановления.';

  @override
  String get expenseDate => 'Дата';

  @override
  String get expenseCategory => 'Категория';

  @override
  String expenseAmount(String currency) {
    return 'Сумма, $currency';
  }

  @override
  String get expenseMileage => 'Пробег, км';

  @override
  String get expenseComment => 'Комментарий';

  @override
  String get expensesTotal => 'Итого';

  @override
  String expensesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count записи',
      many: '$count записей',
      few: '$count записи',
      one: '$count запись',
    );
    return '$_temp0';
  }

  @override
  String get periodAll => 'Всё время';

  @override
  String get periodMonth => 'Этот месяц';

  @override
  String get periodYear => 'Этот год';

  @override
  String get periodCustom => 'Период…';

  @override
  String periodRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String get categoryWash => 'Мойка';

  @override
  String get categoryRepair => 'Ремонт';

  @override
  String get categoryParts => 'Запчасти';

  @override
  String get categoryInsurance => 'Страховка';

  @override
  String get categoryFines => 'Штрафы';

  @override
  String get categoryParking => 'Парковка';

  @override
  String get categoryTax => 'Налог';

  @override
  String get categoryOther => 'Другое';

  @override
  String get serviceTabReminders => 'Напоминания';

  @override
  String get serviceTabHistory => 'История';

  @override
  String get remindersEmptyTitle => 'Нет напоминаний';

  @override
  String get remindersEmptyText =>
      'Добавьте напоминание о замене масла, ОСАГО или смене резины — приложение подскажет, когда пора';

  @override
  String get historyEmptyTitle => 'Нет записей ТО';

  @override
  String get historyEmptyText =>
      'Записывайте сюда выполненные работы: замену масла, фильтров, ремонт';

  @override
  String get reminderAdd => 'Добавить напоминание';

  @override
  String get reminderCustom => 'Своё напоминание';

  @override
  String get reminderNewTitle => 'Новое напоминание';

  @override
  String get reminderEditTitle => 'Напоминание';

  @override
  String get reminderNotFound => 'Напоминание не найдено';

  @override
  String get reminderTitle => 'Вид работ';

  @override
  String get reminderIntervalKm => 'Каждые, км';

  @override
  String get reminderIntervalMonths => 'Каждые, мес.';

  @override
  String get reminderIntervalHint =>
      'Заполните пробег, срок или оба — сработает то, что наступит раньше';

  @override
  String get reminderLastDone => 'Последний раз — дата';

  @override
  String get reminderLastDoneMileage => 'Последний раз — пробег, км';

  @override
  String get reminderAdvanceDays => 'Предупредить за, дней';

  @override
  String get reminderAdvanceKm => 'Предупредить за, км';

  @override
  String reminderNextDue(String due) {
    return 'Следующий срок: $due';
  }

  @override
  String get reminderDeleteTitle => 'Удалить напоминание?';

  @override
  String get reminderDeleteMessage => 'Записи ТО останутся в истории.';

  @override
  String get reminderDone => 'Выполнено';

  @override
  String get reminderSaveError => 'Не удалось сохранить напоминание';

  @override
  String reminderEveryKm(String km) {
    return 'каждые $km км';
  }

  @override
  String reminderEveryMonths(String months) {
    return 'каждые $months мес.';
  }

  @override
  String get reminderOr => ' или ';

  @override
  String get errorIntervalRequired => 'Укажите интервал в км или месяцах';

  @override
  String get errorMileageForKm => 'Нужен для интервала по пробегу';

  @override
  String dueInDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count дней',
      few: '$count дня',
      one: '$count день',
    );
    return 'через $_temp0';
  }

  @override
  String get dueToday => 'сегодня';

  @override
  String overdueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count дней',
      few: '$count дня',
      one: '$count день',
    );
    return 'просрочено на $_temp0';
  }

  @override
  String dueInKm(String km) {
    return 'через $km км';
  }

  @override
  String get dueNowKm => 'пора';

  @override
  String overdueKm(String km) {
    return 'просрочено на $km км';
  }

  @override
  String get notificationChannelName => 'Напоминания';

  @override
  String get notificationChannelDescription =>
      'Сроки ТО, страховки и смены резины';

  @override
  String notifSoonTitle(String title) {
    return 'Скоро: $title';
  }

  @override
  String notifDueTitle(String title) {
    return 'Сегодня срок: $title';
  }

  @override
  String notifMileageDueTitle(String title) {
    return 'Пора: $title';
  }

  @override
  String notifDateBody(String car, String date) {
    return '$car · срок $date';
  }

  @override
  String notifMileageBody(String car, String due, String current) {
    return '$car · срок $due км, сейчас $current км';
  }

  @override
  String get notifTestTitle => 'Проверка уведомлений';

  @override
  String get notifTestBody =>
      'Если вы видите это сообщение — уведомления работают';

  @override
  String get notifTestMenu => 'Тестовое уведомление через 1 минуту';

  @override
  String get notifTestScheduled => 'Уведомление придёт примерно через минуту';

  @override
  String mileageAlertSnack(String titles) {
    return 'Подходит срок: $titles';
  }

  @override
  String get open => 'Открыть';

  @override
  String get serviceRecordAdd => 'Добавить запись ТО';

  @override
  String get serviceRecordNewTitle => 'Новая запись ТО';

  @override
  String get serviceRecordEditTitle => 'Запись ТО';

  @override
  String get serviceRecordNotFound => 'Запись не найдена';

  @override
  String get serviceRecordReminder => 'Напоминание';

  @override
  String get serviceRecordNoReminder => 'Без напоминания';

  @override
  String get serviceRecordReminderHint =>
      'Следующий срок напоминания посчитается от этой записи';

  @override
  String get serviceRecordTitle => 'Вид работ';

  @override
  String get serviceRecordDate => 'Дата';

  @override
  String get serviceRecordMileage => 'Пробег, км';

  @override
  String serviceRecordCost(String currency) {
    return 'Стоимость, $currency';
  }

  @override
  String get serviceRecordStation => 'СТО';

  @override
  String get serviceRecordComment => 'Комментарий';

  @override
  String get serviceRecordDeleteTitle => 'Удалить запись ТО?';

  @override
  String get serviceRecordDeleteMessage =>
      'Запись будет удалена без возможности восстановления. Срок напоминания не изменится.';

  @override
  String get serviceRecordSaveError => 'Не удалось сохранить запись';

  @override
  String currentMileageHint(String value) {
    return 'Текущий пробег: $value км';
  }

  @override
  String get templateOil => 'Замена масла';

  @override
  String get templateAirFilter => 'Воздушный фильтр';

  @override
  String get templateCabinFilter => 'Салонный фильтр';

  @override
  String get templateFuelFilter => 'Топливный фильтр';

  @override
  String get templateOsago => 'ОСАГО';

  @override
  String get templateInspection => 'Техосмотр';

  @override
  String get templateSummerTyres => 'Летняя резина';

  @override
  String get templateWinterTyres => 'Зимняя резина';

  @override
  String get loading => 'Загрузка…';

  @override
  String get homeMileage => 'Пробег';

  @override
  String get homeAvgConsumption => 'Средний расход';

  @override
  String homeMonthSpending(String month) {
    return 'Расходы за $month';
  }

  @override
  String get homeFuel => 'Топливо';

  @override
  String get homeService => 'ТО';

  @override
  String get homeOtherExpenses => 'Прочие расходы';

  @override
  String get homeUpcoming => 'Ближайшие напоминания';

  @override
  String get homeNoReminders => 'Напоминаний пока нет';

  @override
  String get homeAllReminders => 'Все напоминания';

  @override
  String get noValue => '—';

  @override
  String get statsPeriodMonth => 'Месяц';

  @override
  String get statsPeriodYear => 'Год';

  @override
  String get statsPeriodAll => 'Всё время';

  @override
  String get statsTotal => 'Всего потрачено';

  @override
  String get statsDistance => 'Пробег за период';

  @override
  String get statsCostPerKm => 'Стоимость 1 км';

  @override
  String statsFuelCostPerKm(String value) {
    return 'из них топливо $value';
  }

  @override
  String costPerKmValue(String value) {
    return '$value/км';
  }

  @override
  String get statsByCategory => 'По категориям';

  @override
  String get statsByMonth => 'По месяцам';

  @override
  String statsConsumption(String unit) {
    return 'Расход топлива, $unit';
  }

  @override
  String statsAvgForPeriod(String value) {
    return 'Средний за период: $value';
  }

  @override
  String get statsConsumptionEmpty =>
      'Появится после двух заправок до полного бака';

  @override
  String get statsEmptyTitle => 'Нет данных за период';

  @override
  String get statsEmptyText =>
      'Добавьте заправки или расходы — здесь появятся графики';

  @override
  String get statsCatFuel => 'Топливо';

  @override
  String get statsCatService => 'ТО';

  @override
  String get statsCatRepair => 'Ремонт и запчасти';

  @override
  String get statsCatInsurance => 'Страховка';

  @override
  String get statsCatTax => 'Налог';

  @override
  String get statsCatFines => 'Штрафы';

  @override
  String get statsCatWash => 'Мойка';

  @override
  String get statsCatOther => 'Парковка и другое';

  @override
  String unitThousandRub(String currency) {
    return 'тыс. $currency';
  }

  @override
  String unitRub(String currency) {
    return '$currency';
  }

  @override
  String get unitL100Km => 'л/100 км';

  @override
  String get unitKmPerL => 'км/л';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsAppearance => 'Оформление';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get settingsUnits => 'Единицы';

  @override
  String get settingsCurrency => 'Валюта';

  @override
  String get settingsCurrencyHint =>
      'Меняется только знак — суммы не пересчитываются';

  @override
  String get currencyRub => 'Российский рубль';

  @override
  String get currencyByn => 'Белорусский рубль';

  @override
  String get currencyKzt => 'Казахстанский тенге';

  @override
  String get currencyUsd => 'Доллар США';

  @override
  String get currencyEur => 'Евро';

  @override
  String get settingsConsumption => 'Расход топлива';

  @override
  String get settingsData => 'Данные';

  @override
  String get backupCreate => 'Создать резервную копию';

  @override
  String get backupCreateHint => 'Все автомобили, записи и фото в одном файле';

  @override
  String get backupRestore => 'Восстановить из копии';

  @override
  String get backupRestoreHint => 'Заменит текущие данные';

  @override
  String get csvExport => 'Отчёт в CSV';

  @override
  String get csvExportHint => 'Все записи активного автомобиля — для Excel';

  @override
  String get fileSave => 'Сохранить в файл';

  @override
  String get fileShare => 'Отправить';

  @override
  String get fileSaved => 'Файл сохранён';

  @override
  String get fileError => 'Не удалось сохранить файл';

  @override
  String get backupRestoreTitle => 'Восстановить данные?';

  @override
  String backupRestoreMessage(
    String date,
    int cars,
    int fuel,
    int expenses,
    int reminders,
    int records,
  ) {
    return 'Копия от $date:\n• автомобилей — $cars\n• заправок — $fuel\n• расходов — $expenses\n• напоминаний — $reminders\n• записей ТО — $records\n\nТекущие данные будут заменены.';
  }

  @override
  String get backupRestoreConfirm => 'Восстановить';

  @override
  String get backupRestored => 'Данные восстановлены';

  @override
  String get backupInvalid =>
      'Это не резервная копия «Дневника автомобилиста» или файл повреждён';

  @override
  String get backupNewer =>
      'Копия создана более новой версией приложения — обновите приложение';

  @override
  String get csvDate => 'Дата';

  @override
  String get csvType => 'Тип';

  @override
  String get csvCategory => 'Категория / вид работ';

  @override
  String csvAmount(String currency) {
    return 'Сумма, $currency';
  }

  @override
  String get csvMileage => 'Пробег, км';

  @override
  String get csvLiters => 'Литры';

  @override
  String csvPrice(String currency) {
    return 'Цена за литр, $currency';
  }

  @override
  String get csvFullTank => 'Полный бак';

  @override
  String get csvPlace => 'АЗС / СТО';

  @override
  String get csvComment => 'Комментарий';

  @override
  String get csvTypeFuel => 'Заправка';

  @override
  String get csvTypeExpense => 'Расход';

  @override
  String get csvTypeService => 'ТО';

  @override
  String get csvYes => 'да';

  @override
  String get csvNo => 'нет';

  @override
  String get onboardingRestore => 'Восстановить из резервной копии';

  @override
  String get settingsPrivacy => 'Конфиденциальность';

  @override
  String get settingsAnalytics => 'Анонимная статистика';

  @override
  String get settingsAnalyticsHint =>
      'Отчёты о сбоях и о том, какими разделами пользуются. Ваши записи, суммы и пробег не передаются.';
}
