import 'package:flutter/material.dart';
import 'package:demo/components/common/basecomp.dart';
import 'package:demo/i18n/index.dart';
import 'package:demo/pages/HttpDemo.dart';
import 'package:demo/pages/HttpClientDemo.dart';
import 'package:demo/pages/storeDemo.dart';

///
/// 首页
///
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            RaisedButton(
              child: Text(AppLocalizations.$t('clientDemo.btn'),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HttpClientDemo();
                }));
              },
            ),
            RaisedButton(
              child: Text(AppLocalizations.$t('storeDemo.title')),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return StoreDemo();
                },));
              }
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
                child: Text(AppLocalizations.$t(AppLocalizations.languageCode)),
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
