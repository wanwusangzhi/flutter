import 'package:flutter/material.dart';
import 'package:demo/components/common/basecomp.dart';
import 'package:demo/i18n/index.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:demo/store/model/count.dart';
import 'package:demo/store/index.dart';

class StoreDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseComp(
      title: AppLocalizations.$t('storeDemo.title'),
      contentList: <Widget>[
        ScopedModelDescendant<MainStateModel>(
          rebuildOnChange: true,
          builder: (context, child, model) {
            return Column(
              children: <Widget>[
                Text(
                  'count: ${model.count}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Divider(),
                RaisedButton(
                  child: Text('increment'),
                  onPressed: () {
                    model.increment();
                  },
                ),
                RaisedButton(
                  child: Text('decrement'),
                  onPressed: () {
                    model.decrement();
                  },
                ),
                RaisedButton(
                  child: Text('store model get Method 2'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return StoreDemoMethod2();
                    }));
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class StoreDemoMethod2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final countModel = ScopedModel.of<MainStateModel>(context);
    final countModel = MainStateModel.of(context);
    return BaseComp(
      title: AppLocalizations.$t('storeDemo.title2'),
      contentList: <Widget>[
        Column(
          children: <Widget>[
            Text(
              'Count: ${countModel.count}',
              style: TextStyle(
                fontFamily: FontStyle.italic.toString(),
                fontSize: 20,
              ),
            ),
            RaisedButton(
              child: Text('decrement'),
              onPressed: () {
                countModel.decrement();
              },
            ),
          ],
        ),
      ],
    );
  }
}
