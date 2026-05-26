// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_insight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiInsightImpl _$$AiInsightImplFromJson(Map<String, dynamic> json) =>
    _$AiInsightImpl(
      id: json['id'] as String,
      type: $enumDecode(_$InsightTypeEnumMap, json['type']),
      content: json['content'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      dismissed: json['dismissed'] as bool? ?? false,
      categoryId: json['categoryId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AiInsightImplToJson(_$AiInsightImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$InsightTypeEnumMap[instance.type]!,
      'content': instance.content,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'dismissed': instance.dismissed,
      'categoryId': instance.categoryId,
      'metadata': instance.metadata,
    };

const _$InsightTypeEnumMap = {
  InsightType.budgetWarning: 'budgetWarning',
  InsightType.spendingPattern: 'spendingPattern',
  InsightType.suggestion: 'suggestion',
  InsightType.salaryAllocation: 'salaryAllocation',
  InsightType.savingsOpportunity: 'savingsOpportunity',
  InsightType.unusualSpend: 'unusualSpend',
};
