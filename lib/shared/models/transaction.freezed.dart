// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
mixin _$Transaction {
  String get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  TransactionType get type => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  TransactionSource get source => throw _privateConstructorUsedError;
  String? get merchant => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String? get refNumber => throw _privateConstructorUsedError;
  bool get isRecurring => throw _privateConstructorUsedError;
  String? get recurringId => throw _privateConstructorUsedError;
  bool get synced => throw _privateConstructorUsedError;

  /// Serializes this Transaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
    Transaction value,
    $Res Function(Transaction) then,
  ) = _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call({
    String id,
    double amount,
    TransactionType type,
    String categoryId,
    DateTime timestamp,
    TransactionSource source,
    String? merchant,
    String? note,
    List<String> tags,
    String? refNumber,
    bool isRecurring,
    String? recurringId,
    bool synced,
  });
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? type = null,
    Object? categoryId = null,
    Object? timestamp = null,
    Object? source = null,
    Object? merchant = freezed,
    Object? note = freezed,
    Object? tags = null,
    Object? refNumber = freezed,
    Object? isRecurring = null,
    Object? recurringId = freezed,
    Object? synced = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            amount:
                null == amount
                    ? _value.amount
                    : amount // ignore: cast_nullable_to_non_nullable
                        as double,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as TransactionType,
            categoryId:
                null == categoryId
                    ? _value.categoryId
                    : categoryId // ignore: cast_nullable_to_non_nullable
                        as String,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            source:
                null == source
                    ? _value.source
                    : source // ignore: cast_nullable_to_non_nullable
                        as TransactionSource,
            merchant:
                freezed == merchant
                    ? _value.merchant
                    : merchant // ignore: cast_nullable_to_non_nullable
                        as String?,
            note:
                freezed == note
                    ? _value.note
                    : note // ignore: cast_nullable_to_non_nullable
                        as String?,
            tags:
                null == tags
                    ? _value.tags
                    : tags // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            refNumber:
                freezed == refNumber
                    ? _value.refNumber
                    : refNumber // ignore: cast_nullable_to_non_nullable
                        as String?,
            isRecurring:
                null == isRecurring
                    ? _value.isRecurring
                    : isRecurring // ignore: cast_nullable_to_non_nullable
                        as bool,
            recurringId:
                freezed == recurringId
                    ? _value.recurringId
                    : recurringId // ignore: cast_nullable_to_non_nullable
                        as String?,
            synced:
                null == synced
                    ? _value.synced
                    : synced // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransactionImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$TransactionImplCopyWith(
    _$TransactionImpl value,
    $Res Function(_$TransactionImpl) then,
  ) = __$$TransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    double amount,
    TransactionType type,
    String categoryId,
    DateTime timestamp,
    TransactionSource source,
    String? merchant,
    String? note,
    List<String> tags,
    String? refNumber,
    bool isRecurring,
    String? recurringId,
    bool synced,
  });
}

/// @nodoc
class __$$TransactionImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$TransactionImpl>
    implements _$$TransactionImplCopyWith<$Res> {
  __$$TransactionImplCopyWithImpl(
    _$TransactionImpl _value,
    $Res Function(_$TransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? type = null,
    Object? categoryId = null,
    Object? timestamp = null,
    Object? source = null,
    Object? merchant = freezed,
    Object? note = freezed,
    Object? tags = null,
    Object? refNumber = freezed,
    Object? isRecurring = null,
    Object? recurringId = freezed,
    Object? synced = null,
  }) {
    return _then(
      _$TransactionImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        amount:
            null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as double,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as TransactionType,
        categoryId:
            null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                    as String,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        source:
            null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                    as TransactionSource,
        merchant:
            freezed == merchant
                ? _value.merchant
                : merchant // ignore: cast_nullable_to_non_nullable
                    as String?,
        note:
            freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                    as String?,
        tags:
            null == tags
                ? _value._tags
                : tags // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        refNumber:
            freezed == refNumber
                ? _value.refNumber
                : refNumber // ignore: cast_nullable_to_non_nullable
                    as String?,
        isRecurring:
            null == isRecurring
                ? _value.isRecurring
                : isRecurring // ignore: cast_nullable_to_non_nullable
                    as bool,
        recurringId:
            freezed == recurringId
                ? _value.recurringId
                : recurringId // ignore: cast_nullable_to_non_nullable
                    as String?,
        synced:
            null == synced
                ? _value.synced
                : synced // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionImpl implements _Transaction {
  const _$TransactionImpl({
    required this.id,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.timestamp,
    this.source = TransactionSource.manual,
    this.merchant,
    this.note,
    final List<String> tags = const [],
    this.refNumber,
    this.isRecurring = false,
    this.recurringId,
    this.synced = false,
  }) : _tags = tags;

  factory _$TransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionImplFromJson(json);

  @override
  final String id;
  @override
  final double amount;
  @override
  final TransactionType type;
  @override
  final String categoryId;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final TransactionSource source;
  @override
  final String? merchant;
  @override
  final String? note;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String? refNumber;
  @override
  @JsonKey()
  final bool isRecurring;
  @override
  final String? recurringId;
  @override
  @JsonKey()
  final bool synced;

  @override
  String toString() {
    return 'Transaction(id: $id, amount: $amount, type: $type, categoryId: $categoryId, timestamp: $timestamp, source: $source, merchant: $merchant, note: $note, tags: $tags, refNumber: $refNumber, isRecurring: $isRecurring, recurringId: $recurringId, synced: $synced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.merchant, merchant) ||
                other.merchant == merchant) &&
            (identical(other.note, note) || other.note == note) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.refNumber, refNumber) ||
                other.refNumber == refNumber) &&
            (identical(other.isRecurring, isRecurring) ||
                other.isRecurring == isRecurring) &&
            (identical(other.recurringId, recurringId) ||
                other.recurringId == recurringId) &&
            (identical(other.synced, synced) || other.synced == synced));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    amount,
    type,
    categoryId,
    timestamp,
    source,
    merchant,
    note,
    const DeepCollectionEquality().hash(_tags),
    refNumber,
    isRecurring,
    recurringId,
    synced,
  );

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      __$$TransactionImplCopyWithImpl<_$TransactionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionImplToJson(this);
  }
}

abstract class _Transaction implements Transaction {
  const factory _Transaction({
    required final String id,
    required final double amount,
    required final TransactionType type,
    required final String categoryId,
    required final DateTime timestamp,
    final TransactionSource source,
    final String? merchant,
    final String? note,
    final List<String> tags,
    final String? refNumber,
    final bool isRecurring,
    final String? recurringId,
    final bool synced,
  }) = _$TransactionImpl;

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$TransactionImpl.fromJson;

  @override
  String get id;
  @override
  double get amount;
  @override
  TransactionType get type;
  @override
  String get categoryId;
  @override
  DateTime get timestamp;
  @override
  TransactionSource get source;
  @override
  String? get merchant;
  @override
  String? get note;
  @override
  List<String> get tags;
  @override
  String? get refNumber;
  @override
  bool get isRecurring;
  @override
  String? get recurringId;
  @override
  bool get synced;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
