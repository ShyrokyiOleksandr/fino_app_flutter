import 'package:freezed_annotation/freezed_annotation.dart';

part 'count.freezed.dart';

@freezed
class Count with _$Count {
  const Count._();

  const factory Count({
    required final int number,

  }) = _Count;
}
