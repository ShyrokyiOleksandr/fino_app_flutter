import 'package:fino/domain/repositories/count_repository.dart';
import 'package:fino/domain/use_cases/count/get_number_use_case.dart';
import 'package:fino/domain/use_cases/count/reset_number_use_case.dart';
import 'package:fino/domain/use_cases/count/update_number_use_case.dart';
import 'package:get_it/get_it.dart';

class AppServiceLocatorUseCases {
  static Future<void> setup({required GetIt instance}) async {
    instance.registerFactory<GetNumberUseCase>(
      () {
        return GetNumberUseCase(
          countRepository: instance<CountRepository>(),
        );
      },
    );
    instance.registerFactory<UpdateNumberUseCase>(
      () {
        return UpdateNumberUseCase(
          countRepository: instance<CountRepository>(),
        );
      },
    );
    instance.registerFactory<ResetNumberUseCase>(
      () {
        return ResetNumberUseCase(
          countRepository: instance<CountRepository>(),
        );
      },
    );
  }
}
