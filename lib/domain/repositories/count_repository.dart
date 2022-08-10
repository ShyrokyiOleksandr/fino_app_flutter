abstract class CountRepository {
  Future<int> getNumber();

  Future<void> updateNumber({required final int value});

  Future<void> resetNumber();
}
