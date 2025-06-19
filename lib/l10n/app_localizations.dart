import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  final Locale locale;
  late Map<String, dynamic> _localizedStrings;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Future<bool> load() async {
    String jsonString;
    try {
      jsonString = await rootBundle.loadString(
        'lib/l10n/${locale.languageCode}.json',
      );
    } catch (e) {
      jsonString = await rootBundle.loadString('lib/l10n/en.json');
    }
    _localizedStrings = json.decode(jsonString);
    return true;
  }

  String translate(String key) {
    List<String> keys = key.split('.');
    dynamic value = _localizedStrings;
    for (final k in keys) {
      value = value[k];
      if (value == null) return key;
    }
    return value is String ? value : key;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
