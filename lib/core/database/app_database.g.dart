// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TransactionsTableTable extends TransactionsTable
    with TableInfo<$TransactionsTableTable, TransactionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TransactionType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TransactionType>($TransactionsTableTable.$convertertype);
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TransactionSource, String>
  source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  ).withConverter<TransactionSource>($TransactionsTableTable.$convertersource);
  static const VerificationMeta _merchantMeta = const VerificationMeta(
    'merchant',
  );
  @override
  late final GeneratedColumn<String> merchant = GeneratedColumn<String>(
    'merchant',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _refNumberMeta = const VerificationMeta(
    'refNumber',
  );
  @override
  late final GeneratedColumn<String> refNumber = GeneratedColumn<String>(
    'ref_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isRecurringMeta = const VerificationMeta(
    'isRecurring',
  );
  @override
  late final GeneratedColumn<bool> isRecurring = GeneratedColumn<bool>(
    'is_recurring',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_recurring" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _recurringIdMeta = const VerificationMeta(
    'recurringId',
  );
  @override
  late final GeneratedColumn<String> recurringId = GeneratedColumn<String>(
    'recurring_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    amount,
    type,
    categoryId,
    timestamp,
    source,
    merchant,
    note,
    tags,
    refNumber,
    isRecurring,
    recurringId,
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('merchant')) {
      context.handle(
        _merchantMeta,
        merchant.isAcceptableOrUnknown(data['merchant']!, _merchantMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('ref_number')) {
      context.handle(
        _refNumberMeta,
        refNumber.isAcceptableOrUnknown(data['ref_number']!, _refNumberMeta),
      );
    }
    if (data.containsKey('is_recurring')) {
      context.handle(
        _isRecurringMeta,
        isRecurring.isAcceptableOrUnknown(
          data['is_recurring']!,
          _isRecurringMeta,
        ),
      );
    }
    if (data.containsKey('recurring_id')) {
      context.handle(
        _recurringIdMeta,
        recurringId.isAcceptableOrUnknown(
          data['recurring_id']!,
          _recurringIdMeta,
        ),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionsTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}amount'],
          )!,
      type: $TransactionsTableTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      categoryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category_id'],
          )!,
      timestamp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}timestamp'],
          )!,
      source: $TransactionsTableTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      merchant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      tags:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}tags'],
          )!,
      refNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ref_number'],
      ),
      isRecurring:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_recurring'],
          )!,
      recurringId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurring_id'],
      ),
      synced:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}synced'],
          )!,
    );
  }

  @override
  $TransactionsTableTable createAlias(String alias) {
    return $TransactionsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TransactionType, String, String> $convertertype =
      const EnumNameConverter<TransactionType>(TransactionType.values);
  static JsonTypeConverter2<TransactionSource, String, String>
  $convertersource = const EnumNameConverter<TransactionSource>(
    TransactionSource.values,
  );
}

