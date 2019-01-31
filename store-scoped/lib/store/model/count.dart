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
  CountModel of (context) {
    return ScopedModel.of<CountModel>(context, rebuildOnChange: true);
  }
}