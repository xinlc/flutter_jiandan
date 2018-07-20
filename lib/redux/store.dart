import 'package:redux/redux.dart';

// reducer
import 'package:flutter_jiandan/redux/app/app_reducer.dart';

// state
import 'package:flutter_jiandan/redux/app/app_state.dart';

// middleware
import 'package:flutter_jiandan/redux/meizi/meizi_middleware.dart';

// api
import 'package:flutter_jiandan/api/meizi_api.dart';

Store<AppState> createStore() {
  var meiziApi = MeiziApi();

  return Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    // distinct: true,
    middleware: [
      MeiziMiddleware(meiziApi),
    ],
  );
}