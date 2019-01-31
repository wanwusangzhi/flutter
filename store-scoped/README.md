# flutter scoped demo

------
## 概要
基于flutter官方文档，接入scoped练习。

------
## 架构
```
|--main.dart                // 主入口
|--components               // 公共组件目录
    |--common
        --basecomp.dart     // 组件
|--i18n                     // 国际化目录
    --index.dart            // 国际化文件主入口
    --config.dart           // 国际化配置

|--store                    // 数据层目录
    --index.dart            // model主入口
```
------
## 实现

#### 1. pubspec.yaml中添加scoped_model
版本参考地址: [https://pub.dartlang.org/packages/scoped_model](https://pub.dartlang.org/packages/scoped_model)
```
dependencies:
  dio: ^1.0.14
  flutter:
    sdk: flutter
  scoped_model: ^1.0.1
```
#### 2. 创建store/model/count.dart
> * 类继续Model
> * 状态变化后通过notifyListeners通知用到model的组件更新

```
import 'package:scoped_model/scoped_model.dart';

class CountModel extends Model {
  int _count = 0;
  get count => _count;

  void increment () {
    _count++;
    notifyListeners();
  }
}
```

#### 3. 创建store/index.dart
> * ScopedModel接收一个model, 在初始化时，需要两个参数，model,child
> * ScopedModel会将接收到的model绑定在child中，当nofityListeners通知变化时，会刷新child页面引用的model的数据

```
import 'package:scoped_model/scoped_model.dart';
import 'package:demo/store/model/count.dart';

class AppStore {
  static init(child) {
    CountModel countModel = CountModel();
    return ScopedModel<CountModel> (
      model: countModel,
      child: child
    );
  }
}
```

#### 4. 在main.dart中引入store
> * 通过引入store，使用init进行全局注册

```
import 'package:demo/store/index.dart';

// 省略code
...
Widget build(BuildContext context) {
  return AppStore.init(
    // 省略code
    ...code
  );
}
...
// 省略code

```

#### 5. 子页面中使用store
> * ScopedModelDescendant<CountModel>(builder, child, rebuildOnChange) 接收三个参数, builder是必须的
> * ScopedModelDescendantBuilder<CountModel>(BuildContext context, Widget child, T model) 接收三个参数, 参数model能获取到CountModel实例

```
import 'package:flutter/material.dart';
import 'package:demo/components/common/basecomp.dart';
import 'package:demo/i18n/index.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:demo/store/model/count.dart';

class StoreDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseComp(
      title: AppLocalizations.$t('storeDemo.title'),
      contentList: <Widget>[
        ScopedModelDescendant<CountModel>(
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
              ],
            );
          },
        ),
      ],
    );
  }
}
```

#### 6. 子页面中使用store方法二
> * store/model/count.dart中重写of方法，注意参数中rebuildOnChange值设置为true,页面中的数据才会同步刷新变化。
> * ScopedModel.of<CountModel>(context, rebuildOnChange: true); 
> * final countModel = CountModel().of(context); 获取到countModel实例, 在页面中直接通过countModel.count调用

```
import 'package:scoped_model/scoped_model.dart';

class CountModel extends Model {
  int _count = 0;
  get count => _count;

  void increment () {
    _count++;
    notifyListeners();
  }
  void decrement () {
    _count--;
    notifyListeners();
  }
  // 重写of方法
  // rebuildOnChange默认为false, 需要设置为true时，页面引用的数据才会变化
  CountModel of (context) {
    return ScopedModel.of<CountModel>(context, rebuildOnChange: true);
  }
}

```

```
class StoreDemoMethod2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final countModel = CountModel().of(context);
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

```

