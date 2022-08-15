import 'package:shared_preferences/shared_preferences.dart';

class TransactionsLocalStorage {
  static const String _keyTransactions = "TRANSACTIONS";

  final SharedPreferences _sharedPreferences;

  TransactionsLocalStorage({
    required final SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  String getTransactions() {
    return _sharedPreferences.getString(_keyTransactions) ?? '';
  }
}
