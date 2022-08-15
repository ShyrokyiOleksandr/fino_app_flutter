import 'package:fino/domain/entities/transaction/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    required final List<Transaction> transactions,
    required final bool isLoading,
    required final Exception? loadingException,
  }) = _HomeState;

  factory HomeState.initial() {
    return const HomeState(
      transactions: [],
      isLoading: false,
      loadingException: null,
    );
  }
}
