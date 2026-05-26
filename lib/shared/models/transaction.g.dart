// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionImpl _$$TransactionImplFromJson(Map<String, dynamic> json) =>
    _$TransactionImpl(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      categoryId: json['categoryId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      source:
          $enumDecodeNullable(_$TransactionSourceEnumMap, json['source']) ??
          TransactionSource.manual,
      merchant: json['merchant'] as String?,
      note: json['note'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      refNumber: json['refNumber'] as String?,
      isRecurring: json['isRecurring'] as bool? ?? false,
      recurringId: json['recurringId'] as String?,
      synced: json['synced'] as bool? ?? false,
    );

Map<String, dynamic> _$$TransactionImplToJson(_$TransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'categoryId': instance.categoryId,
      'timestamp': instance.timestamp.toIso8601String(),
      'source': _$TransactionSourceEnumMap[instance.source]!,
      'merchant': instance.merchant,
      'note': instance.note,
      'tags': instance.tags,
      'refNumber': instance.refNumber,
      'isRecurring': instance.isRecurring,
      'recurringId': instance.recurringId,
      'synced': instance.synced,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.debit: 'debit',
  TransactionType.credit: 'credit',
};

const _$TransactionSourceEnumMap = {
  TransactionSource.manual: 'manual',
  TransactionSource.sms: 'sms',
  TransactionSource.recurring: 'recurring',
};
