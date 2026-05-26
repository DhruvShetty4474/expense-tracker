import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    String? name,
    String? email,
    String? avatarUrl,
    @Default(0.0) double monthlySalary,
    int? salaryDate,
    @Default('INR') String currency,
    @Default(false) bool onboardingComplete,
    @Default(false) bool biometricEnabled,
    DateTime? createdAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
