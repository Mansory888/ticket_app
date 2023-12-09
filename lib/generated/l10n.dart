// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Start the Journey`
  String get startTheJourney {
    return Intl.message(
      'Start the Journey',
      name: 'startTheJourney',
      desc: '',
      args: [],
    );
  }

  /// `Passing the exam is more easier and faster with Discount`
  String get passingExamMessage {
    return Intl.message(
      'Passing the exam is more easier and faster with Discount',
      name: 'passingExamMessage',
      desc: '',
      args: [],
    );
  }

  /// `Let’s Get Started`
  String get letsGetStarted {
    return Intl.message(
      'Let’s Get Started',
      name: 'letsGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back !`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back !',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Fill your details`
  String get fillDetails {
    return Intl.message(
      'Fill your details',
      name: 'fillDetails',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAdress {
    return Intl.message(
      'Email Address',
      name: 'emailAdress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get LogIn {
    return Intl.message(
      'Log In',
      name: 'LogIn',
      desc: '',
      args: [],
    );
  }

  /// `New User?`
  String get newUser {
    return Intl.message(
      'New User?',
      name: 'newUser',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get CreateAccount {
    return Intl.message(
      'Create Account',
      name: 'CreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register Account`
  String get RegisterAccount {
    return Intl.message(
      'Register Account',
      name: 'RegisterAccount',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get UserName {
    return Intl.message(
      'User Name',
      name: 'UserName',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get Register {
    return Intl.message(
      'Register',
      name: 'Register',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get AlreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'AlreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get Welcome {
    return Intl.message(
      'Welcome',
      name: 'Welcome',
      desc: '',
      args: [],
    );
  }

  /// `Passed`
  String get passed {
    return Intl.message(
      'Passed',
      name: 'passed',
      desc: '',
      args: [],
    );
  }

  /// `Not Passed`
  String get notPassed {
    return Intl.message(
      'Not Passed',
      name: 'notPassed',
      desc: '',
      args: [],
    );
  }

  /// `Leader Board`
  String get leaderBoard {
    return Intl.message(
      'Leader Board',
      name: 'leaderBoard',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get Start {
    return Intl.message(
      'Start',
      name: 'Start',
      desc: '',
      args: [],
    );
  }

  /// `Questions`
  String get Questions {
    return Intl.message(
      'Questions',
      name: 'Questions',
      desc: '',
      args: [],
    );
  }

  /// `Exam`
  String get Exam {
    return Intl.message(
      'Exam',
      name: 'Exam',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Exam Complete`
  String get ExamComplete {
    return Intl.message(
      'Exam Complete',
      name: 'ExamComplete',
      desc: '',
      args: [],
    );
  }

  /// `You have answered`
  String get Youhaveanswered {
    return Intl.message(
      'You have answered',
      name: 'Youhaveanswered',
      desc: '',
      args: [],
    );
  }

  /// `questions correctly.`
  String get questionscorrectly {
    return Intl.message(
      'questions correctly.',
      name: 'questionscorrectly',
      desc: '',
      args: [],
    );
  }

  /// `back to menu`
  String get backtomenu {
    return Intl.message(
      'back to menu',
      name: 'backtomenu',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get retry {
    return Intl.message(
      'Try again',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `That is`
  String get Thatis {
    return Intl.message(
      'That is',
      name: 'Thatis',
      desc: '',
      args: [],
    );
  }

  /// `Questions you failed:`
  String get Questionsyoufailed {
    return Intl.message(
      'Questions you failed:',
      name: 'Questionsyoufailed',
      desc: '',
      args: [],
    );
  }

  /// `Topics`
  String get Topics {
    return Intl.message(
      'Topics',
      name: 'Topics',
      desc: '',
      args: [],
    );
  }

  /// `If you think this question is wrong, please tell us:`
  String get QuestionWrong {
    return Intl.message(
      'If you think this question is wrong, please tell us:',
      name: 'QuestionWrong',
      desc: '',
      args: [],
    );
  }

  /// `Report Question`
  String get ReportQuestion {
    return Intl.message(
      'Report Question',
      name: 'ReportQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get Send {
    return Intl.message(
      'Send',
      name: 'Send',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Payment Plan`
  String get PaymentPlan {
    return Intl.message(
      'Payment Plan',
      name: 'PaymentPlan',
      desc: '',
      args: [],
    );
  }

  /// `Status: Active`
  String get Status {
    return Intl.message(
      'Status: Active',
      name: 'Status',
      desc: '',
      args: [],
    );
  }

  /// `Expires: 5 days`
  String get ExpiryDate {
    return Intl.message(
      'Expires: 5 days',
      name: 'ExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Update Plan`
  String get UpdatePlan {
    return Intl.message(
      'Update Plan',
      name: 'UpdatePlan',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get DarkMoid {
    return Intl.message(
      'Dark Mode',
      name: 'DarkMoid',
      desc: '',
      args: [],
    );
  }

  /// `Enable Dark Mode`
  String get EnableDarkMode {
    return Intl.message(
      'Enable Dark Mode',
      name: 'EnableDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get SelectLanguage {
    return Intl.message(
      'Select Language',
      name: 'SelectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Topic`
  String get Topic {
    return Intl.message(
      'Topic',
      name: 'Topic',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'lt'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
