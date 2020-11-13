# meteo_weather

Meteo weather.

## Getting Started - developers guide

You should have Flutter framework installed and working. Refer to Flutter documentation and run `flutter doctor` to make sure you are ok (make sure you have configured Android emulator or have a real device at hand).

Before first application launch you must generate translation files:

```
./scripts/generate_from_arb.sh
```

To run application type:

```
flutter run
```

## Translations

To extract strings from source code run:

```
./scripts/extract_to_arb.sh
```

This generates `lib/resources/messages/intl_messages.arb` file with all extracted
strings.

Translations are stored in files `lib/resources/messages/intl_{pl,en}.arb`. As of
now, there are no tools that could help managing them.

Once new translations are added to any of that files, you should regenerate
code:

```
./scripts/generate_from_arb.sh
```

**Note:**

By convention used in this project `lib/i18n.dart` is the only file
where we call `Intl.message()` function.
