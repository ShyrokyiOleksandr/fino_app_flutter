import 'package:fino/domain/repositories/count_repository.dart';

class ResetNumberUseCase {
  final CountRepository _countRepository;

  ResetNumberUseCase({
    required final CountRepository countRepository,
  }) : _countRepository = countRepository;

  Future<void> execute() async {
    await _countRepository.resetNumber();
  }
}
