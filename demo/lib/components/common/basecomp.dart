import 'package:flutter/material.dart';
import 'package:demo/i18n/index.dart';

class BaseComp extends StatelessWidget {
  final List<dynamic> contentList;
  final String title;

  BaseComp({
    Key key,
    @required this.title,
    this.contentList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(AppLocalizations.$t(this.title));
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.$t(this.title)),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
          Column(
            children: _render(),
          ),
        ]),
      ),
    );
  }

  List<Widget> _render() {
    List<Widget> _list = [];
    this.contentList.forEach((item) {
      _list.add(item);
    });
    return _list.toList();
  }
}
