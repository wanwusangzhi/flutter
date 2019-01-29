import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 国际化
import 'package:demo/i18n/index.dart';
import 'package:demo/components/common/basecomp.dart';
import 'package:demo/pages/NavigateDemo.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppLocalizationsDelegate _delegate;

  @override
  void initState() {
    super.initState();
    _delegate = AppLocalizationsDelegate.delegate;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) {
        return AppLocalizations.of(context, setState, _delegate).title;
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        _delegate,
      ],
      supportedLocales: [
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: BaseComp(
        title: 'title',
        contentList: [
          FirstPage()
        ],
      ),
    );
  }
}

void main() => runApp(MyApp());
