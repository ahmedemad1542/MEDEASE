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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to MedEase`
  String get Welcome {
    return Intl.message(
      'Welcome to MedEase',
      name: 'Welcome',
      desc: '',
      args: [],
    );
  }

  /// `We are excited to help you take care of your health`
  String get description {
    return Intl.message(
      'We are excited to help you take care of your health',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Create an account`
  String get createAccount {
    return Intl.message(
      'Create an account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_Account {
    return Intl.message(
      'Create Account',
      name: 'create_Account',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Country`
  String get country {
    return Intl.message('Country', name: 'country', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Role`
  String get role {
    return Intl.message('Role', name: 'role', desc: '', args: []);
  }

  /// `Doctor`
  String get doctor {
    return Intl.message('Doctor', name: 'doctor', desc: '', args: []);
  }

  /// `Patient`
  String get patient {
    return Intl.message('Patient', name: 'patient', desc: '', args: []);
  }

  /// `Admin`
  String get admin {
    return Intl.message('Admin', name: 'admin', desc: '', args: []);
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get selectCountry {
    return Intl.message(
      'Select Country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Happy to see you again`
  String get happyToSeeYou {
    return Intl.message(
      'Happy to see you again',
      name: 'happyToSeeYou',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot your Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `BMI Calculator`
  String get bmicalculator {
    return Intl.message(
      'BMI Calculator',
      name: 'bmicalculator',
      desc: '',
      args: [],
    );
  }

  /// `You're under the required weight; you need to increase your calorie intake.`
  String get bmiresult1 {
    return Intl.message(
      'You\'re under the required weight; you need to increase your calorie intake.',
      name: 'bmiresult1',
      desc: '',
      args: [],
    );
  }

  /// `You're at the ideal weight—keep taking care of your health!`
  String get bmiresult2 {
    return Intl.message(
      'You\'re at the ideal weight—keep taking care of your health!',
      name: 'bmiresult2',
      desc: '',
      args: [],
    );
  }

  /// `You need to lose a little weight—try reducing your calorie intake and follow a healthy diet!`
  String get bmiresult3 {
    return Intl.message(
      'You need to lose a little weight—try reducing your calorie intake and follow a healthy diet!',
      name: 'bmiresult3',
      desc: '',
      args: [],
    );
  }

  /// `Height (cm)`
  String get hieght {
    return Intl.message('Height (cm)', name: 'hieght', desc: '', args: []);
  }

  /// `Weight (kg)`
  String get weight {
    return Intl.message('Weight (kg)', name: 'weight', desc: '', args: []);
  }

  /// `BMI Result`
  String get bmiResult {
    return Intl.message('BMI Result', name: 'bmiResult', desc: '', args: []);
  }

  /// `Body Mass Index (BMI)`
  String get bmi {
    return Intl.message(
      'Body Mass Index (BMI)',
      name: 'bmi',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
