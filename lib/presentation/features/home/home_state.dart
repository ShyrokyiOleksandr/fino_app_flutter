import 'package:fino/domain/entities/transaction/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    required final double balance,
    required final double totalIncome,
    required final double totalCost,
    required final List<Transaction> transactions,
    required final bool isLoading,
    required final Exception? loadingException,
  }) = _HomeState;

  factory HomeState.initial() {
    return const HomeState(
      balance: 0.0,
      totalIncome: 0.0,
      totalCost: 0.0,
      transactions: [],
      isLoading: false,
      loadingException: null,
    );
  }
}
