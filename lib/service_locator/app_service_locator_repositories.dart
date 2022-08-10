import 'package:fino/data/local/count_local_storage.dart';
import 'package:fino/data/repositories/count_repository_impl.dart';
import 'package:fino/domain/repositories/count_repository.dart';
import 'package:get_it/get_it.dart';

class AppServiceLocatorRepositories {
  static Future<void> setup({required GetIt instance}) async {
    instance.registerLazySingleton<CountRepository>(
      () {
        return CountRepositoryImpl(
          countLocalStorage: instance<CountLocalStorage>()
        );
      },
    );
  }
}
