import 'package:flutter/material.dart';
import 'package:ticket_app/views/login_screen/login_screen.dart';
import 'package:ticket_app/views/main_screen/main_screen.dart';
import 'package:ticket_app/views/register_screen/register_screen.dart';
import 'package:ticket_app/views/question_view/question_view.dart';
import '../../views/splash_screen/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const SpashScreenWidget(),
  '/login': (context) => const LoginScreenWidget(),
  '/register': (context) => const RegisterScreenWidget(),
  '/main': (context) => const MainScreenWidget(),
  '/question': (context) => const QuestionViewWidget(),
  // ... more routes
};
