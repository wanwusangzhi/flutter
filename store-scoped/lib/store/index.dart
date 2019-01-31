import 'package:scoped_model/scoped_model.dart';
import 'package:demo/store/model/count.dart';

class MainState extends Model {}

class AppStore {
  static init(child) {
    CountModel countModel = CountModel();
    return ScopedModel<CountModel> (
      model: countModel,
      child: child,
    );
  }
}