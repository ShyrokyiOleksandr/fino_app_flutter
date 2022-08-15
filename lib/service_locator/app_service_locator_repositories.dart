import 'package:fino/data/local/count_local_storage.dart';
import 'package:fino/data/repositories/transactions_repository_impl.dart';
import 'package:fino/domain/repositories/transactions_repository.dart';
import 'package:get_it/get_it.dart';

class AppServiceLocatorRepositories {
  static Future<void> setup({required GetIt instance}) async {
    instance.registerLazySingleton<TransactionsRepository>(
      () {
        return TransactionsRepositoryImpl(transactionsLocalStorage: instance<TransactionsLocalStorage>());
      },
    );
  }
}
