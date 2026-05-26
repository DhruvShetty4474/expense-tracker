import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/transaction_type.dart';
import '../enums/transaction_source.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required double amount,
    required TransactionType type,
    required String categoryId,
    required DateTime timestamp,
    @Default(TransactionSource.manual) TransactionSource source,
    String? merchant,
    String? note,
    @Default([]) List<String> tags,
    String? refNumber,
    @Default(false) bool isRecurring,
    String? recurringId,
    @Default(false) bool synced,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
