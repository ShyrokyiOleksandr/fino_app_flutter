import 'package:fino/domain/use_cases/count/get_number_use_case.dart';
import 'package:fino/domain/use_cases/count/reset_number_use_case.dart';
import 'package:fino/domain/use_cases/count/update_number_use_case.dart';
import 'package:fino/presentation/features/count/count_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountCubit extends Cubit<CountState> {
  final GetNumberUseCase _getNumberUseCase;
  final UpdateNumberUseCase _updateNumberUseCase;
  final ResetNumberUseCase _resetNumberUseCase;

  CountCubit({
    required final GetNumberUseCase getNumberUseCase,
    required final UpdateNumberUseCase updateNumberUseCase,
    required final ResetNumberUseCase resetNumberUseCase,
  })  : _getNumberUseCase = getNumberUseCase,
        _updateNumberUseCase = updateNumberUseCase,
        _resetNumberUseCase = resetNumberUseCase,
        super(CountState.initial()) {
    loadNumber();
  }

  void loadNumber() async {
    emit(state.copyWith(isLoading: true, loadingException: null));
    try {
      final number = await _getNumberUseCase.execute();
      emit(state.copyWith(isLoading: false, number: number));
    } on Exception catch (exception) {
      emit(state.copyWith(isLoading: false, loadingException: exception));
    }
  }

  void incrementNumber() async {
    try {
      await _updateNumberUseCase.execute(value: state.number + 1);
      emit(state.copyWith(isLoading: false, number: state.number + 1));
    } on Exception catch (exception) {
      emit(state.copyWith(isLoading: false, loadingException: exception));
    }
  }

  void resetNumber() async {
    try {
      await _resetNumberUseCase.execute();
      emit(state.copyWith(isLoading: false, number: 0));
    } on Exception catch (exception) {
      emit(state.copyWith(isLoading: false, loadingException: exception));
    }
  }
}
