import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/insight_type.dart';

part 'ai_insight.freezed.dart';
part 'ai_insight.g.dart';

@freezed
class AiInsight with _$AiInsight {
  const factory AiInsight({
    required String id,
    required InsightType type,
    required String content,
    required DateTime generatedAt,
    @Default(false) bool dismissed,
    String? categoryId,
    Map<String, dynamic>? metadata,
  }) = _AiInsight;

  factory AiInsight.fromJson(Map<String, dynamic> json) =>
      _$AiInsightFromJson(json);
}
