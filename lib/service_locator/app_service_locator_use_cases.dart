import 'package:fino/domain/repositories/transactions_repository.dart';
import 'package:fino/domain/use_cases/transaction/get_transactions_use_case.dart';
import 'package:get_it/get_it.dart';

class AppServiceLocatorUseCases {
  static Future<void> setup({required GetIt instance}) async {
    instance.registerFactory<GetTransactionsUseCase>(
      () {
        return GetTransactionsUseCase(
          transactionsRepository: instance<TransactionsRepository>(),
        );
      },
    );
  }
}
