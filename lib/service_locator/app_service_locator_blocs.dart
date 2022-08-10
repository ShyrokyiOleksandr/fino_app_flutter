import 'package:fino/domain/use_cases/count/get_number_use_case.dart';
import 'package:fino/domain/use_cases/count/reset_number_use_case.dart';
import 'package:fino/domain/use_cases/count/update_number_use_case.dart';
import 'package:fino/presentation/features/count/count_cubit.dart';
import 'package:get_it/get_it.dart';

class AppServiceLocatorBlocs {
  static Future<void> setup({required GetIt instance}) async {
    //has to be one instance per session:
    instance.registerFactory<CountCubit>(
      () {
        return CountCubit(
          getNumberUseCase: instance<GetNumberUseCase>(),
          updateNumberUseCase: instance<UpdateNumberUseCase>(),
          resetNumberUseCase: instance<ResetNumberUseCase>(),
        );
      },
    );
  }
}
