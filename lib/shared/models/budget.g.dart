// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BudgetImpl _$$BudgetImplFromJson(Map<String, dynamic> json) => _$BudgetImpl(
  id: json['id'] as String,
  categoryId: json['categoryId'] as String,
  month: (json['month'] as num).toInt(),
  amount: (json['amount'] as num).toDouble(),
  spent: (json['spent'] as num?)?.toDouble() ?? 0.0,
  alertAt: (json['alertAt'] as num?)?.toDouble() ?? 0.9,
);

Map<String, dynamic> _$$BudgetImplToJson(_$BudgetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'month': instance.month,
      'amount': instance.amount,
      'spent': instance.spent,
      'alertAt': instance.alertAt,
    };
