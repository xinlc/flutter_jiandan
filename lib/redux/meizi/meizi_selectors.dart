import 'dart:collection';

import 'package:flutter_jiandan/models/meizi.dart';
import 'package:flutter_jiandan/redux/app/app_state.dart';

List<Meizi> meiziSelector(AppState state) {
  List<Meizi> meiziList = state.meiziState.meiziList;
  return meiziList.toList();
}

// List<Meizi> _meiziWithSearchQuery(AppState state, List<Meizi> original) {
//   var searchQuery = RegExp(state.searchQuery, caseSensitive: false);

//   return original.where((meizi) {
//     return meizi.title.contains(searchQuery) ||
//         meizi.title.contains(searchQuery);
//   }).toList();
// }
