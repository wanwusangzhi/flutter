import 'package:scoped_model/scoped_model.dart';
/// 通过MainStateModel实现后，需要把原来的继续改成一个mixin类
// class CountModel extends Model {
mixin CountModel on Model {
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
}