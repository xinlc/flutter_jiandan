import 'dart:async';

import 'package:redux/redux.dart';
import 'package:flutter_jiandan/redux/app/app_state.dart';
import 'package:flutter_jiandan/redux/meizi/meizi_actions.dart';
import 'package:flutter_jiandan/api/meizi_api.dart';
import 'package:flutter_jiandan/models/meizi.dart';

class MeiziMiddleware extends MiddlewareClass<AppState> {
  MeiziMiddleware(this.api);
  final MeiziApi api;

  @override
  Future<Null> call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    if (action is FetchMeiziListAction) {
      await _fetchMeiziList(store.state.meiziState.curPage + 1, store, next);
    }
    if (action is RefreshMeiziListAction) {
      await _fetchMeiziList(1, store, next);
    }
  }

  Future<Null> _fetchMeiziList(
    int page,
    Store<AppState> store,
    NextDispatcher next,
  ) async {
    next(RequestingMeiziListAction());

    try {
      Map<String, dynamic> map = await api.fetchMeiziList(page);
      List<Meizi> list = [];
      var pageCount = map['pageCount'];
      if (page == 1) {
        list = map['list'];
      } else {
        var preList = store.state.meiziState.meiziList;
        for (var e in preList) {
          list.add(e);
        }
        list.addAll(map['list']);
      }
      next(ReceivedMeiziListAction(
        meiziList: list,
        curPage: page,
        pageCount: pageCount,
      ));
    } catch (e) {
      next(ErrorLoadingMeiziListAction());
    }
  }
}