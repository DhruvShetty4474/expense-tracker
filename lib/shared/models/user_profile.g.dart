// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      monthlySalary: (json['monthlySalary'] as num?)?.toDouble() ?? 0.0,
      salaryDate: (json['salaryDate'] as num?)?.toInt(),
      currency: json['currency'] as String? ?? 'INR',
      onboardingComplete: json['onboardingComplete'] as bool? ?? false,
      biometricEnabled: json['biometricEnabled'] as bool? ?? false,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'monthlySalary': instance.monthlySalary,
      'salaryDate': instance.salaryDate,
      'currency': instance.currency,
      'onboardingComplete': instance.onboardingComplete,
      'biometricEnabled': instance.biometricEnabled,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
