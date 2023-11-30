import 'package:flutter/material.dart';
import 'package:ticket_app/models/topic.dart';
import 'package:ticket_app/views/login_screen/login_screen.dart';
import 'package:ticket_app/views/main_screen/main_screen.dart';
import 'package:ticket_app/views/register_screen/register_screen.dart';
import 'package:ticket_app/views/question_view/question_view.dart';
import '../../views/splash_screen/splash_screen.dart';
import 'package:ticket_app/views/finish_screen/finish_screen.dart';
import 'package:ticket_app/views/topic_screen/topic_list_screen.dart';
import 'package:ticket_app/views/topic_screen/topic_screen.dart';
import 'package:ticket_app/views/settings_screen/settings_screen.dart';

Topic mockTopic = Topic(
  name: 'Flutter Development',
  description:
      'A comprehensive guide to building mobile applications using Flutter.',
  image: 'https://example.com/flutter_development_image.jpg',
);

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const SpashScreenWidget(),
  '/login': (context) => const LoginScreenWidget(),
  '/register': (context) => const RegisterScreenWidget(),
  '/main': (context) => const MainScreenWidget(),
  '/topicList': (context) => const TopicListScreenWidget(),
  '/topic': (context) => TopicScreenWidget(
        topic: mockTopic,
      ),
  // '/settings': (context) => const SettingsScreenWidget(),
  // '/question': (context) => const QuestionViewWidget(),
  //'/finish': (context) => const FinishScreenWidget()
  // ... more routes
};
