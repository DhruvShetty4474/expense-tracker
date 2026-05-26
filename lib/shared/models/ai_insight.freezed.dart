// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_insight.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AiInsight _$AiInsightFromJson(Map<String, dynamic> json) {
  return _AiInsight.fromJson(json);
}

/// @nodoc
mixin _$AiInsight {
  String get id => throw _privateConstructorUsedError;
  InsightType get type => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  bool get dismissed => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this AiInsight to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiInsight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiInsightCopyWith<AiInsight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiInsightCopyWith<$Res> {
  factory $AiInsightCopyWith(AiInsight value, $Res Function(AiInsight) then) =
      _$AiInsightCopyWithImpl<$Res, AiInsight>;
  @useResult
  $Res call({
    String id,
    InsightType type,
    String content,
    DateTime generatedAt,
    bool dismissed,
    String? categoryId,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$AiInsightCopyWithImpl<$Res, $Val extends AiInsight>
    implements $AiInsightCopyWith<$Res> {
  _$AiInsightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiInsight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? content = null,
    Object? generatedAt = null,
    Object? dismissed = null,
    Object? categoryId = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as InsightType,
            content:
                null == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as String,
            generatedAt:
                null == generatedAt
                    ? _value.generatedAt
                    : generatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            dismissed:
                null == dismissed
                    ? _value.dismissed
                    : dismissed // ignore: cast_nullable_to_non_nullable
                        as bool,
            categoryId:
                freezed == categoryId
                    ? _value.categoryId
                    : categoryId // ignore: cast_nullable_to_non_nullable
                        as String?,
            metadata:
                freezed == metadata
                    ? _value.metadata
                    : metadata // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AiInsightImplCopyWith<$Res>
    implements $AiInsightCopyWith<$Res> {
  factory _$$AiInsightImplCopyWith(
    _$AiInsightImpl value,
    $Res Function(_$AiInsightImpl) then,
  ) = __$$AiInsightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    InsightType type,
    String content,
    DateTime generatedAt,
    bool dismissed,
    String? categoryId,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$AiInsightImplCopyWithImpl<$Res>
    extends _$AiInsightCopyWithImpl<$Res, _$AiInsightImpl>
    implements _$$AiInsightImplCopyWith<$Res> {
  __$$AiInsightImplCopyWithImpl(
    _$AiInsightImpl _value,
    $Res Function(_$AiInsightImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiInsight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? content = null,
    Object? generatedAt = null,
    Object? dismissed = null,
    Object? categoryId = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _$AiInsightImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as InsightType,
        content:
            null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as String,
        generatedAt:
            null == generatedAt
                ? _value.generatedAt
                : generatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        dismissed:
            null == dismissed
                ? _value.dismissed
                : dismissed // ignore: cast_nullable_to_non_nullable
                    as bool,
        categoryId:
            freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                    as String?,
        metadata:
            freezed == metadata
                ? _value._metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AiInsightImpl implements _AiInsight {
  const _$AiInsightImpl({
    required this.id,
    required this.type,
    required this.content,
    required this.generatedAt,
    this.dismissed = false,
    this.categoryId,
    final Map<String, dynamic>? metadata,
  }) : _metadata = metadata;

  factory _$AiInsightImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiInsightImplFromJson(json);

  @override
  final String id;
  @override
  final InsightType type;
  @override
  final String content;
  @override
  final DateTime generatedAt;
  @override
  @JsonKey()
  final bool dismissed;
  @override
  final String? categoryId;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AiInsight(id: $id, type: $type, content: $content, generatedAt: $generatedAt, dismissed: $dismissed, categoryId: $categoryId, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiInsightImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.dismissed, dismissed) ||
                other.dismissed == dismissed) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    content,
    generatedAt,
    dismissed,
    categoryId,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of AiInsight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiInsightImplCopyWith<_$AiInsightImpl> get copyWith =>
      __$$AiInsightImplCopyWithImpl<_$AiInsightImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiInsightImplToJson(this);
  }
}

abstract class _AiInsight implements AiInsight {
  const factory _AiInsight({
    required final String id,
    required final InsightType type,
    required final String content,
    required final DateTime generatedAt,
    final bool dismissed,
    final String? categoryId,
    final Map<String, dynamic>? metadata,
  }) = _$AiInsightImpl;

  factory _AiInsight.fromJson(Map<String, dynamic> json) =
      _$AiInsightImpl.fromJson;

  @override
  String get id;
  @override
  InsightType get type;
  @override
  String get content;
  @override
  DateTime get generatedAt;
  @override
  bool get dismissed;
  @override
  String? get categoryId;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of AiInsight
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiInsightImplCopyWith<_$AiInsightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