class TransactionsTableData extends DataClass
    implements Insertable<TransactionsTableData> {
  final String id;
  final double amount;
  final TransactionType type;
  final String categoryId;
  final DateTime timestamp;
  final TransactionSource source;
  final String? merchant;
  final String? note;
  final String tags;
  final String? refNumber;
  final bool isRecurring;
  final String? recurringId;
  final bool synced;
  const TransactionsTableData({
    required this.id,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.timestamp,
    required this.source,
    this.merchant,
    this.note,
    required this.tags,
    this.refNumber,
    required this.isRecurring,
    this.recurringId,
    required this.synced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['amount'] = Variable<double>(amount);
    {
      map['type'] = Variable<String>(
        $TransactionsTableTable.$convertertype.toSql(type),
      );
    }
    map['category_id'] = Variable<String>(categoryId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    {
      map['source'] = Variable<String>(
        $TransactionsTableTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || merchant != null) {
      map['merchant'] = Variable<String>(merchant);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['tags'] = Variable<String>(tags);
    if (!nullToAbsent || refNumber != null) {
      map['ref_number'] = Variable<String>(refNumber);
    }
    map['is_recurring'] = Variable<bool>(isRecurring);
    if (!nullToAbsent || recurringId != null) {
      map['recurring_id'] = Variable<String>(recurringId);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  TransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionsTableCompanion(
      id: Value(id),
      amount: Value(amount),
      type: Value(type),
      categoryId: Value(categoryId),
      timestamp: Value(timestamp),
      source: Value(source),
      merchant:
          merchant == null && nullToAbsent
              ? const Value.absent()
              : Value(merchant),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      tags: Value(tags),
      refNumber:
          refNumber == null && nullToAbsent
              ? const Value.absent()
              : Value(refNumber),
      isRecurring: Value(isRecurring),
      recurringId:
          recurringId == null && nullToAbsent
              ? const Value.absent()
              : Value(recurringId),
      synced: Value(synced),
    );
  }

  factory TransactionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionsTableData(
      id: serializer.fromJson<String>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      type: $TransactionsTableTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      source: $TransactionsTableTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      merchant: serializer.fromJson<String?>(json['merchant']),
      note: serializer.fromJson<String?>(json['note']),
      tags: serializer.fromJson<String>(json['tags']),
      refNumber: serializer.fromJson<String?>(json['refNumber']),
      isRecurring: serializer.fromJson<bool>(json['isRecurring']),
      recurringId: serializer.fromJson<String?>(json['recurringId']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'amount': serializer.toJson<double>(amount),
      'type': serializer.toJson<String>(
        $TransactionsTableTable.$convertertype.toJson(type),
      ),
      'categoryId': serializer.toJson<String>(categoryId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'source': serializer.toJson<String>(
        $TransactionsTableTable.$convertersource.toJson(source),
      ),
      'merchant': serializer.toJson<String?>(merchant),
      'note': serializer.toJson<String?>(note),
      'tags': serializer.toJson<String>(tags),
      'refNumber': serializer.toJson<String?>(refNumber),
      'isRecurring': serializer.toJson<bool>(isRecurring),
      'recurringId': serializer.toJson<String?>(recurringId),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  TransactionsTableData copyWith({
    String? id,
    double? amount,
    TransactionType? type,
    String? categoryId,
    DateTime? timestamp,
    TransactionSource? source,
    Value<String?> merchant = const Value.absent(),
    Value<String?> note = const Value.absent(),
    String? tags,
    Value<String?> refNumber = const Value.absent(),
    bool? isRecurring,
    Value<String?> recurringId = const Value.absent(),
    bool? synced,
  }) => TransactionsTableData(
    id: id ?? this.id,
    amount: amount ?? this.amount,
    type: type ?? this.type,
    categoryId: categoryId ?? this.categoryId,
    timestamp: timestamp ?? this.timestamp,
    source: source ?? this.source,
    merchant: merchant.present ? merchant.value : this.merchant,
    note: note.present ? note.value : this.note,
    tags: tags ?? this.tags,
    refNumber: refNumber.present ? refNumber.value : this.refNumber,
    isRecurring: isRecurring ?? this.isRecurring,
    recurringId: recurringId.present ? recurringId.value : this.recurringId,
    synced: synced ?? this.synced,
  );
  TransactionsTableData copyWithCompanion(TransactionsTableCompanion data) {
    return TransactionsTableData(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      type: data.type.present ? data.type.value : this.type,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      source: data.source.present ? data.source.value : this.source,
      merchant: data.merchant.present ? data.merchant.value : this.merchant,
      note: data.note.present ? data.note.value : this.note,
      tags: data.tags.present ? data.tags.value : this.tags,
      refNumber: data.refNumber.present ? data.refNumber.value : this.refNumber,
      isRecurring:
          data.isRecurring.present ? data.isRecurring.value : this.isRecurring,
      recurringId:
          data.recurringId.present ? data.recurringId.value : this.recurringId,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableData(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('type: $type, ')
          ..write('categoryId: $categoryId, ')
          ..write('timestamp: $timestamp, ')
          ..write('source: $source, ')
          ..write('merchant: $merchant, ')
          ..write('note: $note, ')
          ..write('tags: $tags, ')
          ..write('refNumber: $refNumber, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('recurringId: $recurringId, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    amount,
    type,
    categoryId,
    timestamp,
    source,
    merchant,
    note,
    tags,
    refNumber,
    isRecurring,
    recurringId,
    synced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionsTableData &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.type == this.type &&
          other.categoryId == this.categoryId &&
          other.timestamp == this.timestamp &&
          other.source == this.source &&
          other.merchant == this.merchant &&
          other.note == this.note &&
          other.tags == this.tags &&
          other.refNumber == this.refNumber &&
          other.isRecurring == this.isRecurring &&
          other.recurringId == this.recurringId &&
          other.synced == this.synced);
}

class TransactionsTableCompanion
    extends UpdateCompanion<TransactionsTableData> {
  final Value<String> id;
  final Value<double> amount;
  final Value<TransactionType> type;
  final Value<String> categoryId;
  final Value<DateTime> timestamp;
  final Value<TransactionSource> source;
  final Value<String?> merchant;
  final Value<String?> note;
  final Value<String> tags;
  final Value<String?> refNumber;
  final Value<bool> isRecurring;
  final Value<String?> recurringId;
  final Value<bool> synced;
  final Value<int> rowid;
  const TransactionsTableCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.type = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.source = const Value.absent(),
    this.merchant = const Value.absent(),
    this.note = const Value.absent(),
    this.tags = const Value.absent(),
    this.refNumber = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.recurringId = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsTableCompanion.insert({
    required String id,
    required double amount,
    required TransactionType type,
    required String categoryId,
    required DateTime timestamp,
    this.source = const Value.absent(),
    this.merchant = const Value.absent(),
    this.note = const Value.absent(),
    this.tags = const Value.absent(),
    this.refNumber = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.recurringId = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       amount = Value(amount),
       type = Value(type),
       categoryId = Value(categoryId),
       timestamp = Value(timestamp);
  static Insertable<TransactionsTableData> custom({
    Expression<String>? id,
    Expression<double>? amount,
    Expression<String>? type,
    Expression<String>? categoryId,
    Expression<DateTime>? timestamp,
    Expression<String>? source,
    Expression<String>? merchant,
    Expression<String>? note,
    Expression<String>? tags,
    Expression<String>? refNumber,
    Expression<bool>? isRecurring,
    Expression<String>? recurringId,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (type != null) 'type': type,
      if (categoryId != null) 'category_id': categoryId,
      if (timestamp != null) 'timestamp': timestamp,
      if (source != null) 'source': source,
      if (merchant != null) 'merchant': merchant,
      if (note != null) 'note': note,
      if (tags != null) 'tags': tags,
      if (refNumber != null) 'ref_number': refNumber,
      if (isRecurring != null) 'is_recurring': isRecurring,
      if (recurringId != null) 'recurring_id': recurringId,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsTableCompanion copyWith({
    Value<String>? id,
    Value<double>? amount,
    Value<TransactionType>? type,
    Value<String>? categoryId,
    Value<DateTime>? timestamp,
    Value<TransactionSource>? source,
    Value<String?>? merchant,
    Value<String?>? note,
    Value<String>? tags,
    Value<String?>? refNumber,
    Value<bool>? isRecurring,
    Value<String?>? recurringId,
    Value<bool>? synced,
    Value<int>? rowid,
  }) {
    return TransactionsTableCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      timestamp: timestamp ?? this.timestamp,
      source: source ?? this.source,
      merchant: merchant ?? this.merchant,
      note: note ?? this.note,
      tags: tags ?? this.tags,
      refNumber: refNumber ?? this.refNumber,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringId: recurringId ?? this.recurringId,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $TransactionsTableTable.$convertertype.toSql(type.value),
      );
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $TransactionsTableTable.$convertersource.toSql(source.value),
      );
    }
    if (merchant.present) {
      map['merchant'] = Variable<String>(merchant.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (refNumber.present) {
      map['ref_number'] = Variable<String>(refNumber.value);
    }
    if (isRecurring.present) {
      map['is_recurring'] = Variable<bool>(isRecurring.value);
    }
    if (recurringId.present) {
      map['recurring_id'] = Variable<String>(recurringId.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('type: $type, ')
          ..write('categoryId: $categoryId, ')
          ..write('timestamp: $timestamp, ')
          ..write('source: $source, ')
          ..write('merchant: $merchant, ')
          ..write('note: $note, ')
          ..write('tags: $tags, ')
          ..write('refNumber: $refNumber, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('recurringId: $recurringId, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTableTable extends CategoriesTable
    with TableInfo<$CategoriesTableTable, CategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCustomMeta = const VerificationMeta(
    'isCustom',
  );
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
    'is_custom',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_custom" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    icon,
    color,
    isCustom,
    parentId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('is_custom')) {
      context.handle(
        _isCustomMeta,
        isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta),
      );
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriesTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      icon:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}icon'],
          )!,
      color:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}color'],
          )!,
      isCustom:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_custom'],
          )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
    );
  }

  @override
  $CategoriesTableTable createAlias(String alias) {
    return $CategoriesTableTable(attachedDatabase, alias);
  }
}

class CategoriesTableData extends DataClass
    implements Insertable<CategoriesTableData> {
  final String id;
  final String name;
  final String icon;
  final String color;
  final bool isCustom;
  final String? parentId;
  const CategoriesTableData({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.isCustom,
    this.parentId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['color'] = Variable<String>(color);
    map['is_custom'] = Variable<bool>(isCustom);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    return map;
  }

  CategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      color: Value(color),
      isCustom: Value(isCustom),
      parentId:
          parentId == null && nullToAbsent
              ? const Value.absent()
              : Value(parentId),
    );
  }

  factory CategoriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      color: serializer.fromJson<String>(json['color']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      parentId: serializer.fromJson<String?>(json['parentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'color': serializer.toJson<String>(color),
      'isCustom': serializer.toJson<bool>(isCustom),
      'parentId': serializer.toJson<String?>(parentId),
    };
  }

  CategoriesTableData copyWith({
    String? id,
    String? name,
    String? icon,
    String? color,
    bool? isCustom,
    Value<String?> parentId = const Value.absent(),
  }) => CategoriesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    color: color ?? this.color,
    isCustom: isCustom ?? this.isCustom,
    parentId: parentId.present ? parentId.value : this.parentId,
  );
  CategoriesTableData copyWithCompanion(CategoriesTableCompanion data) {
    return CategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('isCustom: $isCustom, ')
          ..write('parentId: $parentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon, color, isCustom, parentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.isCustom == this.isCustom &&
          other.parentId == this.parentId);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoriesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<String> color;
  final Value<bool> isCustom;
  final Value<String?> parentId;
  final Value<int> rowid;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.parentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    required String id,
    required String name,
    required String icon,
    required String color,
    this.isCustom = const Value.absent(),
    this.parentId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       icon = Value(icon),
       color = Value(color);
  static Insertable<CategoriesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<String>? color,
    Expression<bool>? isCustom,
    Expression<String>? parentId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (isCustom != null) 'is_custom': isCustom,
      if (parentId != null) 'parent_id': parentId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? icon,
    Value<String>? color,
    Value<bool>? isCustom,
    Value<String?>? parentId,
    Value<int>? rowid,
  }) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      isCustom: isCustom ?? this.isCustom,
      parentId: parentId ?? this.parentId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('isCustom: $isCustom, ')
          ..write('parentId: $parentId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetsTableTable extends BudgetsTable
    with TableInfo<$BudgetsTableTable, BudgetsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
    'month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spentMeta = const VerificationMeta('spent');
  @override
  late final GeneratedColumn<double> spent = GeneratedColumn<double>(
    'spent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _alertAtMeta = const VerificationMeta(
    'alertAt',
  );
  @override
  late final GeneratedColumn<double> alertAt = GeneratedColumn<double>(
    'alert_at',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.9),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    month,
    amount,
    spent,
    alertAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgets_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
        _monthMeta,
        month.isAcceptableOrUnknown(data['month']!, _monthMeta),
      );
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('spent')) {
      context.handle(
        _spentMeta,
        spent.isAcceptableOrUnknown(data['spent']!, _spentMeta),
      );
    }
    if (data.containsKey('alert_at')) {
      context.handle(
        _alertAtMeta,
        alertAt.isAcceptableOrUnknown(data['alert_at']!, _alertAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetsTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      categoryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category_id'],
          )!,
      month:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}month'],
          )!,
      amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}amount'],
          )!,
      spent:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}spent'],
          )!,
      alertAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}alert_at'],
          )!,
    );
  }

  @override
  $BudgetsTableTable createAlias(String alias) {
    return $BudgetsTableTable(attachedDatabase, alias);
  }
}

