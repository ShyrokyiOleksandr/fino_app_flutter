import 'package:fino/data/local/count_local_storage.dart';
import 'package:fino/domain/repositories/count_repository.dart';

class CountRepositoryImpl extends CountRepository {
  final CountLocalStorage _countLocalStorage;

  CountRepositoryImpl({
    required final CountLocalStorage countLocalStorage,
  }) : _countLocalStorage = countLocalStorage;

  @override
  Future<int> getNumber() async {
    return _countLocalStorage.getNumber();
  }

  @override
  Future<void> updateNumber({required int value}) async {
    await _countLocalStorage.storeNumber(value: value);
  }

  @override
  Future<void> resetNumber() async {
    await _countLocalStorage.removeNumber();
  }
}
