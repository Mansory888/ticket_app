import 'package:flutter/material.dart';
import 'package:ticket_app/themes/dark_theme.dart';
import 'package:ticket_app/themes/light_theme.dart';
import 'core/utils/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() => runApp(MyApp());

Locale _selectedLocale = Locale('en', 'US'); // Default locale

void _updateLocale(String language) {
  switch (language) {
    case 'English':
      _selectedLocale = const Locale('en', 'US');
      break;
    case 'Lithuanian':
      _selectedLocale = const Locale('lt', 'LT');
      break;
    case 'Russian':
      _selectedLocale = const Locale('ru', 'RU');
      break;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      locale: _selectedLocale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      routes: routes,
      initialRoute: '/',
    );
  }
}
