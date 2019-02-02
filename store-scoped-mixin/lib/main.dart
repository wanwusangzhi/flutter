import 'package:flutter/material.dart';
// 国际化
import 'package:flutter_localizations/flutter_localizations.dart'; // 国际化
import 'package:demo/i18n/index.dart';
// 基础组件
import 'package:demo/components/common/basecomp.dart';
// 数据层
import 'package:demo/store/index.dart';
import 'package:demo/pages/NavigateDemo.dart';
import 'package:demo/utils/file/file-reader.dart';

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
    init();
  }
  void init() async {
    String value = await FileReaderUtil.readValueByKey('locale.json', 'locale');
    if (value != null) {
      print("locale language = $value");
      AppLocalizations.changeLanguage(Locale(value));
    }
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
