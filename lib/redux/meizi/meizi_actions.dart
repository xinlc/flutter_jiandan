import 'package:flutter/foundation.dart';
import 'package:flutter_jiandan/models/meizi.dart';

// service
class RefreshMeiziListAction {}
class FetchMeiziListAction {}
class RequestingMeiziListAction {}
class ErrorLoadingMeiziListAction {}

// reducer
class ReceivedMeiziListAction {
  ReceivedMeiziListAction({
    @required this.meiziList,
    @required this.curPage,
    @required this.pageCount,
  });

  final List<Meizi> meiziList;
  final int curPage;
  final int pageCount;
}