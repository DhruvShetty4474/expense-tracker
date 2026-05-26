// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Budget _$BudgetFromJson(Map<String, dynamic> json) {
  return _Budget.fromJson(json);
}

/// @nodoc
mixin _$Budget {
  String get id => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError; // YYYYMM
  double get amount => throw _privateConstructorUsedError;
  double get spent => throw _privateConstructorUsedError;
  double get alertAt => throw _privateConstructorUsedError;

  /// Serializes this Budget to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Budget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BudgetCopyWith<Budget> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetCopyWith<$Res> {
  factory $BudgetCopyWith(Budget value, $Res Function(Budget) then) =
      _$BudgetCopyWithImpl<$Res, Budget>;
  @useResult
  $Res call({
    String id,
    String categoryId,
    int month,
    double amount,
    double spent,
    double alertAt,
  });
}

/// @nodoc
class _$BudgetCopyWithImpl<$Res, $Val extends Budget>
    implements $BudgetCopyWith<$Res> {
  _$BudgetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Budget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryId = null,
    Object? month = null,
    Object? amount = null,
    Object? spent = null,
    Object? alertAt = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            categoryId:
                null == categoryId
                    ? _value.categoryId
                    : categoryId // ignore: cast_nullable_to_non_nullable
                        as String,
            month:
                null == month
                    ? _value.month
                    : month // ignore: cast_nullable_to_non_nullable
                        as int,
            amount:
                null == amount
                    ? _value.amount
                    : amount // ignore: cast_nullable_to_non_nullable
                        as double,
            spent:
                null == spent
                    ? _value.spent
                    : spent // ignore: cast_nullable_to_non_nullable
                        as double,
            alertAt:
                null == alertAt
                    ? _value.alertAt
                    : alertAt // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BudgetImplCopyWith<$Res> implements $BudgetCopyWith<$Res> {
  factory _$$BudgetImplCopyWith(
    _$BudgetImpl value,
    $Res Function(_$BudgetImpl) then,
  ) = __$$BudgetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String categoryId,
    int month,
    double amount,
    double spent,
    double alertAt,
  });
}

/// @nodoc
class __$$BudgetImplCopyWithImpl<$Res>
    extends _$BudgetCopyWithImpl<$Res, _$BudgetImpl>
    implements _$$BudgetImplCopyWith<$Res> {
  __$$BudgetImplCopyWithImpl(
    _$BudgetImpl _value,
    $Res Function(_$BudgetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Budget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? categoryId = null,
    Object? month = null,
    Object? amount = null,
    Object? spent = null,
    Object? alertAt = null,
  }) {
    return _then(
      _$BudgetImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        categoryId:
            null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                    as String,
        month:
            null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                    as int,
        amount:
            null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as double,
        spent:
            null == spent
                ? _value.spent
                : spent // ignore: cast_nullable_to_non_nullable
                    as double,
        alertAt:
            null == alertAt
                ? _value.alertAt
                : alertAt // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BudgetImpl extends _Budget {
  const _$BudgetImpl({
    required this.id,
    required this.categoryId,
    required this.month,
    required this.amount,
    this.spent = 0.0,
    this.alertAt = 0.9,
  }) : super._();

  factory _$BudgetImpl.fromJson(Map<String, dynamic> json) =>
      _$$BudgetImplFromJson(json);

  @override
  final String id;
  @override
  final String categoryId;
  @override
  final int month;
  // YYYYMM
  @override
  final double amount;
  @override
  @JsonKey()
  final double spent;
  @override
  @JsonKey()
  final double alertAt;

  @override
  String toString() {
    return 'Budget(id: $id, categoryId: $categoryId, month: $month, amount: $amount, spent: $spent, alertAt: $alertAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.spent, spent) || other.spent == spent) &&
            (identical(other.alertAt, alertAt) || other.alertAt == alertAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, categoryId, month, amount, spent, alertAt);

  /// Create a copy of Budget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetImplCopyWith<_$BudgetImpl> get copyWith =>
      __$$BudgetImplCopyWithImpl<_$BudgetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BudgetImplToJson(this);
  }
}

abstract class _Budget extends Budget {
  const factory _Budget({
    required final String id,
    required final String categoryId,
    required final int month,
    required final double amount,
    final double spent,
    final double alertAt,
  }) = _$BudgetImpl;
  const _Budget._() : super._();

  factory _Budget.fromJson(Map<String, dynamic> json) = _$BudgetImpl.fromJson;

  @override
  String get id;
  @override
  String get categoryId;
  @override
  int get month; // YYYYMM
  @override
  double get amount;
  @override
  double get spent;
  @override
  double get alertAt;

  /// Create a copy of Budget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetImplCopyWith<_$BudgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
