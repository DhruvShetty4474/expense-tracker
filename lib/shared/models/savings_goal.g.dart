// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savings_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavingsGoalImpl _$$SavingsGoalImplFromJson(Map<String, dynamic> json) =>
    _$SavingsGoalImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      target: (json['target'] as num).toDouble(),
      current: (json['current'] as num?)?.toDouble() ?? 0.0,
      deadline:
          json['deadline'] == null
              ? null
              : DateTime.parse(json['deadline'] as String),
      color: json['color'] as String,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$$SavingsGoalImplToJson(_$SavingsGoalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'target': instance.target,
      'current': instance.current,
      'deadline': instance.deadline?.toIso8601String(),
      'color': instance.color,
      'icon': instance.icon,
    };
