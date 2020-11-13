import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'generated/messages_all.dart';

class I18n {
  static Future<I18n> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return I18n();
    });
  }

  static I18n of(BuildContext context) {
    return Localizations.of<I18n>(context, I18n);
  }

  String getDecimalSeparator() {
    return NumberFormat().symbols.DECIMAL_SEP;
  }

  String get ok {
    return Intl.message("OK", name: "ok", desc: "OK");
  }
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  const I18nDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en', ''),
    Locale('pl', '')
  ];

  @override
  bool isSupported(Locale locale) => I18nDelegate.supportedLocales
      .map((l) => l.languageCode)
      .contains(locale.languageCode);

  @override
  Future<I18n> load(Locale locale) => I18n.load(locale);

  @override
  bool shouldReload(I18nDelegate old) => false;
}
