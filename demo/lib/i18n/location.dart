import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // 初始化对照表
  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      "title": 'english',
    },
    "zh": {"title": '中文'}
  };
  get title {
    print('title--------');
    return _localizedValues[locale.languageCode]['title'];
  }

  _t (String key) {
    return _localizedValues[locale.languageCode][key];
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
  @override
  bool isSupported(Locale locale) {
    print('locale  -> ' + locale.toString());
    return ['zh', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return new SynchronousFuture<AppLocalizations>(
        new AppLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    print('locale shouldReload -> ' + old.toString());
    return false;
  }

  static AppLocalizationsDelegate delegate = AppLocalizationsDelegate();
}
