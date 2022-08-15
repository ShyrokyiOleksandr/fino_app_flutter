import 'package:fino/data/local/count_local_storage.dart';
import 'package:fino/domain/entities/transaction/transaction.dart';
import 'package:fino/domain/repositories/transactions_repository.dart';

class TransactionsRepositoryImpl extends TransactionsRepository {
  final TransactionsLocalStorage _transactionsLocalStorage;

  static final _dummyTransactions = [
    Transaction(id: '1', value: 200.0, date: DateTime.now(), comment: 'bla bla'),
    Transaction(id: '2', value: -300.0, date: DateTime.now(), comment: 'bla bla'),
    Transaction(id: '3', value: 100.0, date: DateTime.now(), comment: 'bla bla'),
    Transaction(id: '4', value: -1000.0, date: DateTime.now(), comment: 'bla bla'),
  ];

  TransactionsRepositoryImpl({
    required final TransactionsLocalStorage transactionsLocalStorage,
  }) : _transactionsLocalStorage = transactionsLocalStorage;

  @override
  Future<List<Transaction>> getTransactions() async {
    return _dummyTransactions;
  }
}
