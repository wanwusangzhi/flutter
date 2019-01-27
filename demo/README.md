# flutter i18n demo

## 概要
基于flutter官方文档，简单实现i18n切换。

## 架构
|--main.dart                // 主入口
|--components               // 公共组件目录
    |--common
        --basecomp.dart     // 组件
|--i18n                     // 国际化目录
    --index.dart            // 国际化文件主入口
    --location.dart         // 国际化配置

## 实现
#### 1 创建StatefulWidget组件MyApp. 同时实现_MyAppState类
#### 2 类_MyAppState中实现简单的MaterialApp组件
#### 3 根据FLUTTER文档，国际化需要在MaterialApp实现以下两个属性，暂时增加中英文国际语言
```
@override
Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            // _delegate
        ],
        supportedLocales: [
            Locale('zh', 'CH'),
            Locale('en', 'US'),
        ],
    );
};
```
接着我们要实现localizationsDelegates中的_delegate部分。
在实现之前把需要的国际化配置与实例先实现了。
#### 4 i18n/location.dart
location.dart 针对中英文提供一份json配置文件，切换国际化时使用。
```
const LANGUAGE_DICT = {
  'zh': {
    'code': 'zh',
    'country_code': 'CH'
  },
  'en': {
    'code': 'en',
    'country_code': 'US'
  }
};

const LANGUAGE_JSON = {
'en': {"title": 'english', "btn": 'Button'},
"zh": {"title": '中文', "btn": "按钮"}
};
```

#### 5 i18n/index.dart
实现LocalizationsDelegate并在main.dart初始化使用。
```
class AppLocalizations {
    static AppLocalizations _inst           存储实现化对象
    Locale _locale                          记录当前语言
    Function _setState                      从父组件传递，修改后能改变所有widget语言。
    AppLocalizationsDelegate _delegate      从父组件传递，MaterialApp中localizationsDelegates实现的国际化代理对象，修改国际化时，通过setState触发widget更新
    AppLocalizations(this._locale)          构造函数
    // 下面of函数是关键点之一
    static AppLocalizations of(BuildContext context, Function setState, AppLocalizationsDelegate delegate)
    // context, setState, delegate都是从父组件传递下来。改变语言时，主要通过setState对delegate进行修改。
    static String $t(String key)            在widget页面中通过AppLocalizations.$t(key)方法拿到国际化的值
    _t(String key)                          实现处理$t逻辑的函数，把配置的LANGUAGE_JSON数据和当前_locale.code值，返回国际化内容。
    get languageCode                        获取当前语言code值
    void changeLanguage(Locale locale)      关键点之一，改变语言时，其实是生成多一个AppLocalizationsDelegate对象，通过setState重新赋值
}


AppLocalizationsDelegate {
    /**
    * 关键实现点之一，在实现AppLocailzations时，先判断系统语言或者changeLanguage实例化传入构造函数的locale
    * new AppLocalizations(this.locale ?? _locale))
    */
    @override
    Future<AppLocalizations> load(Locale _locale) {
    return new SynchronousFuture<AppLocalizations>(
        new AppLocalizations(this.locale ?? _locale));
    }
}
```


```
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:demo/i18n/location.dart';

class AppLocalizations {
  static AppLocalizations _inst; // inst
  Locale _locale; // language
  Function _setState; // setState
  AppLocalizationsDelegate _delegate;

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
    return LANGUAGE_JSON[_locale.languageCode][key] ?? '';
  }

  static String $t(String key) {
    return _inst._t(key);
  }

  // init localizations
  // setState: main.dart setState
  static AppLocalizations of(BuildContext context, setState, delegate) {
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


```

#### 6 main.dart
```
1 在MaterialApp实例AppLocalizations时，需要传入context对象，但该对象需要在onGenerateTitle实现。
onGenerateTitle: (context) {
    return AppLocalizations.of(context, setState, _delegate).title;
},
该context对象与Widget build(BuildContext context)中的context是不一样的。不能传入Widget build(BuildContext context)中的context,
实现了MaterialApp中的onGenerateTitle就不需要再实现title了。
2 AppLocalizations.$t('title')可以获取到值。
3 AppLocalizations.changeLanguage(null)实现切换语言。

```




