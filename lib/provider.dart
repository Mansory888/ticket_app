import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale;

  LocaleProvider(this._locale);

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!S.delegate.supportedLocales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

   int getLanguageId() {
    switch (_locale.languageCode) {
      case 'en':
        return 1;
      case 'ru':
        return 2;
      case 'lt':
        return 3;
      default:
        return 0; 
    }
  }
}
