import 'package:fino/domain/repositories/count_repository.dart';

class UpdateNumberUseCase {
  final CountRepository _countRepository;

  UpdateNumberUseCase({
    required final CountRepository countRepository,
  }) : _countRepository = countRepository;

  Future<void> execute({required final int value}) async {
     await _countRepository.updateNumber(value: value);
  }
}