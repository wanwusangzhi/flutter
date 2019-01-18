import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 国际化
import 'package:demo/i18n/location.dart';
import 'package:demo/components/common/basecomp.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.purple,
        ),
      ),
      child: Center(
        child: Text('Center'),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) {
        return AppLocalizations.of(context).title;
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizationsDelegate.delegate,
      ],
      supportedLocales: [
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
      // title: AppLocalizations.of(context).title,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: BaseComp(
        title: 'title',
        contentList: [
          FirstPage(),
          FirstPage(),
        ],
      ),
    );
  }
}

void main() => runApp(MyApp());
