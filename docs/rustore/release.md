# Сборка релиза

## Ключ подписи — главное

- Ключ: `~/keystores/cardiary-release.jks`, псевдоним `cardiary`.
- Пароли: `android/key.properties` (не попадает в git).
- **Сделайте резервную копию обоих файлов** в надёжное место (менеджер паролей,
  зашифрованный архив на внешнем носителе). Без них выпустить обновление
  приложения в RuStore нельзя — только новое приложение с новым названием пакета.
- Отпечаток сертификата (SHA-256) — иногда спрашивают сервисы:

  ```
  keytool -list -keystore ~/keystores/cardiary-release.jks -alias cardiary
  ```

Без `android/key.properties` release-сборка остановится с ошибкой — это
специально, чтобы не подписать релиз отладочным ключом.

## AppMetrica

1. Создайте приложение на https://appmetrica.yandex.ru и скопируйте API-ключ.
2. Передавайте его при сборке: `--dart-define=APPMETRICA_API_KEY=<ключ>`.
   Без ключа приложение работает без аналитики, переключатель в настройках скрыт.

## Команды

```bash
# Пакет для RuStore (рекомендуется: магазин отдаст каждому устройству только нужное)
flutter build appbundle --release --dart-define=APPMETRICA_API_KEY=<ключ>

# APK — для ручной установки и проверки
flutter build apk --release --dart-define=APPMETRICA_API_KEY=<ключ>
```

Результат:
`build/app/outputs/bundle/release/app-release.aab`,
`build/app/outputs/flutter-apk/app-release.apk`.

Перед каждой новой версией увеличьте `version` в `pubspec.yaml`
(например, `1.0.1+2` — число после `+` должно расти).