class BudgetsTableData extends DataClass
    implements Insertable<BudgetsTableData> {
  final String id;
  final String categoryId;
  final int month;
  final double amount;
  final double spent;
  final double alertAt;
  const BudgetsTableData({
    required this.id,
    required this.categoryId,
    required this.month,
    required this.amount,
    required this.spent,
    required this.alertAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['month'] = Variable<int>(month);
    map['amount'] = Variable<double>(amount);
    map['spent'] = Variable<double>(spent);
    map['alert_at'] = Variable<double>(alertAt);
    return map;
  }

  BudgetsTableCompanion toCompanion(bool nullToAbsent) {
    return BudgetsTableCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      month: Value(month),
      amount: Value(amount),
      spent: Value(spent),
      alertAt: Value(alertAt),
    );
  }

  factory BudgetsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetsTableData(
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      month: serializer.fromJson<int>(json['month']),
      amount: serializer.fromJson<double>(json['amount']),
      spent: serializer.fromJson<double>(json['spent']),
      alertAt: serializer.fromJson<double>(json['alertAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoryId': serializer.toJson<String>(categoryId),
      'month': serializer.toJson<int>(month),
      'amount': serializer.toJson<double>(amount),
      'spent': serializer.toJson<double>(spent),
      'alertAt': serializer.toJson<double>(alertAt),
    };
  }

  BudgetsTableData copyWith({
    String? id,
    String? categoryId,
    int? month,
    double? amount,
    double? spent,
    double? alertAt,
  }) => BudgetsTableData(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    month: month ?? this.month,
    amount: amount ?? this.amount,
    spent: spent ?? this.spent,
    alertAt: alertAt ?? this.alertAt,
  );
  BudgetsTableData copyWithCompanion(BudgetsTableCompanion data) {
    return BudgetsTableData(
      id: data.id.present ? data.id.value : this.id,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      month: data.month.present ? data.month.value : this.month,
      amount: data.amount.present ? data.amount.value : this.amount,
      spent: data.spent.present ? data.spent.value : this.spent,
      alertAt: data.alertAt.present ? data.alertAt.value : this.alertAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsTableData(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('month: $month, ')
          ..write('amount: $amount, ')
          ..write('spent: $spent, ')
          ..write('alertAt: $alertAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, categoryId, month, amount, spent, alertAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetsTableData &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.month == this.month &&
          other.amount == this.amount &&
          other.spent == this.spent &&
          other.alertAt == this.alertAt);
}

class BudgetsTableCompanion extends UpdateCompanion<BudgetsTableData> {
  final Value<String> id;
  final Value<String> categoryId;
  final Value<int> month;
  final Value<double> amount;
  final Value<double> spent;
  final Value<double> alertAt;
  final Value<int> rowid;
  const BudgetsTableCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.month = const Value.absent(),
    this.amount = const Value.absent(),
    this.spent = const Value.absent(),
    this.alertAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetsTableCompanion.insert({
    required String id,
    required String categoryId,
    required int month,
    required double amount,
    this.spent = const Value.absent(),
    this.alertAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       categoryId = Value(categoryId),
       month = Value(month),
       amount = Value(amount);
  static Insertable<BudgetsTableData> custom({
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<int>? month,
    Expression<double>? amount,
    Expression<double>? spent,
    Expression<double>? alertAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (month != null) 'month': month,
      if (amount != null) 'amount': amount,
      if (spent != null) 'spent': spent,
      if (alertAt != null) 'alert_at': alertAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? categoryId,
    Value<int>? month,
    Value<double>? amount,
    Value<double>? spent,
    Value<double>? alertAt,
    Value<int>? rowid,
  }) {
    return BudgetsTableCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      month: month ?? this.month,
      amount: amount ?? this.amount,
      spent: spent ?? this.spent,
      alertAt: alertAt ?? this.alertAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (spent.present) {
      map['spent'] = Variable<double>(spent.value);
    }
    if (alertAt.present) {
      map['alert_at'] = Variable<double>(alertAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsTableCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('month: $month, ')
          ..write('amount: $amount, ')
          ..write('spent: $spent, ')
          ..write('alertAt: $alertAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavingsGoalsTableTable extends SavingsGoalsTable
    with TableInfo<$SavingsGoalsTableTable, SavingsGoalsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavingsGoalsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<double> target = GeneratedColumn<double>(
    'target',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentMeta = const VerificationMeta(
    'current',
  );
  @override
  late final GeneratedColumn<double> current = GeneratedColumn<double>(
    'current',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _deadlineMeta = const VerificationMeta(
    'deadline',
  );
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
    'deadline',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    target,
    current,
    deadline,
    color,
    icon,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'savings_goals_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavingsGoalsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    if (data.containsKey('current')) {
      context.handle(
        _currentMeta,
        current.isAcceptableOrUnknown(data['current']!, _currentMeta),
      );
    }
    if (data.containsKey('deadline')) {
      context.handle(
        _deadlineMeta,
        deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavingsGoalsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavingsGoalsTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      target:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}target'],
          )!,
      current:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}current'],
          )!,
      deadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deadline'],
      ),
      color:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}color'],
          )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
    );
  }

  @override
  $SavingsGoalsTableTable createAlias(String alias) {
    return $SavingsGoalsTableTable(attachedDatabase, alias);
  }
}

class SavingsGoalsTableData extends DataClass
    implements Insertable<SavingsGoalsTableData> {
  final String id;
  final String name;
  final double target;
  final double current;
  final DateTime? deadline;
  final String color;
  final String? icon;
  const SavingsGoalsTableData({
    required this.id,
    required this.name,
    required this.target,
    required this.current,
    this.deadline,
    required this.color,
    this.icon,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['target'] = Variable<double>(target);
    map['current'] = Variable<double>(current);
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime>(deadline);
    }
    map['color'] = Variable<String>(color);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    return map;
  }

  SavingsGoalsTableCompanion toCompanion(bool nullToAbsent) {
    return SavingsGoalsTableCompanion(
      id: Value(id),
      name: Value(name),
      target: Value(target),
      current: Value(current),
      deadline:
          deadline == null && nullToAbsent
              ? const Value.absent()
              : Value(deadline),
      color: Value(color),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
    );
  }

  factory SavingsGoalsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavingsGoalsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      target: serializer.fromJson<double>(json['target']),
      current: serializer.fromJson<double>(json['current']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
      color: serializer.fromJson<String>(json['color']),
      icon: serializer.fromJson<String?>(json['icon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'target': serializer.toJson<double>(target),
      'current': serializer.toJson<double>(current),
      'deadline': serializer.toJson<DateTime?>(deadline),
      'color': serializer.toJson<String>(color),
      'icon': serializer.toJson<String?>(icon),
    };
  }

  SavingsGoalsTableData copyWith({
    String? id,
    String? name,
    double? target,
    double? current,
    Value<DateTime?> deadline = const Value.absent(),
    String? color,
    Value<String?> icon = const Value.absent(),
  }) => SavingsGoalsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    target: target ?? this.target,
    current: current ?? this.current,
    deadline: deadline.present ? deadline.value : this.deadline,
    color: color ?? this.color,
    icon: icon.present ? icon.value : this.icon,
  );
  SavingsGoalsTableData copyWithCompanion(SavingsGoalsTableCompanion data) {
    return SavingsGoalsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      target: data.target.present ? data.target.value : this.target,
      current: data.current.present ? data.current.value : this.current,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavingsGoalsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('target: $target, ')
          ..write('current: $current, ')
          ..write('deadline: $deadline, ')
          ..write('color: $color, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, target, current, deadline, color, icon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavingsGoalsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.target == this.target &&
          other.current == this.current &&
          other.deadline == this.deadline &&
          other.color == this.color &&
          other.icon == this.icon);
}

class SavingsGoalsTableCompanion
    extends UpdateCompanion<SavingsGoalsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> target;
  final Value<double> current;
  final Value<DateTime?> deadline;
  final Value<String> color;
  final Value<String?> icon;
  final Value<int> rowid;
  const SavingsGoalsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.target = const Value.absent(),
    this.current = const Value.absent(),
    this.deadline = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavingsGoalsTableCompanion.insert({
    required String id,
    required String name,
    required double target,
    this.current = const Value.absent(),
    this.deadline = const Value.absent(),
    required String color,
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       target = Value(target),
       color = Value(color);
  static Insertable<SavingsGoalsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? target,
    Expression<double>? current,
    Expression<DateTime>? deadline,
    Expression<String>? color,
    Expression<String>? icon,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (target != null) 'target': target,
      if (current != null) 'current': current,
      if (deadline != null) 'deadline': deadline,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavingsGoalsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<double>? target,
    Value<double>? current,
    Value<DateTime?>? deadline,
    Value<String>? color,
    Value<String?>? icon,
    Value<int>? rowid,
  }) {
    return SavingsGoalsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      target: target ?? this.target,
      current: current ?? this.current,
      deadline: deadline ?? this.deadline,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (target.present) {
      map['target'] = Variable<double>(target.value);
    }
    if (current.present) {
      map['current'] = Variable<double>(current.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavingsGoalsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('target: $target, ')
          ..write('current: $current, ')
          ..write('deadline: $deadline, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MerchantMappingsTableTable extends MerchantMappingsTable
    with TableInfo<$MerchantMappingsTableTable, MerchantMappingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MerchantMappingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _merchantKeyMeta = const VerificationMeta(
    'merchantKey',
  );
  @override
  late final GeneratedColumn<String> merchantKey = GeneratedColumn<String>(
    'merchant_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userDefinedMeta = const VerificationMeta(
    'userDefined',
  );
  @override
  late final GeneratedColumn<bool> userDefined = GeneratedColumn<bool>(
    'user_defined',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("user_defined" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [merchantKey, categoryId, userDefined];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'merchant_mappings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MerchantMappingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('merchant_key')) {
      context.handle(
        _merchantKeyMeta,
        merchantKey.isAcceptableOrUnknown(
          data['merchant_key']!,
          _merchantKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_merchantKeyMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('user_defined')) {
      context.handle(
        _userDefinedMeta,
        userDefined.isAcceptableOrUnknown(
          data['user_defined']!,
          _userDefinedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {merchantKey};
  @override
  MerchantMappingsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MerchantMappingsTableData(
      merchantKey:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}merchant_key'],
          )!,
      categoryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category_id'],
          )!,
      userDefined:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}user_defined'],
          )!,
    );
  }

  @override
  $MerchantMappingsTableTable createAlias(String alias) {
    return $MerchantMappingsTableTable(attachedDatabase, alias);
  }
}

class MerchantMappingsTableData extends DataClass
    implements Insertable<MerchantMappingsTableData> {
  final String merchantKey;
  final String categoryId;
  final bool userDefined;
  const MerchantMappingsTableData({
    required this.merchantKey,
    required this.categoryId,
    required this.userDefined,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['merchant_key'] = Variable<String>(merchantKey);
    map['category_id'] = Variable<String>(categoryId);
    map['user_defined'] = Variable<bool>(userDefined);
    return map;
  }

  MerchantMappingsTableCompanion toCompanion(bool nullToAbsent) {
    return MerchantMappingsTableCompanion(
      merchantKey: Value(merchantKey),
      categoryId: Value(categoryId),
      userDefined: Value(userDefined),
    );
  }

  factory MerchantMappingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MerchantMappingsTableData(
      merchantKey: serializer.fromJson<String>(json['merchantKey']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      userDefined: serializer.fromJson<bool>(json['userDefined']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'merchantKey': serializer.toJson<String>(merchantKey),
      'categoryId': serializer.toJson<String>(categoryId),
      'userDefined': serializer.toJson<bool>(userDefined),
    };
  }

  MerchantMappingsTableData copyWith({
    String? merchantKey,
    String? categoryId,
    bool? userDefined,
  }) => MerchantMappingsTableData(
    merchantKey: merchantKey ?? this.merchantKey,
    categoryId: categoryId ?? this.categoryId,
    userDefined: userDefined ?? this.userDefined,
  );
  MerchantMappingsTableData copyWithCompanion(
    MerchantMappingsTableCompanion data,
  ) {
    return MerchantMappingsTableData(
      merchantKey:
          data.merchantKey.present ? data.merchantKey.value : this.merchantKey,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      userDefined:
          data.userDefined.present ? data.userDefined.value : this.userDefined,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MerchantMappingsTableData(')
          ..write('merchantKey: $merchantKey, ')
          ..write('categoryId: $categoryId, ')
          ..write('userDefined: $userDefined')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(merchantKey, categoryId, userDefined);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MerchantMappingsTableData &&
          other.merchantKey == this.merchantKey &&
          other.categoryId == this.categoryId &&
          other.userDefined == this.userDefined);
}

class MerchantMappingsTableCompanion
    extends UpdateCompanion<MerchantMappingsTableData> {
  final Value<String> merchantKey;
  final Value<String> categoryId;
  final Value<bool> userDefined;
  final Value<int> rowid;
  const MerchantMappingsTableCompanion({
    this.merchantKey = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.userDefined = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MerchantMappingsTableCompanion.insert({
    required String merchantKey,
    required String categoryId,
    this.userDefined = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : merchantKey = Value(merchantKey),
       categoryId = Value(categoryId);
  static Insertable<MerchantMappingsTableData> custom({
    Expression<String>? merchantKey,
    Expression<String>? categoryId,
    Expression<bool>? userDefined,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (merchantKey != null) 'merchant_key': merchantKey,
      if (categoryId != null) 'category_id': categoryId,
      if (userDefined != null) 'user_defined': userDefined,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MerchantMappingsTableCompanion copyWith({
    Value<String>? merchantKey,
    Value<String>? categoryId,
    Value<bool>? userDefined,
    Value<int>? rowid,
  }) {
    return MerchantMappingsTableCompanion(
      merchantKey: merchantKey ?? this.merchantKey,
      categoryId: categoryId ?? this.categoryId,
      userDefined: userDefined ?? this.userDefined,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (merchantKey.present) {
      map['merchant_key'] = Variable<String>(merchantKey.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (userDefined.present) {
      map['user_defined'] = Variable<bool>(userDefined.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MerchantMappingsTableCompanion(')
          ..write('merchantKey: $merchantKey, ')
          ..write('categoryId: $categoryId, ')
          ..write('userDefined: $userDefined, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProfileTableTable extends UserProfileTable
    with TableInfo<$UserProfileTableTable, UserProfileTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfileTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _monthlySalaryMeta = const VerificationMeta(
    'monthlySalary',
  );
  @override
  late final GeneratedColumn<double> monthlySalary = GeneratedColumn<double>(
    'monthly_salary',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _salaryDateMeta = const VerificationMeta(
    'salaryDate',
  );
  @override
  late final GeneratedColumn<int> salaryDate = GeneratedColumn<int>(
    'salary_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('INR'),
  );
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
    'onboarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _biometricEnabledMeta = const VerificationMeta(
    'biometricEnabled',
  );
  @override
  late final GeneratedColumn<bool> biometricEnabled = GeneratedColumn<bool>(
    'biometric_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("biometric_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
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
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profile_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfileTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('monthly_salary')) {
      context.handle(
        _monthlySalaryMeta,
        monthlySalary.isAcceptableOrUnknown(
          data['monthly_salary']!,
          _monthlySalaryMeta,
        ),
      );
    }
    if (data.containsKey('salary_date')) {
      context.handle(
        _salaryDateMeta,
        salaryDate.isAcceptableOrUnknown(data['salary_date']!, _salaryDateMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
        _onboardingCompleteMeta,
        onboardingComplete.isAcceptableOrUnknown(
          data['onboarding_complete']!,
          _onboardingCompleteMeta,
        ),
      );
    }
    if (data.containsKey('biometric_enabled')) {
      context.handle(
        _biometricEnabledMeta,
        biometricEnabled.isAcceptableOrUnknown(
          data['biometric_enabled']!,
          _biometricEnabledMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      monthlySalary:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}monthly_salary'],
          )!,
      salaryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}salary_date'],
      ),
      currency:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}currency'],
          )!,
      onboardingComplete:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}onboarding_complete'],
          )!,
      biometricEnabled:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}biometric_enabled'],
          )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $UserProfileTableTable createAlias(String alias) {
    return $UserProfileTableTable(attachedDatabase, alias);
  }
}

class UserProfileTableData extends DataClass
    implements Insertable<UserProfileTableData> {
  final String id;
  final String? name;
  final String? email;
  final String? avatarUrl;
  final double monthlySalary;
  final int? salaryDate;
  final String currency;
  final bool onboardingComplete;
  final bool biometricEnabled;
  final DateTime? createdAt;
  const UserProfileTableData({
    required this.id,
    this.name,
    this.email,
    this.avatarUrl,
    required this.monthlySalary,
    this.salaryDate,
    required this.currency,
    required this.onboardingComplete,
    required this.biometricEnabled,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['monthly_salary'] = Variable<double>(monthlySalary);
    if (!nullToAbsent || salaryDate != null) {
      map['salary_date'] = Variable<int>(salaryDate);
    }
    map['currency'] = Variable<String>(currency);
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    map['biometric_enabled'] = Variable<bool>(biometricEnabled);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  UserProfileTableCompanion toCompanion(bool nullToAbsent) {
    return UserProfileTableCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      avatarUrl:
          avatarUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(avatarUrl),
      monthlySalary: Value(monthlySalary),
      salaryDate:
          salaryDate == null && nullToAbsent
              ? const Value.absent()
              : Value(salaryDate),
      currency: Value(currency),
      onboardingComplete: Value(onboardingComplete),
      biometricEnabled: Value(biometricEnabled),
      createdAt:
          createdAt == null && nullToAbsent
              ? const Value.absent()
              : Value(createdAt),
    );
  }

  factory UserProfileTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      monthlySalary: serializer.fromJson<double>(json['monthlySalary']),
      salaryDate: serializer.fromJson<int?>(json['salaryDate']),
      currency: serializer.fromJson<String>(json['currency']),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
      biometricEnabled: serializer.fromJson<bool>(json['biometricEnabled']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'email': serializer.toJson<String?>(email),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'monthlySalary': serializer.toJson<double>(monthlySalary),
      'salaryDate': serializer.toJson<int?>(salaryDate),
      'currency': serializer.toJson<String>(currency),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
      'biometricEnabled': serializer.toJson<bool>(biometricEnabled),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  UserProfileTableData copyWith({
    String? id,
    Value<String?> name = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    double? monthlySalary,
    Value<int?> salaryDate = const Value.absent(),
    String? currency,
    bool? onboardingComplete,
    bool? biometricEnabled,
    Value<DateTime?> createdAt = const Value.absent(),
  }) => UserProfileTableData(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    email: email.present ? email.value : this.email,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    monthlySalary: monthlySalary ?? this.monthlySalary,
    salaryDate: salaryDate.present ? salaryDate.value : this.salaryDate,
    currency: currency ?? this.currency,
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    biometricEnabled: biometricEnabled ?? this.biometricEnabled,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  UserProfileTableData copyWithCompanion(UserProfileTableCompanion data) {
    return UserProfileTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      monthlySalary:
          data.monthlySalary.present
              ? data.monthlySalary.value
              : this.monthlySalary,
      salaryDate:
          data.salaryDate.present ? data.salaryDate.value : this.salaryDate,
      currency: data.currency.present ? data.currency.value : this.currency,
      onboardingComplete:
          data.onboardingComplete.present
              ? data.onboardingComplete.value
              : this.onboardingComplete,
      biometricEnabled:
          data.biometricEnabled.present
              ? data.biometricEnabled.value
              : this.biometricEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('monthlySalary: $monthlySalary, ')
          ..write('salaryDate: $salaryDate, ')
          ..write('currency: $currency, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('biometricEnabled: $biometricEnabled, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.avatarUrl == this.avatarUrl &&
          other.monthlySalary == this.monthlySalary &&
          other.salaryDate == this.salaryDate &&
          other.currency == this.currency &&
          other.onboardingComplete == this.onboardingComplete &&
          other.biometricEnabled == this.biometricEnabled &&
          other.createdAt == this.createdAt);
}

class UserProfileTableCompanion extends UpdateCompanion<UserProfileTableData> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> email;
  final Value<String?> avatarUrl;
  final Value<double> monthlySalary;
  final Value<int?> salaryDate;
  final Value<String> currency;
  final Value<bool> onboardingComplete;
  final Value<bool> biometricEnabled;
  final Value<DateTime?> createdAt;
  final Value<int> rowid;
  const UserProfileTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.monthlySalary = const Value.absent(),
    this.salaryDate = const Value.absent(),
    this.currency = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.biometricEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfileTableCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.monthlySalary = const Value.absent(),
    this.salaryDate = const Value.absent(),
    this.currency = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.biometricEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<UserProfileTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? avatarUrl,
    Expression<double>? monthlySalary,
    Expression<int>? salaryDate,
    Expression<String>? currency,
    Expression<bool>? onboardingComplete,
    Expression<bool>? biometricEnabled,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (monthlySalary != null) 'monthly_salary': monthlySalary,
      if (salaryDate != null) 'salary_date': salaryDate,
      if (currency != null) 'currency': currency,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
      if (biometricEnabled != null) 'biometric_enabled': biometricEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfileTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? name,
    Value<String?>? email,
    Value<String?>? avatarUrl,
    Value<double>? monthlySalary,
    Value<int?>? salaryDate,
    Value<String>? currency,
    Value<bool>? onboardingComplete,
    Value<bool>? biometricEnabled,
    Value<DateTime?>? createdAt,
    Value<int>? rowid,
  }) {
    return UserProfileTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      monthlySalary: monthlySalary ?? this.monthlySalary,
      salaryDate: salaryDate ?? this.salaryDate,
      currency: currency ?? this.currency,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (monthlySalary.present) {
      map['monthly_salary'] = Variable<double>(monthlySalary.value);
    }
    if (salaryDate.present) {
      map['salary_date'] = Variable<int>(salaryDate.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    if (biometricEnabled.present) {
      map['biometric_enabled'] = Variable<bool>(biometricEnabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('monthlySalary: $monthlySalary, ')
          ..write('salaryDate: $salaryDate, ')
          ..write('currency: $currency, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('biometricEnabled: $biometricEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiInsightsTableTable extends AiInsightsTable
    with TableInfo<$AiInsightsTableTable, AiInsightsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiInsightsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dismissedMeta = const VerificationMeta(
    'dismissed',
  );
  @override
  late final GeneratedColumn<bool> dismissed = GeneratedColumn<bool>(
    'dismissed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dismissed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    content,
    generatedAt,
    dismissed,
    categoryId,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_insights_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiInsightsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedAtMeta);
    }
    if (data.containsKey('dismissed')) {
      context.handle(
        _dismissedMeta,
        dismissed.isAcceptableOrUnknown(data['dismissed']!, _dismissedMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiInsightsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiInsightsTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      content:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}content'],
          )!,
      generatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}generated_at'],
          )!,
      dismissed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}dismissed'],
          )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      ),
    );
  }

  @override
  $AiInsightsTableTable createAlias(String alias) {
    return $AiInsightsTableTable(attachedDatabase, alias);
  }
}

class AiInsightsTableData extends DataClass
    implements Insertable<AiInsightsTableData> {
  final String id;
  final String type;
  final String content;
  final DateTime generatedAt;
  final bool dismissed;
  final String? categoryId;
  final String? metadata;
  const AiInsightsTableData({
    required this.id,
    required this.type,
    required this.content,
    required this.generatedAt,
    required this.dismissed,
    this.categoryId,
    this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['content'] = Variable<String>(content);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    map['dismissed'] = Variable<bool>(dismissed);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    return map;
  }

  AiInsightsTableCompanion toCompanion(bool nullToAbsent) {
    return AiInsightsTableCompanion(
      id: Value(id),
      type: Value(type),
      content: Value(content),
      generatedAt: Value(generatedAt),
      dismissed: Value(dismissed),
      categoryId:
          categoryId == null && nullToAbsent
              ? const Value.absent()
              : Value(categoryId),
      metadata:
          metadata == null && nullToAbsent
              ? const Value.absent()
              : Value(metadata),
    );
  }

  factory AiInsightsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiInsightsTableData(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      content: serializer.fromJson<String>(json['content']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
      dismissed: serializer.fromJson<bool>(json['dismissed']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      metadata: serializer.fromJson<String?>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'content': serializer.toJson<String>(content),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
      'dismissed': serializer.toJson<bool>(dismissed),
      'categoryId': serializer.toJson<String?>(categoryId),
      'metadata': serializer.toJson<String?>(metadata),
    };
  }

  AiInsightsTableData copyWith({
    String? id,
    String? type,
    String? content,
    DateTime? generatedAt,
    bool? dismissed,
    Value<String?> categoryId = const Value.absent(),
    Value<String?> metadata = const Value.absent(),
  }) => AiInsightsTableData(
    id: id ?? this.id,
    type: type ?? this.type,
    content: content ?? this.content,
    generatedAt: generatedAt ?? this.generatedAt,
    dismissed: dismissed ?? this.dismissed,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    metadata: metadata.present ? metadata.value : this.metadata,
  );
  AiInsightsTableData copyWithCompanion(AiInsightsTableCompanion data) {
    return AiInsightsTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
      generatedAt:
          data.generatedAt.present ? data.generatedAt.value : this.generatedAt,
      dismissed: data.dismissed.present ? data.dismissed.value : this.dismissed,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiInsightsTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('dismissed: $dismissed, ')
          ..write('categoryId: $categoryId, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    content,
    generatedAt,
    dismissed,
    categoryId,
    metadata,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiInsightsTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.content == this.content &&
          other.generatedAt == this.generatedAt &&
          other.dismissed == this.dismissed &&
          other.categoryId == this.categoryId &&
          other.metadata == this.metadata);
}

class AiInsightsTableCompanion extends UpdateCompanion<AiInsightsTableData> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> content;
  final Value<DateTime> generatedAt;
  final Value<bool> dismissed;
  final Value<String?> categoryId;
  final Value<String?> metadata;
  final Value<int> rowid;
  const AiInsightsTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.dismissed = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiInsightsTableCompanion.insert({
    required String id,
    required String type,
    required String content,
    required DateTime generatedAt,
    this.dismissed = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       content = Value(content),
       generatedAt = Value(generatedAt);
  static Insertable<AiInsightsTableData> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? content,
    Expression<DateTime>? generatedAt,
    Expression<bool>? dismissed,
    Expression<String>? categoryId,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (dismissed != null) 'dismissed': dismissed,
      if (categoryId != null) 'category_id': categoryId,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiInsightsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String>? content,
    Value<DateTime>? generatedAt,
    Value<bool>? dismissed,
    Value<String?>? categoryId,
    Value<String?>? metadata,
    Value<int>? rowid,
  }) {
    return AiInsightsTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      content: content ?? this.content,
      generatedAt: generatedAt ?? this.generatedAt,
      dismissed: dismissed ?? this.dismissed,
      categoryId: categoryId ?? this.categoryId,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (dismissed.present) {
      map['dismissed'] = Variable<bool>(dismissed.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiInsightsTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('dismissed: $dismissed, ')
          ..write('categoryId: $categoryId, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TransactionsTableTable transactionsTable =
      $TransactionsTableTable(this);
  late final $CategoriesTableTable categoriesTable = $CategoriesTableTable(
    this,
  );
  late final $BudgetsTableTable budgetsTable = $BudgetsTableTable(this);
  late final $SavingsGoalsTableTable savingsGoalsTable =
      $SavingsGoalsTableTable(this);
  late final $MerchantMappingsTableTable merchantMappingsTable =
      $MerchantMappingsTableTable(this);
  late final $UserProfileTableTable userProfileTable = $UserProfileTableTable(
    this,
  );
  late final $AiInsightsTableTable aiInsightsTable = $AiInsightsTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    transactionsTable,
    categoriesTable,
    budgetsTable,
    savingsGoalsTable,
    merchantMappingsTable,
    userProfileTable,
    aiInsightsTable,
  ];
}

typedef $$TransactionsTableTableCreateCompanionBuilder =
    TransactionsTableCompanion Function({
      required String id,
      required double amount,
      required TransactionType type,
      required String categoryId,
      required DateTime timestamp,
      Value<TransactionSource> source,
      Value<String?> merchant,
      Value<String?> note,
      Value<String> tags,
      Value<String?> refNumber,
      Value<bool> isRecurring,
      Value<String?> recurringId,
      Value<bool> synced,
      Value<int> rowid,
    });
typedef $$TransactionsTableTableUpdateCompanionBuilder =
    TransactionsTableCompanion Function({
      Value<String> id,
      Value<double> amount,
      Value<TransactionType> type,
      Value<String> categoryId,
      Value<DateTime> timestamp,
      Value<TransactionSource> source,
      Value<String?> merchant,
      Value<String?> note,
      Value<String> tags,
      Value<String?> refNumber,
      Value<bool> isRecurring,
      Value<String?> recurringId,
      Value<bool> synced,
      Value<int> rowid,
    });

class $$TransactionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TransactionType, TransactionType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TransactionSource, TransactionSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refNumber => $composableBuilder(
    column: $table.refNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurringId => $composableBuilder(
    column: $table.recurringId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TransactionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refNumber => $composableBuilder(
    column: $table.refNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurringId => $composableBuilder(
    column: $table.recurringId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TransactionType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TransactionSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get merchant =>
      $composableBuilder(column: $table.merchant, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get refNumber =>
      $composableBuilder(column: $table.refNumber, builder: (column) => column);

  GeneratedColumn<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recurringId => $composableBuilder(
    column: $table.recurringId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);
}

class $$TransactionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTableTable,
          TransactionsTableData,
          $$TransactionsTableTableFilterComposer,
          $$TransactionsTableTableOrderingComposer,
          $$TransactionsTableTableAnnotationComposer,
          $$TransactionsTableTableCreateCompanionBuilder,
          $$TransactionsTableTableUpdateCompanionBuilder,
          (
            TransactionsTableData,
            BaseReferences<
              _$AppDatabase,
              $TransactionsTableTable,
              TransactionsTableData
            >,
          ),
          TransactionsTableData,
          PrefetchHooks Function()
        > {
  $$TransactionsTableTableTableManager(
    _$AppDatabase db,
    $TransactionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TransactionsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$TransactionsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$TransactionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<TransactionType> type = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<TransactionSource> source = const Value.absent(),
                Value<String?> merchant = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<String?> refNumber = const Value.absent(),
                Value<bool> isRecurring = const Value.absent(),
                Value<String?> recurringId = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsTableCompanion(
                id: id,
                amount: amount,
                type: type,
                categoryId: categoryId,
                timestamp: timestamp,
                source: source,
                merchant: merchant,
                note: note,
                tags: tags,
                refNumber: refNumber,
                isRecurring: isRecurring,
                recurringId: recurringId,
                synced: synced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required double amount,
                required TransactionType type,
                required String categoryId,
                required DateTime timestamp,
                Value<TransactionSource> source = const Value.absent(),
                Value<String?> merchant = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<String?> refNumber = const Value.absent(),
                Value<bool> isRecurring = const Value.absent(),
                Value<String?> recurringId = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsTableCompanion.insert(
                id: id,
                amount: amount,
                type: type,
                categoryId: categoryId,
                timestamp: timestamp,
                source: source,
                merchant: merchant,
                note: note,
                tags: tags,
                refNumber: refNumber,
                isRecurring: isRecurring,
                recurringId: recurringId,
                synced: synced,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransactionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTableTable,
      TransactionsTableData,
      $$TransactionsTableTableFilterComposer,
      $$TransactionsTableTableOrderingComposer,
      $$TransactionsTableTableAnnotationComposer,
      $$TransactionsTableTableCreateCompanionBuilder,
      $$TransactionsTableTableUpdateCompanionBuilder,
      (
        TransactionsTableData,
        BaseReferences<
          _$AppDatabase,
          $TransactionsTableTable,
          TransactionsTableData
        >,
      ),
      TransactionsTableData,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableTableCreateCompanionBuilder =
    CategoriesTableCompanion Function({
      required String id,
      required String name,
      required String icon,
      required String color,
      Value<bool> isCustom,
      Value<String?> parentId,
      Value<int> rowid,
    });
typedef $$CategoriesTableTableUpdateCompanionBuilder =
    CategoriesTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> icon,
      Value<String> color,
      Value<bool> isCustom,
      Value<String?> parentId,
      Value<int> rowid,
    });

class $$CategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<bool> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);
}

class $$CategoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTableTable,
          CategoriesTableData,
          $$CategoriesTableTableFilterComposer,
          $$CategoriesTableTableOrderingComposer,
          $$CategoriesTableTableAnnotationComposer,
          $$CategoriesTableTableCreateCompanionBuilder,
          $$CategoriesTableTableUpdateCompanionBuilder,
          (
            CategoriesTableData,
            BaseReferences<
              _$AppDatabase,
              $CategoriesTableTable,
              CategoriesTableData
            >,
          ),
          CategoriesTableData,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableTableManager(
    _$AppDatabase db,
    $CategoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$CategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CategoriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$CategoriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesTableCompanion(
                id: id,
                name: name,
                icon: icon,
                color: color,
                isCustom: isCustom,
                parentId: parentId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String icon,
                required String color,
                Value<bool> isCustom = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesTableCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                color: color,
                isCustom: isCustom,
                parentId: parentId,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTableTable,
      CategoriesTableData,
      $$CategoriesTableTableFilterComposer,
      $$CategoriesTableTableOrderingComposer,
      $$CategoriesTableTableAnnotationComposer,
      $$CategoriesTableTableCreateCompanionBuilder,
      $$CategoriesTableTableUpdateCompanionBuilder,
      (
        CategoriesTableData,
        BaseReferences<
          _$AppDatabase,
          $CategoriesTableTable,
          CategoriesTableData
        >,
      ),
      CategoriesTableData,
      PrefetchHooks Function()
    >;
typedef $$BudgetsTableTableCreateCompanionBuilder =
    BudgetsTableCompanion Function({
      required String id,
      required String categoryId,
      required int month,
      required double amount,
      Value<double> spent,
      Value<double> alertAt,
      Value<int> rowid,
    });
typedef $$BudgetsTableTableUpdateCompanionBuilder =
    BudgetsTableCompanion Function({
      Value<String> id,
      Value<String> categoryId,
      Value<int> month,
      Value<double> amount,
      Value<double> spent,
      Value<double> alertAt,
      Value<int> rowid,
    });

class $$BudgetsTableTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetsTableTable> {
  $$BudgetsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get spent => $composableBuilder(
    column: $table.spent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get alertAt => $composableBuilder(
    column: $table.alertAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BudgetsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetsTableTable> {
  $$BudgetsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get month => $composableBuilder(
    column: $table.month,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get spent => $composableBuilder(
    column: $table.spent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get alertAt => $composableBuilder(
    column: $table.alertAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BudgetsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetsTableTable> {
  $$BudgetsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get spent =>
      $composableBuilder(column: $table.spent, builder: (column) => column);

  GeneratedColumn<double> get alertAt =>
      $composableBuilder(column: $table.alertAt, builder: (column) => column);
}

class $$BudgetsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetsTableTable,
          BudgetsTableData,
          $$BudgetsTableTableFilterComposer,
          $$BudgetsTableTableOrderingComposer,
          $$BudgetsTableTableAnnotationComposer,
          $$BudgetsTableTableCreateCompanionBuilder,
          $$BudgetsTableTableUpdateCompanionBuilder,
          (
            BudgetsTableData,
            BaseReferences<_$AppDatabase, $BudgetsTableTable, BudgetsTableData>,
          ),
          BudgetsTableData,
          PrefetchHooks Function()
        > {
  $$BudgetsTableTableTableManager(_$AppDatabase db, $BudgetsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BudgetsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BudgetsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$BudgetsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<int> month = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<double> spent = const Value.absent(),
                Value<double> alertAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetsTableCompanion(
                id: id,
                categoryId: categoryId,
                month: month,
                amount: amount,
                spent: spent,
                alertAt: alertAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String categoryId,
                required int month,
                required double amount,
                Value<double> spent = const Value.absent(),
                Value<double> alertAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetsTableCompanion.insert(
                id: id,
                categoryId: categoryId,
                month: month,
                amount: amount,
                spent: spent,
                alertAt: alertAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BudgetsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetsTableTable,
      BudgetsTableData,
      $$BudgetsTableTableFilterComposer,
      $$BudgetsTableTableOrderingComposer,
      $$BudgetsTableTableAnnotationComposer,
      $$BudgetsTableTableCreateCompanionBuilder,
      $$BudgetsTableTableUpdateCompanionBuilder,
      (
        BudgetsTableData,
        BaseReferences<_$AppDatabase, $BudgetsTableTable, BudgetsTableData>,
      ),
      BudgetsTableData,
      PrefetchHooks Function()
    >;
typedef $$SavingsGoalsTableTableCreateCompanionBuilder =
    SavingsGoalsTableCompanion Function({
      required String id,
      required String name,
      required double target,
      Value<double> current,
      Value<DateTime?> deadline,
      required String color,
      Value<String?> icon,
      Value<int> rowid,
    });
typedef $$SavingsGoalsTableTableUpdateCompanionBuilder =
    SavingsGoalsTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<double> target,
      Value<double> current,
      Value<DateTime?> deadline,
      Value<String> color,
      Value<String?> icon,
      Value<int> rowid,
    });

class $$SavingsGoalsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SavingsGoalsTableTable> {
  $$SavingsGoalsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get current => $composableBuilder(
    column: $table.current,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavingsGoalsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SavingsGoalsTableTable> {
  $$SavingsGoalsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get current => $composableBuilder(
    column: $table.current,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavingsGoalsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavingsGoalsTableTable> {
  $$SavingsGoalsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumn<double> get current =>
      $composableBuilder(column: $table.current, builder: (column) => column);

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);
}

class $$SavingsGoalsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavingsGoalsTableTable,
          SavingsGoalsTableData,
          $$SavingsGoalsTableTableFilterComposer,
          $$SavingsGoalsTableTableOrderingComposer,
          $$SavingsGoalsTableTableAnnotationComposer,
          $$SavingsGoalsTableTableCreateCompanionBuilder,
          $$SavingsGoalsTableTableUpdateCompanionBuilder,
          (
            SavingsGoalsTableData,
            BaseReferences<
              _$AppDatabase,
              $SavingsGoalsTableTable,
              SavingsGoalsTableData
            >,
          ),
          SavingsGoalsTableData,
          PrefetchHooks Function()
        > {
  $$SavingsGoalsTableTableTableManager(
    _$AppDatabase db,
    $SavingsGoalsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SavingsGoalsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$SavingsGoalsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$SavingsGoalsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> target = const Value.absent(),
                Value<double> current = const Value.absent(),
                Value<DateTime?> deadline = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavingsGoalsTableCompanion(
                id: id,
                name: name,
                target: target,
                current: current,
                deadline: deadline,
                color: color,
                icon: icon,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required double target,
                Value<double> current = const Value.absent(),
                Value<DateTime?> deadline = const Value.absent(),
                required String color,
                Value<String?> icon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavingsGoalsTableCompanion.insert(
                id: id,
                name: name,
                target: target,
                current: current,
                deadline: deadline,
                color: color,
                icon: icon,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavingsGoalsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavingsGoalsTableTable,
      SavingsGoalsTableData,
      $$SavingsGoalsTableTableFilterComposer,
      $$SavingsGoalsTableTableOrderingComposer,
      $$SavingsGoalsTableTableAnnotationComposer,
      $$SavingsGoalsTableTableCreateCompanionBuilder,
      $$SavingsGoalsTableTableUpdateCompanionBuilder,
      (
        SavingsGoalsTableData,
        BaseReferences<
          _$AppDatabase,
          $SavingsGoalsTableTable,
          SavingsGoalsTableData
        >,
      ),
      SavingsGoalsTableData,
      PrefetchHooks Function()
    >;
typedef $$MerchantMappingsTableTableCreateCompanionBuilder =
    MerchantMappingsTableCompanion Function({
      required String merchantKey,
      required String categoryId,
      Value<bool> userDefined,
      Value<int> rowid,
    });
typedef $$MerchantMappingsTableTableUpdateCompanionBuilder =
    MerchantMappingsTableCompanion Function({
      Value<String> merchantKey,
      Value<String> categoryId,
      Value<bool> userDefined,
      Value<int> rowid,
    });

class $$MerchantMappingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $MerchantMappingsTableTable> {
  $$MerchantMappingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get merchantKey => $composableBuilder(
    column: $table.merchantKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get userDefined => $composableBuilder(
    column: $table.userDefined,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MerchantMappingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MerchantMappingsTableTable> {
  $$MerchantMappingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get merchantKey => $composableBuilder(
    column: $table.merchantKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get userDefined => $composableBuilder(
    column: $table.userDefined,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MerchantMappingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MerchantMappingsTableTable> {
  $$MerchantMappingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get merchantKey => $composableBuilder(
    column: $table.merchantKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get userDefined => $composableBuilder(
    column: $table.userDefined,
    builder: (column) => column,
  );
}

class $$MerchantMappingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MerchantMappingsTableTable,
          MerchantMappingsTableData,
          $$MerchantMappingsTableTableFilterComposer,
          $$MerchantMappingsTableTableOrderingComposer,
          $$MerchantMappingsTableTableAnnotationComposer,
          $$MerchantMappingsTableTableCreateCompanionBuilder,
          $$MerchantMappingsTableTableUpdateCompanionBuilder,
          (
            MerchantMappingsTableData,
            BaseReferences<
              _$AppDatabase,
              $MerchantMappingsTableTable,
              MerchantMappingsTableData
            >,
          ),
          MerchantMappingsTableData,
          PrefetchHooks Function()
        > {
  $$MerchantMappingsTableTableTableManager(
    _$AppDatabase db,
    $MerchantMappingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MerchantMappingsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$MerchantMappingsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$MerchantMappingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> merchantKey = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<bool> userDefined = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MerchantMappingsTableCompanion(
                merchantKey: merchantKey,
                categoryId: categoryId,
                userDefined: userDefined,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String merchantKey,
                required String categoryId,
                Value<bool> userDefined = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MerchantMappingsTableCompanion.insert(
                merchantKey: merchantKey,
                categoryId: categoryId,
                userDefined: userDefined,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MerchantMappingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MerchantMappingsTableTable,
      MerchantMappingsTableData,
      $$MerchantMappingsTableTableFilterComposer,
      $$MerchantMappingsTableTableOrderingComposer,
      $$MerchantMappingsTableTableAnnotationComposer,
      $$MerchantMappingsTableTableCreateCompanionBuilder,
      $$MerchantMappingsTableTableUpdateCompanionBuilder,
      (
        MerchantMappingsTableData,
        BaseReferences<
          _$AppDatabase,
          $MerchantMappingsTableTable,
          MerchantMappingsTableData
        >,
      ),
      MerchantMappingsTableData,
      PrefetchHooks Function()
    >;
typedef $$UserProfileTableTableCreateCompanionBuilder =
    UserProfileTableCompanion Function({
      required String id,
      Value<String?> name,
      Value<String?> email,
      Value<String?> avatarUrl,
      Value<double> monthlySalary,
      Value<int?> salaryDate,
      Value<String> currency,
      Value<bool> onboardingComplete,
      Value<bool> biometricEnabled,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });
typedef $$UserProfileTableTableUpdateCompanionBuilder =
    UserProfileTableCompanion Function({
      Value<String> id,
      Value<String?> name,
      Value<String?> email,
      Value<String?> avatarUrl,
      Value<double> monthlySalary,
      Value<int?> salaryDate,
      Value<String> currency,
      Value<bool> onboardingComplete,
      Value<bool> biometricEnabled,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });

class $$UserProfileTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monthlySalary => $composableBuilder(
    column: $table.monthlySalary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get salaryDate => $composableBuilder(
    column: $table.salaryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get biometricEnabled => $composableBuilder(
    column: $table.biometricEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfileTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monthlySalary => $composableBuilder(
    column: $table.monthlySalary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get salaryDate => $composableBuilder(
    column: $table.salaryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get biometricEnabled => $composableBuilder(
    column: $table.biometricEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfileTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<double> get monthlySalary => $composableBuilder(
    column: $table.monthlySalary,
    builder: (column) => column,
  );

  GeneratedColumn<int> get salaryDate => $composableBuilder(
    column: $table.salaryDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get biometricEnabled => $composableBuilder(
    column: $table.biometricEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UserProfileTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfileTableTable,
          UserProfileTableData,
          $$UserProfileTableTableFilterComposer,
          $$UserProfileTableTableOrderingComposer,
          $$UserProfileTableTableAnnotationComposer,
          $$UserProfileTableTableCreateCompanionBuilder,
          $$UserProfileTableTableUpdateCompanionBuilder,
          (
            UserProfileTableData,
            BaseReferences<
              _$AppDatabase,
              $UserProfileTableTable,
              UserProfileTableData
            >,
          ),
          UserProfileTableData,
          PrefetchHooks Function()
        > {
  $$UserProfileTableTableTableManager(
    _$AppDatabase db,
    $UserProfileTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$UserProfileTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UserProfileTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$UserProfileTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<double> monthlySalary = const Value.absent(),
                Value<int?> salaryDate = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<bool> biometricEnabled = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfileTableCompanion(
                id: id,
                name: name,
                email: email,
                avatarUrl: avatarUrl,
                monthlySalary: monthlySalary,
                salaryDate: salaryDate,
                currency: currency,
                onboardingComplete: onboardingComplete,
                biometricEnabled: biometricEnabled,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<double> monthlySalary = const Value.absent(),
                Value<int?> salaryDate = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<bool> biometricEnabled = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfileTableCompanion.insert(
                id: id,
                name: name,
                email: email,
                avatarUrl: avatarUrl,
                monthlySalary: monthlySalary,
                salaryDate: salaryDate,
                currency: currency,
                onboardingComplete: onboardingComplete,
                biometricEnabled: biometricEnabled,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfileTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfileTableTable,
      UserProfileTableData,
      $$UserProfileTableTableFilterComposer,
      $$UserProfileTableTableOrderingComposer,
      $$UserProfileTableTableAnnotationComposer,
      $$UserProfileTableTableCreateCompanionBuilder,
      $$UserProfileTableTableUpdateCompanionBuilder,
      (
        UserProfileTableData,
        BaseReferences<
          _$AppDatabase,
          $UserProfileTableTable,
          UserProfileTableData
        >,
      ),
      UserProfileTableData,
      PrefetchHooks Function()
    >;
typedef $$AiInsightsTableTableCreateCompanionBuilder =
    AiInsightsTableCompanion Function({
      required String id,
      required String type,
      required String content,
      required DateTime generatedAt,
      Value<bool> dismissed,
      Value<String?> categoryId,
      Value<String?> metadata,
      Value<int> rowid,
    });
typedef $$AiInsightsTableTableUpdateCompanionBuilder =
    AiInsightsTableCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<String> content,
      Value<DateTime> generatedAt,
      Value<bool> dismissed,
      Value<String?> categoryId,
      Value<String?> metadata,
      Value<int> rowid,
    });

class $$AiInsightsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AiInsightsTableTable> {
  $$AiInsightsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dismissed => $composableBuilder(
    column: $table.dismissed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AiInsightsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AiInsightsTableTable> {
  $$AiInsightsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dismissed => $composableBuilder(
    column: $table.dismissed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AiInsightsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiInsightsTableTable> {
  $$AiInsightsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get dismissed =>
      $composableBuilder(column: $table.dismissed, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);
}

class $$AiInsightsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiInsightsTableTable,
          AiInsightsTableData,
          $$AiInsightsTableTableFilterComposer,
          $$AiInsightsTableTableOrderingComposer,
          $$AiInsightsTableTableAnnotationComposer,
          $$AiInsightsTableTableCreateCompanionBuilder,
          $$AiInsightsTableTableUpdateCompanionBuilder,
          (
            AiInsightsTableData,
            BaseReferences<
              _$AppDatabase,
              $AiInsightsTableTable,
              AiInsightsTableData
            >,
          ),
          AiInsightsTableData,
          PrefetchHooks Function()
        > {
  $$AiInsightsTableTableTableManager(
    _$AppDatabase db,
    $AiInsightsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$AiInsightsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AiInsightsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$AiInsightsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<bool> dismissed = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiInsightsTableCompanion(
                id: id,
                type: type,
                content: content,
                generatedAt: generatedAt,
                dismissed: dismissed,
                categoryId: categoryId,
                metadata: metadata,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required String content,
                required DateTime generatedAt,
                Value<bool> dismissed = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AiInsightsTableCompanion.insert(
                id: id,
                type: type,
                content: content,
                generatedAt: generatedAt,
                dismissed: dismissed,
                categoryId: categoryId,
                metadata: metadata,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AiInsightsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiInsightsTableTable,
      AiInsightsTableData,
      $$AiInsightsTableTableFilterComposer,
      $$AiInsightsTableTableOrderingComposer,
      $$AiInsightsTableTableAnnotationComposer,
      $$AiInsightsTableTableCreateCompanionBuilder,
      $$AiInsightsTableTableUpdateCompanionBuilder,
      (
        AiInsightsTableData,
        BaseReferences<
          _$AppDatabase,
          $AiInsightsTableTable,
          AiInsightsTableData
        >,
      ),
      AiInsightsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TransactionsTableTableTableManager get transactionsTable =>
      $$TransactionsTableTableTableManager(_db, _db.transactionsTable);
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(_db, _db.categoriesTable);
  $$BudgetsTableTableTableManager get budgetsTable =>
      $$BudgetsTableTableTableManager(_db, _db.budgetsTable);
  $$SavingsGoalsTableTableTableManager get savingsGoalsTable =>
      $$SavingsGoalsTableTableTableManager(_db, _db.savingsGoalsTable);
  $$MerchantMappingsTableTableTableManager get merchantMappingsTable =>
      $$MerchantMappingsTableTableTableManager(_db, _db.merchantMappingsTable);
  $$UserProfileTableTableTableManager get userProfileTable =>
      $$UserProfileTableTableTableManager(_db, _db.userProfileTable);
  $$AiInsightsTableTableTableManager get aiInsightsTable =>
      $$AiInsightsTableTableTableManager(_db, _db.aiInsightsTable);
}
