import 'package:collection/collection.dart';
import 'package:flutter_jiandan/models/meizi.dart';
import 'package:flutter_jiandan/models/loading_status.dart';
import 'package:flutter_jiandan/redux/app/app_state.dart';
import 'package:flutter_jiandan/redux/meizi/meizi_actions.dart';
import 'package:flutter_jiandan/redux/meizi/meizi_selectors.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class MeiziPageViewModel {
  MeiziPageViewModel({
    @required this.status,
    @required this.meiziList,
    @required this.refresh,
    @required this.loadMore,
    @required this.curPage,
    @required this.pageCount,
  });

  final LoadingStatus status;
  final List<Meizi> meiziList;
  final Function refresh;
  final Function loadMore;
  final int curPage;
  final int pageCount;

  static MeiziPageViewModel fromStore(Store<AppState> store,) {
    return MeiziPageViewModel(
      status: store.state.meiziState.loadingStatus,
      curPage: store.state.meiziState.curPage,
      pageCount: store.state.meiziState.pageCount,
      meiziList: meiziSelector(store.state),
      refresh: () async {
        store.dispatch(RefreshMeiziListAction());
        // TODO：延迟
        return null;
      },
      loadMore: () {
        store.dispatch(FetchMeiziListAction());
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeiziPageViewModel &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          const IterableEquality().equals(meiziList, other.meiziList);

  @override
  int get hashCode =>
      status.hashCode ^
      const IterableEquality().hash(meiziList);
}