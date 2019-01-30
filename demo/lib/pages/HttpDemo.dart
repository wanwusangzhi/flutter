import 'package:flutter/material.dart';
import 'package:demo/components/common/basecomp.dart';
import 'package:demo/store/ApiHttp.dart';

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
    var ret =
        await ApiHttp.request(method: 'get', url: 'https://www.baidu.com', data: {});
    print(ret);
  }

  _getJSONData() async {
    var ret = await ApiHttp.request(
        method: 'post',
        url: 'http://http://api.douban.com',
        data: {
          "count": 25,
          'start': 25,
        });
    print(ret);
  }

  @override
  Widget build(BuildContext context) {
    return BaseComp(
      title: "asd",
      contentList: [
        Container(
          height: 300,
          child: Text('---'),
        ),
        RaisedButton(
          child: Text('html click'),
          onPressed: () {
            _getData();
          },
        ),
        RaisedButton(
          child: Text('html click'),
          onPressed: () {
            _getJSONData();
          },
        ),
      ],
    );
  }
}
