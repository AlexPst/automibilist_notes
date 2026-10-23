import 'package:cardiary/core/widgets/first_launch_overlay.dart';
import 'package:cardiary/core/widgets/frosted_glass_loader.dart';
import 'package:cardiary/data/database/app_database.dart';
import 'package:cardiary/data/repositories/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';

void main() {
  Future<bool> firstLaunchDone(AppDatabase db) =>
      SettingsRepository(db.settingsDao).isFirstLaunchDone();

  testWidgets('при первом запуске — экран загрузки поверх приложения', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    final db = await pumpTestApp(tester, firstLaunch: true);

    expect(find.byType(FrostedGlassLoader), findsOneWidget);
    expect(find.byType(BackdropFilter), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Загрузка…')), findsOneWidget);
    // Под стеклом уже готов интерфейс (здесь — онбординг).
    expect(find.text('Добавьте первый автомобиль'), findsOneWidget);

    // Пока идёт загрузка, нажатия не доходят до интерфейса.
    await tester.tap(find.text('Добавить автомобиль'), warnIfMissed: false);
    await tester.pump();
    expect(find.text('Новый автомобиль'), findsNothing);

    // Ещё держится до конца отведённого времени.
    await tester.pump(FirstLaunchOverlay.showFor - const Duration(seconds: 1));
    expect(find.byType(FrostedGlassLoader), findsOneWidget);

    // Растворение начинается с кадра после таймера.
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(FirstLaunchOverlay.fadeOut);
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(FrostedGlassLoader), findsNothing);
    expect(await firstLaunchDone(db), isTrue);
    semantics.dispose();
  });

  testWidgets('при следующих запусках экрана загрузки нет', (tester) async {
    await pumpTestApp(tester, cars: [testCarDraft()]);

    expect(find.byType(FrostedGlassLoader), findsNothing);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('заглушки заменяются своими иконкой и анимацией', (tester) async {
    await pumpTestApp(tester, cars: [testCarDraft()]);
    final context = tester.element(find.byType(NavigationBar));

    await tester.pumpWidget(
      Localizations.override(
        context: context,
        child: Theme(
          data: Theme.of(context),
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: FrostedGlassLoader(
              icon: Text('ИКОНКА'),
              animation: Text('АНИМАЦИЯ'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('ИКОНКА'), findsOneWidget);
    expect(find.text('АНИМАЦИЯ'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsNothing);
  });
}
