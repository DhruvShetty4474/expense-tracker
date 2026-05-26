// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  double get monthlySalary => throw _privateConstructorUsedError;
  int? get salaryDate => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  bool get onboardingComplete => throw _privateConstructorUsedError;
  bool get biometricEnabled => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    String id,
    String? name,
    String? email,
    String? avatarUrl,
    double monthlySalary,
    int? salaryDate,
    String currency,
    bool onboardingComplete,
    bool biometricEnabled,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? email = freezed,
    Object? avatarUrl = freezed,
    Object? monthlySalary = null,
    Object? salaryDate = freezed,
    Object? currency = null,
    Object? onboardingComplete = null,
    Object? biometricEnabled = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            avatarUrl:
                freezed == avatarUrl
                    ? _value.avatarUrl
                    : avatarUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            monthlySalary:
                null == monthlySalary
                    ? _value.monthlySalary
                    : monthlySalary // ignore: cast_nullable_to_non_nullable
                        as double,
            salaryDate:
                freezed == salaryDate
                    ? _value.salaryDate
                    : salaryDate // ignore: cast_nullable_to_non_nullable
                        as int?,
            currency:
                null == currency
                    ? _value.currency
                    : currency // ignore: cast_nullable_to_non_nullable
                        as String,
            onboardingComplete:
                null == onboardingComplete
                    ? _value.onboardingComplete
                    : onboardingComplete // ignore: cast_nullable_to_non_nullable
                        as bool,
            biometricEnabled:
                null == biometricEnabled
                    ? _value.biometricEnabled
                    : biometricEnabled // ignore: cast_nullable_to_non_nullable
                        as bool,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? name,
    String? email,
    String? avatarUrl,
    double monthlySalary,
    int? salaryDate,
    String currency,
    bool onboardingComplete,
    bool biometricEnabled,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? email = freezed,
    Object? avatarUrl = freezed,
    Object? monthlySalary = null,
    Object? salaryDate = freezed,
    Object? currency = null,
    Object? onboardingComplete = null,
    Object? biometricEnabled = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$UserProfileImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        avatarUrl:
            freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        monthlySalary:
            null == monthlySalary
                ? _value.monthlySalary
                : monthlySalary // ignore: cast_nullable_to_non_nullable
                    as double,
        salaryDate:
            freezed == salaryDate
                ? _value.salaryDate
                : salaryDate // ignore: cast_nullable_to_non_nullable
                    as int?,
        currency:
            null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                    as String,
        onboardingComplete:
            null == onboardingComplete
                ? _value.onboardingComplete
                : onboardingComplete // ignore: cast_nullable_to_non_nullable
                    as bool,
        biometricEnabled:
            null == biometricEnabled
                ? _value.biometricEnabled
                : biometricEnabled // ignore: cast_nullable_to_non_nullable
                    as bool,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    required this.id,
    this.name,
    this.email,
    this.avatarUrl,
    this.monthlySalary = 0.0,
    this.salaryDate,
    this.currency = 'INR',
    this.onboardingComplete = false,
    this.biometricEnabled = false,
    this.createdAt,
  });

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? avatarUrl;
  @override
  @JsonKey()
  final double monthlySalary;
  @override
  final int? salaryDate;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final bool onboardingComplete;
  @override
  @JsonKey()
  final bool biometricEnabled;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'UserProfile(id: $id, name: $name, email: $email, avatarUrl: $avatarUrl, monthlySalary: $monthlySalary, salaryDate: $salaryDate, currency: $currency, onboardingComplete: $onboardingComplete, biometricEnabled: $biometricEnabled, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.monthlySalary, monthlySalary) ||
                other.monthlySalary == monthlySalary) &&
            (identical(other.salaryDate, salaryDate) ||
                other.salaryDate == salaryDate) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.onboardingComplete, onboardingComplete) ||
                other.onboardingComplete == onboardingComplete) &&
            (identical(other.biometricEnabled, biometricEnabled) ||
                other.biometricEnabled == biometricEnabled) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    email,
    avatarUrl,
    monthlySalary,
    salaryDate,
    currency,
    onboardingComplete,
    biometricEnabled,
    createdAt,
  );

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(this);
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    required final String id,
    final String? name,
    final String? email,
    final String? avatarUrl,
    final double monthlySalary,
    final int? salaryDate,
    final String currency,
    final bool onboardingComplete,
    final bool biometricEnabled,
    final DateTime? createdAt,
  }) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  String? get email;
  @override
  String? get avatarUrl;
  @override
  double get monthlySalary;
  @override
  int? get salaryDate;
  @override
  String get currency;
  @override
  bool get onboardingComplete;
  @override
  bool get biometricEnabled;
  @override
  DateTime? get createdAt;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
