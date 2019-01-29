import 'package:flutter/material.dart';
import 'package:demo/components/common/basecomp.dart';
import 'package:demo/i18n/index.dart';
import 'package:demo/pages/HttpDemo.dart';

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
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text(AppLocalizations.$t('nav.title')),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SecondPage();
                }));
              },
            ),
            RaisedButton(
              child: Text(AppLocalizations.$t('httpdemo.title')),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HttpDemo();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseComp(title: AppLocalizations.$t('nav.title'), contentList: [
      Center(
        child: Row(
          children: <Widget>[
            RaisedButton(
                child: Text('changLanguage'),
                onPressed: () {
                  AppLocalizations.changeLanguage(null);
                }),
            Text(AppLocalizations.$t('title'))
          ],
        ),
      ),
    ]);
  }
}
