import 'package:meta/meta.dart';
import 'package:flutter_jiandan/redux/meizi/meizi_state.dart';

@immutable
class AppState {
  AppState({
    @required this.meiziState,
  });

  final MeiziState meiziState;

  factory AppState.initial() {
    return AppState(
      meiziState: MeiziState.initial(),
    );
  }

  AppState copyWith({
    MeiziState meiziState,
  }) {
    return AppState(
      meiziState: meiziState ?? this.meiziState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              meiziState == other.meiziState;

  @override
  int get hashCode =>
      meiziState.hashCode;
}