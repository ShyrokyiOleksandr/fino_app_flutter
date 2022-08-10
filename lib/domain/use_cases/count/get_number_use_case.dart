import 'package:fino/domain/repositories/count_repository.dart';

class GetNumberUseCase {
  final CountRepository _countRepository;

  GetNumberUseCase({
    required final CountRepository countRepository,
  }) : _countRepository = countRepository;

  Future<int> execute() async {
    return await _countRepository.getNumber();
  }
}
