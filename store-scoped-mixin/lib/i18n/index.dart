import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:demo/utils/file/file-reader.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppLocalizations {
  Locale _locale; // language
  static Function _setState; // setState
  static AppLocalizationsDelegate _delegate;
  static Map<String, dynamic> jsonLanguage;
  static AppLocalizations _inst; // inst

  AppLocalizations(this._locale);

  // init localizations
  static Future<AppLocalizations> init(Locale locale) async {
    _inst = AppLocalizations(locale);
    getLanguageJson();
    return _inst;
  }

  // 设置语言切换代理
  static void setProxy(
      Function setState, AppLocalizationsDelegate delegate) async {
    _setState = setState;
    _delegate = delegate;
  }

  static get languageCode => _inst._locale.languageCode;

  static void getLanguageJson([Locale locale]) async {
    Locale _tmpLocale = _inst._locale;
    print(_tmpLocale.languageCode);
    String jsonLang;
    try {
      jsonLang =
          await rootBundle.loadString('locale/${_tmpLocale.languageCode}.json');
    } catch (e) {
      _inst._locale = Locale(ConfigLanguage.defualtLanguage.code);
      jsonLang = await rootBundle
          .loadString('locale/${ConfigLanguage.defualtLanguage.code}.json');
    }
    json.decode(jsonLang);
    jsonLanguage = json.decode(jsonLang);
    print("当前语言： ${_inst._locale}");
    print("Json数据： ${jsonLanguage}");
    FileReaderUtil.writeJsonFile('locale.json', {"locale": _inst._locale.languageCode});
  }

  static void changeLanguage([Locale locale]) {
    if (locale == null) {
      locale = AppLocalizations.languageCode == 'zh'
          ? Locale('en', "US")
          : Locale("zh", "CH");
    }
    if (_inst._locale.languageCode == locale.languageCode) {
      print('语言相同 不需要切换');
      return;
    }
    _inst._locale = locale;
    getLanguageJson(); // 根据语言获取对应的国际化文件
    _setState(() {
      _delegate = AppLocalizationsDelegate(locale);
    });
  }

  // get local language
  _t(String key) {
    var _array = key.split('.');
    var _dict = jsonLanguage;
    var retValue = '';
    try {
      _array.forEach((item) {
        if (_dict[item].runtimeType == Null) {
          retValue = key;
          return;
        }
        if (_dict[item].runtimeType != String) {
          _dict = _dict[item];
        } else {
          retValue = _dict[item];
        }
      });
      retValue = retValue.isEmpty ? _dict : retValue;
    } catch (e) {
      print('i18n exception');
      print(e);
      retValue = key;
    }
    print('key   ${key}                value: ${retValue}');
    return retValue ?? '';
  }

  static String $t(String key) {
    return _inst._t(key);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale locale;

  AppLocalizationsDelegate([this.locale]);

  @override
  bool isSupported(Locale locale) {
    return ConfigLanguage.sopportLanguage.keys
        .toList()
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale _locale) async {
    Locale _tmpLocale = locale ?? _locale;
    return await AppLocalizations.init(_tmpLocale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    // false时 不执行上述重写函数
    return false;
  }
}

class ConfigLanguage {
  static List<Locale> supportedLocales = [
    Locale('zh', 'CH'),
    Locale('en', 'US'),
  ];

  static Map<String, dynamic> sopportLanguage = {
    "zh": {"code": "zh", "country_code": "CH"},
    "en": {"code": "en", "country_code": "US"}
  };

  static dynamic defualtLanguage = {"code": "zh", "country_code": "CH"};
}
