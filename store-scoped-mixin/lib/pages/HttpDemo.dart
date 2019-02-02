import 'package:flutter/material.dart';
import 'package:demo/components/common/basecomp.dart';
import 'package:demo/store/ApiHttp.dart';
import 'package:demo/i18n/index.dart';
class HttpDemo extends StatefulWidget {
  @override
  HttpDemoState createState() => HttpDemoState();
}

class HttpDemoState extends State<HttpDemo> {
  var htmlStr = '';

  @override
  void initState() {
    super.initState();
  }

  _getData() async {
    var ret = await ApiHttp.request(
        method: 'get',
        url: 'http://api.douban.com/v2/movie/top250',
        data: {
          "count": 25,
          'start': 25,
        });
    print("count${ret['count']}");
    setState(() {
      htmlStr = ret.toString();
    });
  }

  _getJSONData() async {
    var ret = await ApiHttp.request(
        method: 'post',
        url: 'http://api.douban.com/v2/movie/top250',
        data: {
          "count": 25,
          'start': 25,
        });
    print("count${ret['count']}");
    setState(() {
      htmlStr = "count:  ${ret['count']}     subjects length: ${ret['subjects'].length}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseComp(
      title: AppLocalizations.$t('httpdemo.title'),
      contentList: [
        Container(
          height: 300,
          child: Text(htmlStr),
        ),
        RaisedButton(
          child: Text('dio get Method'),
          onPressed: () {
            _getData();
          },
        ),
        RaisedButton(
          child: Text('dio post Method'),
          onPressed: () {
            _getJSONData();
          },
        ),
      ],
    );
  }
}
