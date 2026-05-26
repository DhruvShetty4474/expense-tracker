import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget.freezed.dart';
part 'budget.g.dart';

@freezed
class Budget with _$Budget {
  const Budget._();

  const factory Budget({
    required String id,
    required String categoryId,
    required int month,    // YYYYMM
    required double amount,
    @Default(0.0) double spent,
    @Default(0.9) double alertAt,
  }) = _Budget;

  double get remaining => (amount - spent).clamp(0, double.infinity);
  double get percentUsed => amount > 0 ? (spent / amount).clamp(0, 1) : 0;
  bool get isOverBudget => spent > amount;
  bool get shouldAlert => percentUsed >= alertAt;

  factory Budget.fromJson(Map<String, dynamic> json) =>
      _$BudgetFromJson(json);
}
