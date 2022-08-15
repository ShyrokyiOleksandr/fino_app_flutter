import 'package:fino/data/local/count_local_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppServiceLocatorLocalStorages {
  static Future<void> setup({required GetIt instance}) async {
    instance.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance(),
    );
    instance.registerLazySingleton<TransactionsLocalStorage>(
      () {
        return TransactionsLocalStorage(
          sharedPreferences: instance<SharedPreferences>(),
        );
      },
    );
  }
}
