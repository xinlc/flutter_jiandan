import 'package:flutter_jiandan/models/meizi.dart';
import 'package:flutter_jiandan/models/loading_status.dart';
import 'package:meta/meta.dart';

@immutable
class MeiziState {
  MeiziState({
    @required this.loadingStatus,
    @required this.meiziList,
    @required this.curPage,
    @required this.pageCount,
  });

  final LoadingStatus loadingStatus;
  final List<Meizi> meiziList;
  final int curPage;
  final int pageCount;

  factory MeiziState.initial() {
    return MeiziState(
      loadingStatus: LoadingStatus.loading,
      meiziList: <Meizi>[],
      curPage: 1,
      pageCount: 10,
    );
  }

  MeiziState copyWith({
    LoadingStatus loadingStatus,
    List<Meizi> meiziList,
    int curPage,
    int pageCount,
  }) {
    return MeiziState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      meiziList: meiziList ?? this.meiziList,
      curPage: curPage ?? this.curPage,
      pageCount: pageCount ?? this.pageCount,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MeiziState &&
              runtimeType == other.runtimeType &&
              loadingStatus == other.loadingStatus &&
              meiziList == other.meiziList;

  @override
  int get hashCode =>
      loadingStatus.hashCode ^
      meiziList.hashCode;
}