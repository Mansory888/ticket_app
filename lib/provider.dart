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
}
