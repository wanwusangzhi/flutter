import 'package:scoped_model/scoped_model.dart';
import 'model/count.dart';

class MainStateModel extends Model with CountModel {
  MainStateModel() {
    //
  }
  static MainStateModel of (context) => ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
}

class AppStore {
  static init(child) {
    MainStateModel _mainStateModel = MainStateModel();
    return ScopedModel<MainStateModel>(
      model: _mainStateModel,
      child: child,
    );
  }
  static connect ({
    builder,
    child,
    rebuildOnChange: true
  }) {
    return ScopedModelDescendant<MainStateModel> (
      builder: builder,
      child: child,
      rebuildOnChange: rebuildOnChange
    );
  }
}
