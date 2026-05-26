// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'savings_goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SavingsGoal _$SavingsGoalFromJson(Map<String, dynamic> json) {
  return _SavingsGoal.fromJson(json);
}

/// @nodoc
mixin _$SavingsGoal {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get target => throw _privateConstructorUsedError;
  double get current => throw _privateConstructorUsedError;
  DateTime? get deadline => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;

  /// Serializes this SavingsGoal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SavingsGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavingsGoalCopyWith<SavingsGoal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavingsGoalCopyWith<$Res> {
  factory $SavingsGoalCopyWith(
    SavingsGoal value,
    $Res Function(SavingsGoal) then,
  ) = _$SavingsGoalCopyWithImpl<$Res, SavingsGoal>;
  @useResult
  $Res call({
    String id,
    String name,
    double target,
    double current,
    DateTime? deadline,
    String color,
    String? icon,
  });
}

/// @nodoc
class _$SavingsGoalCopyWithImpl<$Res, $Val extends SavingsGoal>
    implements $SavingsGoalCopyWith<$Res> {
  _$SavingsGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavingsGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? target = null,
    Object? current = null,
    Object? deadline = freezed,
    Object? color = null,
    Object? icon = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            target:
                null == target
                    ? _value.target
                    : target // ignore: cast_nullable_to_non_nullable
                        as double,
            current:
                null == current
                    ? _value.current
                    : current // ignore: cast_nullable_to_non_nullable
                        as double,
            deadline:
                freezed == deadline
                    ? _value.deadline
                    : deadline // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            color:
                null == color
                    ? _value.color
                    : color // ignore: cast_nullable_to_non_nullable
                        as String,
            icon:
                freezed == icon
                    ? _value.icon
                    : icon // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SavingsGoalImplCopyWith<$Res>
    implements $SavingsGoalCopyWith<$Res> {
  factory _$$SavingsGoalImplCopyWith(
    _$SavingsGoalImpl value,
    $Res Function(_$SavingsGoalImpl) then,
  ) = __$$SavingsGoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    double target,
    double current,
    DateTime? deadline,
    String color,
    String? icon,
  });
}

/// @nodoc
class __$$SavingsGoalImplCopyWithImpl<$Res>
    extends _$SavingsGoalCopyWithImpl<$Res, _$SavingsGoalImpl>
    implements _$$SavingsGoalImplCopyWith<$Res> {
  __$$SavingsGoalImplCopyWithImpl(
    _$SavingsGoalImpl _value,
    $Res Function(_$SavingsGoalImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SavingsGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? target = null,
    Object? current = null,
    Object? deadline = freezed,
    Object? color = null,
    Object? icon = freezed,
  }) {
    return _then(
      _$SavingsGoalImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        target:
            null == target
                ? _value.target
                : target // ignore: cast_nullable_to_non_nullable
                    as double,
        current:
            null == current
                ? _value.current
                : current // ignore: cast_nullable_to_non_nullable
                    as double,
        deadline:
            freezed == deadline
                ? _value.deadline
                : deadline // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        color:
            null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                    as String,
        icon:
            freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SavingsGoalImpl extends _SavingsGoal {
  const _$SavingsGoalImpl({
    required this.id,
    required this.name,
    required this.target,
    this.current = 0.0,
    this.deadline,
    required this.color,
    this.icon,
  }) : super._();

  factory _$SavingsGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavingsGoalImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double target;
  @override
  @JsonKey()
  final double current;
  @override
  final DateTime? deadline;
  @override
  final String color;
  @override
  final String? icon;

  @override
  String toString() {
    return 'SavingsGoal(id: $id, name: $name, target: $target, current: $current, deadline: $deadline, color: $color, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavingsGoalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    target,
    current,
    deadline,
    color,
    icon,
  );

  /// Create a copy of SavingsGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavingsGoalImplCopyWith<_$SavingsGoalImpl> get copyWith =>
      __$$SavingsGoalImplCopyWithImpl<_$SavingsGoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavingsGoalImplToJson(this);
  }
}

abstract class _SavingsGoal extends SavingsGoal {
  const factory _SavingsGoal({
    required final String id,
    required final String name,
    required final double target,
    final double current,
    final DateTime? deadline,
    required final String color,
    final String? icon,
  }) = _$SavingsGoalImpl;
  const _SavingsGoal._() : super._();

  factory _SavingsGoal.fromJson(Map<String, dynamic> json) =
      _$SavingsGoalImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get target;
  @override
  double get current;
  @override
  DateTime? get deadline;
  @override
  String get color;
  @override
  String? get icon;

  /// Create a copy of SavingsGoal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavingsGoalImplCopyWith<_$SavingsGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
