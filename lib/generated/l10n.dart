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

  /// `moshafy`
  String get moshafy {
    return Intl.message(
      'moshafy',
      name: 'moshafy',
      desc: '',
      args: [],
    );
  }

  /// `language`
  String get lang {
    return Intl.message(
      'language',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkmode {
    return Intl.message(
      'Dark Mode',
      name: 'darkmode',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get light_mode {
    return Intl.message(
      'Light Mode',
      name: 'light_mode',
      desc: '',
      args: [],
    );
  }

  /// `Device Mode`
  String get devicethememode {
    return Intl.message(
      'Device Mode',
      name: 'devicethememode',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Moshaf`
  String get moshaf {
    return Intl.message(
      'Moshaf',
      name: 'moshaf',
      desc: '',
      args: [],
    );
  }

  /// `Hadeeth`
  String get hadeeth {
    return Intl.message(
      'Hadeeth',
      name: 'hadeeth',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get favourit {
    return Intl.message(
      'Favourites',
      name: 'favourit',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Qibla`
  String get qibla {
    return Intl.message(
      'Qibla',
      name: 'qibla',
      desc: '',
      args: [],
    );
  }

  /// `Ayah`
  String get ayah {
    return Intl.message(
      'Ayah',
      name: 'ayah',
      desc: '',
      args: [],
    );
  }

  /// `About Me`
  String get about_me {
    return Intl.message(
      'About Me',
      name: 'about_me',
      desc: '',
      args: [],
    );
  }

  /// `Rate Our App`
  String get rate {
    return Intl.message(
      'Rate Our App',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Juz`
  String get juz {
    return Intl.message(
      'Juz',
      name: 'juz',
      desc: '',
      args: [],
    );
  }

  /// `Page`
  String get page {
    return Intl.message(
      'Page',
      name: 'page',
      desc: '',
      args: [],
    );
  }

  /// `Sorah`
  String get sora {
    return Intl.message(
      'Sorah',
      name: 'sora',
      desc: '',
      args: [],
    );
  }

  /// `Sorah Number`
  String get sorahNumber {
    return Intl.message(
      'Sorah Number',
      name: 'sorahNumber',
      desc: '',
      args: [],
    );
  }

  /// `Numbers of Ayahs`
  String get ayahsNmuber {
    return Intl.message(
      'Numbers of Ayahs',
      name: 'ayahsNmuber',
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
