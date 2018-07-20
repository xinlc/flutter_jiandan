import 'package:redux/redux.dart';
import 'package:flutter_jiandan/models/loading_status.dart';
import 'package:flutter_jiandan/redux/meizi/meizi_actions.dart';
import 'package:flutter_jiandan/redux/meizi/meizi_state.dart';

final meiziReducer = combineReducers<MeiziState>([
  TypedReducer<MeiziState, ReceivedMeiziListAction>(_receivedMeiziList),
]);

MeiziState _receivedMeiziList(
  MeiziState state, dynamic action) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    meiziList: action.meiziList,
    curPage: action.curPage,
    pageCount: action.pageCount,
  );
}
