import 'package:shared_preferences/shared_preferences.dart';

class CountLocalStorage {
  static const String _keyCount = "COUNT";

  final SharedPreferences _sharedPreferences;

  CountLocalStorage({
    required final SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  int getNumber() {
    return _sharedPreferences.getInt(_keyCount) ?? 0;
  }

  Future<void> storeNumber({required final int value}) async {
    await _sharedPreferences.setInt(_keyCount, value);
  }

  Future<void> removeNumber() async {
    await _sharedPreferences.remove(_keyCount);
  }
}
