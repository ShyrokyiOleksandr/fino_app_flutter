import 'package:fino/domain/use_cases/transaction/get_transactions_use_case.dart';
import 'package:fino/presentation/features/home/home_cubit.dart';
import 'package:get_it/get_it.dart';

class AppServiceLocatorBlocs {
  static Future<void> setup({required GetIt instance}) async {
    instance.registerFactory<HomeCubit>(
      () {
        return HomeCubit(
          getTransactionsUseCase: instance<GetTransactionsUseCase>(),
        );
      },
    );
  }
}
