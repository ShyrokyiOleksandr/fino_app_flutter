import 'package:fino/domain/entities/transaction/transaction.dart';
import 'package:fino/domain/repositories/transactions_repository.dart';

class GetTransactionsUseCase {
  final TransactionsRepository _transactionsRepository;

  GetTransactionsUseCase({
    required final TransactionsRepository transactionsRepository,
  }) : _transactionsRepository = transactionsRepository;

  Future<List<Transaction>> execute() async {
    return _transactionsRepository.getTransactions();
  }
}
