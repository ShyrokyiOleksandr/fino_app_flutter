import 'package:freezed_annotation/freezed_annotation.dart';

part 'count_state.freezed.dart';

@freezed
class CountState with _$CountState {
  const CountState._();

  const factory CountState({
    required final int number,
    required final bool isLoading,
    required final Exception? loadingException,
  }) = _CountState;

  factory CountState.initial() {
    return const CountState(
      number: 0,
      isLoading: false,
      loadingException: null,
    );
  }
}
