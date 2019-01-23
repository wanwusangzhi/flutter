import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppLocalizations {
  Locale locale;

  AppLocalizations(this.locale);

  // 初始化对照表
  static Map<String, Map<String, String>> _localizedValues = {
    'en': {"title": 'english', "btn": 'Button'},
    "zh": {"title": '中文', "btn": "按钮"}
  };

  get title {
    print('project title');
    return _localizedValues[locale.languageCode]['title'];
  }

  static get languageCode => _inst.locale.languageCode;

  _t(String key) {
    print('key:  $key');
    return _localizedValues[locale.languageCode][key] ?? '';
  }

  static AppLocalizationsDelegate changeLanguage(Locale locale) {
    print('change -> $locale');
    _inst.locale = locale;
    return AppLocalizationsDelegate(locale);
  }

  static AppLocalizations _inst;

  static String $t(String key, [BuildContext context]) {
    if (AppLocalizations._inst != null) {
      return _inst._t(key);
    } else {
      print('error');
      return AppLocalizations.of(context)._t(key);
    }
  }

  static AppLocalizations of(BuildContext context) {
    _inst = Localizations.of(context, AppLocalizations);
    return _inst;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale locale;

  const AppLocalizationsDelegate([this.locale]);

  @override
  bool isSupported(Locale locale) {
    print('isSupported  -> ' + locale.toString());
    return ['zh', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale _locale) {
    print('load  ->  $_locale ${this.locale}');
    print(this.locale ?? _locale);
    return new SynchronousFuture<AppLocalizations>(
        new AppLocalizations(this.locale ?? _locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    print('locale shouldReload -> ' + old.toString());
    return false;
  }

  static AppLocalizationsDelegate delegate = AppLocalizationsDelegate();
}
