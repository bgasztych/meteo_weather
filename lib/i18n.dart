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

  String get favourites {
    return Intl.message("Favourites", name: "favourites", desc: "Favourites");
  }

  String get noFavouritesCities {
    return Intl.message("No favourites cities", name: "noFavouritesCities", desc: "No favourites cities");
  }

  String get fetchFavouritesCitiesFailed {
    return Intl.message("Failed to fetch favourites cities", name: "fetchFavouritesCitiesFailed", desc: "Failed to fetch favourites cities");
  }

  String get searchQueryTooShort {
    return Intl.message("Search term must be longer than two letters.", name: "searchQueryTooShort", desc: "Search term must be longer than two letters.");
  }

  String get searchNoResults {
    return Intl.message("No results found", name: "searchNoResults", desc: "No results found");
  }

  String get searchCitiesFetchFailed {
    return Intl.message("Failed to fetch filtered cities", name: "searchCitiesFetchFailed", desc: "Failed to fetch filtered cities");
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
