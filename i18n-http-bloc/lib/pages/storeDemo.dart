import 'package:flutter/material.dart';
import 'package:demo/components/common/basecomp.dart';
import 'package:demo/i18n/index.dart';
import 'package:demo/store/model/count.dart';

class StoreDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseComp(
      title: AppLocalizations.$t('storeDemo.title'),
      contentList: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'count: }',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Divider(),
            RaisedButton(
              child: Text('increment'),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text('decrement'),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text('store model get Method 2'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return StoreDemoMethod2();
                }));
              },
            ),
          ],
        ),
      ],
    );
  }
}

class StoreDemoMethod2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseComp(
      title: AppLocalizations.$t('storeDemo.title2'),
      contentList: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'Count: ',
              style: TextStyle(
                fontFamily: FontStyle.italic.toString(),
                fontSize: 20,
              ),
            ),
            RaisedButton(
              child: Text('decrement'),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
