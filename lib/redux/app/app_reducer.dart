
import 'package:flutter_jiandan/redux/app/app_state.dart';
import 'package:flutter_jiandan/redux/meizi/meizi_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    meiziState: meiziReducer(state.meiziState, action),
  );
}