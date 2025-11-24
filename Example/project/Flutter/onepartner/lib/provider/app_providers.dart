import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';
import 'package:onepartner/data/shared_preferences_db.dart';
import 'package:onepartner/model/auth_state.dart';

abstract class Dependencies {

  static List<SingleChildWidget> get providersLocal => [

    Provider<SharedPreferencesDB>.value(value: SharedPreferencesDB()),
  ];
}

