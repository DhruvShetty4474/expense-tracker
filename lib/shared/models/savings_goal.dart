import 'package:freezed_annotation/freezed_annotation.dart';

part 'savings_goal.freezed.dart';
part 'savings_goal.g.dart';

@freezed
class SavingsGoal with _$SavingsGoal {
  const SavingsGoal._();

  const factory SavingsGoal({
    required String id,
    required String name,
    required double target,
    @Default(0.0) double current,
    DateTime? deadline,
    required String color,
    String? icon,
  }) = _SavingsGoal;

  double get progress => target > 0 ? (current / target).clamp(0, 1) : 0;
  double get remaining => (target - current).clamp(0, double.infinity);
  bool get isComplete => current >= target;

  factory SavingsGoal.fromJson(Map<String, dynamic> json) =>
      _$SavingsGoalFromJson(json);
}
