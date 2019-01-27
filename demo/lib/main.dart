import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 国际化
import 'package:demo/i18n/index.dart';
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
        child: RaisedButton(
          child: Text(AppLocalizations.$t('nav.title')),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SecondPage();
            }));
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.$t('nav.title')),
        ),
        body: Center(
          child: Row(
            children: <Widget>[
              RaisedButton(
                child: Text('changLanguage'),
                onPressed: () {
                  AppLocalizations.changeLanguage(null);
                }
              ),
              Text(AppLocalizations.$t('title'))
            ],
          ),
        ),
      );
  }
}

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
      // title: AppLocalizations.of(context).title,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: BaseComp(
        title: 'title',
        contentList: [
          FirstPage(),
          RaisedButton(
            child: Text('btn'),
            onPressed: () {
              print(AppLocalizations.languageCode);
              Locale locale = AppLocalizations.languageCode == 'zh' ? Locale('en', "US") : Locale("zh", "CH");
              AppLocalizations.changeLanguage(locale);
            },
          )
        ],
      ),
    );
  }
}

void main() => runApp(MyApp());
