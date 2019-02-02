import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 国际化
import 'package:demo/i18n/index.dart';
import 'package:demo/i18n/config.dart';
import 'package:demo/components/common/basecomp.dart';
import 'package:demo/pages/NavigateDemo.dart';
import 'package:demo/store/index.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppLocalizationsDelegate _delegate;

  @override
  void initState() {
    super.initState();
    _delegate = AppLocalizationsDelegate();
  }

  @override
  Widget build(BuildContext context) {
    return AppStore.init(
      MaterialApp(
        localeResolutionCallback: (deviceLocale, supportLocale) {
          Locale _locale = supportLocale.contains(deviceLocale)
              ? deviceLocale
              : Locale('en');
          return _locale;
        },
        onGenerateTitle: (context) {
          // 设置多语言代理
          AppLocalizations.setProxy(setState, _delegate);
          return AppLocalizations.$t('title');
        },
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          _delegate,
        ],
        supportedLocales: ConfigLanguage.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: BaseComp(
          title: 'title',
          contentList: [FirstPage()],
        ),
      ),
    );
  }
}

void main() => runApp(MyApp());
