import 'package:flutter/material.dart';
import 'package:ticket_app/themes/dark_theme.dart';
import 'package:ticket_app/themes/light_theme.dart';
import 'core/utils/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'provider.dart' as provider;
import 'package:provider/provider.dart';
import 'provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(Locale('en')), // default locale
      child: MyApp(),
    ),
  );
  requestPermissions();
}

void requestPermissions() async {
  await [
    Permission.storage,
  ].request();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context).locale;

    return MaterialApp(
      title: 'VDE',
      locale: locale,
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
