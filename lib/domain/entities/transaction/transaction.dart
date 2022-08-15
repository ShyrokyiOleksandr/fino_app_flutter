import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';

@freezed
class Transaction with _$Transaction {
  const Transaction._();

  const factory Transaction({
    required final String id,
    required final double value,
    required final DateTime date,
    required final String comment,
  }) = _Transaction;
}
