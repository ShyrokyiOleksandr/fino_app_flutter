import 'package:fino/domain/use_cases/transaction/get_transactions_use_case.dart';
import 'package:fino/presentation/features/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetTransactionsUseCase _getTransactionsUseCase;

  HomeCubit({
    required final GetTransactionsUseCase getTransactionsUseCase,
  })  : _getTransactionsUseCase = getTransactionsUseCase,
        super(HomeState.initial()) {
    loadTransactions();
  }

  void loadTransactions() async {
    emit(state.copyWith(isLoading: true, loadingException: null));
    try {
      final transactions = await _getTransactionsUseCase.execute();
      final balance = transactions.fold<double>(0, (previous, current) => previous + current.value);
      final totalIncome = transactions
          .where((element) => element.value >= 0)
          .fold<double>(0, (previous, current) => previous + current.value);
      final totalCost = transactions
          .where((element) => element.value < 0)
          .fold<double>(0, (previous, current) => previous + current.value);
      emit(state.copyWith(
        isLoading: false,
        transactions: transactions,
        balance: balance,
        totalIncome: totalIncome,
        totalCost: totalCost,
      ));
    } on Exception catch (exception) {
      emit(state.copyWith(isLoading: false, loadingException: exception));
    }
  }
}
