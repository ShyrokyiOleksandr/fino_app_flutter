import 'package:fino/domain/entities/transaction/transaction.dart';

abstract class TransactionsRepository {
  Future<List<Transaction>> getTransactions();
}