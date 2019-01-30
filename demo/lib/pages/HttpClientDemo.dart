import 'package:flutter/material.dart';
import 'package:demo/components/common/basecomp.dart';
import 'package:demo/store/ApiHttpClient.dart';
import 'package:demo/store/model/movie.dart';

class HttpClientDemo extends StatefulWidget {
  @override
  HttpClientDemoState createState() {
    return new HttpClientDemoState();
  }
}

class HttpClientDemoState extends State<HttpClientDemo> {
  String htmlStr = '123';

  @override
  void initState() {
    super.initState();
  }

  _getClientHtml() async {
    var _future = await ApiHttpClient.get(url: 'https://www.baidu.com');
    setState(() {
      htmlStr = _future.toString();
    });
  }
  _getClientJSON() async {
    var _future = await ApiHttpClient.getJSON(
        url: 'api.douban.com',
        path: '/v2/movie/top250',
        data: {"start": '25', "count": '25'},
        type: 'http');
    var _movie = Movie.fromJson(_future);
    print(_movie.count);
    print(_movie.subjects);
    setState(() {
      htmlStr = _future.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseComp(
      title: "asd",
      contentList: [
        Container(
          height: 300,
          child: Text(this.htmlStr),
        ),
        RaisedButton(
          child: Text('访问网站数据'),
          onPressed: () {
            _getClientHtml();
          },
        ),
        RaisedButton(
          child: Text('访问Api JSON数据'),
          onPressed: () {
            _getClientJSON();
          },
        ),
      ],
    );
  }
}
