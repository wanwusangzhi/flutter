import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:demo/i18n/location.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  Locale _locale; // language
  Function _setState; // setState
  AppLocalizationsDelegate _delegate;
  Map<String, dynamic> jsonLanguage;
  static AppLocalizations _inst; // inst

  AppLocalizations(this._locale);


  get title {
    return LANGUAGE_JSON[_locale.languageCode]['title'];
  }

  static get languageCode => _inst._locale.languageCode;


  static void changeLanguage(Locale locale) {
    if (locale == null) {
      locale = AppLocalizations.languageCode == 'zh' ? Locale('en', "US") : Locale("zh", "CH");
    }
    _inst._locale = locale;
    _inst._setState(() {
      _inst._delegate = AppLocalizationsDelegate(locale);
    });
  }

  // get local language
  _t(String key) {
    var _array = key.split('.');
    var _dict = LANGUAGE_JSON[_locale.languageCode];
    var retValue = '';
    try {
      _array.forEach((item) {
        if (_dict[item].runtimeType == Null) {
          retValue = key;
          return ;
        }
        if (_dict[item].runtimeType != String) {
          _dict = _dict[item];
        } else {
          retValue = _dict[item];
        }
      });
      retValue = retValue.isEmpty ? _dict : retValue;
    } catch(e) {
      print('i18n exception');
      print(e);
      retValue = key;
    }
    return retValue ?? '';
  }

  static String $t(String key) {
    return _inst._t(key);
  }

  // init localizations
  // setState: main.dart setState
  static AppLocalizations of(BuildContext context, Function setState, AppLocalizationsDelegate delegate) {
    _inst = Localizations.of(context, AppLocalizations);
    _inst._setState = setState;
    _inst._delegate = delegate;
    return _inst;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale locale;

  const AppLocalizationsDelegate([this.locale]);

  @override
  bool isSupported(Locale locale) {
    return LANGUAGE_DICT.keys.toList().contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale _locale) {
    this.locale ?? _locale;
    print(this.locale);
    // AssetBundle.loadString('locale/${this.locale}', true);
    return new SynchronousFuture<AppLocalizations>(
        new AppLocalizations(this.locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }

  static AppLocalizationsDelegate delegate = AppLocalizationsDelegate();
}
