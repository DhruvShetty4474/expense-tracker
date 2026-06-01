import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import '../../shared/enums/transaction_type.dart';
import '../../shared/enums/transaction_source.dart';

part 'app_database.g.dart';

// ─── Tables ────────────────────────────────────────────────────────────────

class TransactionsTable extends Table {
  TextColumn get id => text()();
  RealColumn get amount => real()();
  TextColumn get type => textEnum<TransactionType>()();
  TextColumn get categoryId => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get source => textEnum<TransactionSource>().withDefault(const Constant('manual'))();
  TextColumn get merchant => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get tags => text().withDefault(const Constant('[]'))();
  TextColumn get refNumber => text().nullable()();
  BoolColumn get isRecurring => boolean().withDefault(const Constant(false))();
  TextColumn get recurringId => text().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class CategoriesTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get icon => text()();
  TextColumn get color => text()();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
  TextColumn get parentId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class BudgetsTable extends Table {
  TextColumn get id => text()();
  TextColumn get categoryId => text()();
  IntColumn get month => integer()();
  RealColumn get amount => real()();
  RealColumn get spent => real().withDefault(const Constant(0.0))();
  RealColumn get alertAt => real().withDefault(const Constant(0.9))();

  @override
  Set<Column> get primaryKey => {id};
}

class SavingsGoalsTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get target => real()();
  RealColumn get current => real().withDefault(const Constant(0.0))();
  DateTimeColumn get deadline => dateTime().nullable()();
  TextColumn get color => text()();
  TextColumn get icon => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class MerchantMappingsTable extends Table {
  TextColumn get merchantKey => text()();
  TextColumn get categoryId => text()();
  BoolColumn get userDefined => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {merchantKey};
}

class UserProfileTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  RealColumn get monthlySalary => real().withDefault(const Constant(0.0))();
  IntColumn get salaryDate => integer().nullable()();
  IntColumn get salaryDateEnd => integer().nullable()();
  TextColumn get salaryCreditor => text().nullable()();
  TextColumn get currency => text().withDefault(const Constant('INR'))();
  BoolColumn get onboardingComplete => boolean().withDefault(const Constant(false))();
  BoolColumn get biometricEnabled => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class AiInsightsTable extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get content => text()();
  DateTimeColumn get generatedAt => dateTime()();
  BoolColumn get dismissed => boolean().withDefault(const Constant(false))();
  TextColumn get categoryId => text().nullable()();
  TextColumn get metadata => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── Database ──────────────────────────────────────────────────────────────

@DriftDatabase(tables: [
  TransactionsTable,
  CategoriesTable,
  BudgetsTable,
  SavingsGoalsTable,
  MerchantMappingsTable,
  UserProfileTable,
  AiInsightsTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedDefaultCategories();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(
              userProfileTable,
              userProfileTable.salaryDateEnd,
            );
            await m.addColumn(
              userProfileTable,
              userProfileTable.salaryCreditor,
            );
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'expense_tracker');
  }

  Future<void> _seedDefaultCategories() async {
    final defaults = [
      CategoriesTableCompanion.insert(
        id: 'cat_food', name: 'Food & Dining',
        icon: 'restaurant', color: '#FF6B6B',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat_transport', name: 'Transport',
        icon: 'directions_car', color: '#4ECDC4',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat_shopping', name: 'Shopping',
        icon: 'shopping_bag', color: '#45B7D1',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat_entertainment', name: 'Entertainment',
        icon: 'movie', color: '#96CEB4',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat_health', name: 'Health & Medical',
        icon: 'local_hospital', color: '#FF9FF3',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat_utilities', name: 'Utilities',
        icon: 'bolt', color: '#FFEAA7',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat_rent', name: 'Rent',
        icon: 'home', color: '#DFE6E9',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat_emi', name: 'EMI & Loans',
        icon: 'account_balance', color: '#A29BFE',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat_salary', name: 'Salary',
        icon: 'payments', color: '#00B894',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat_savings', name: 'Savings',
        icon: 'savings', color: '#00CEC9',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat_subscription', name: 'Subscriptions',
        icon: 'subscriptions', color: '#E17055',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat_travel', name: 'Travel',
        icon: 'flight', color: '#74B9FF',
      ),
      CategoriesTableCompanion.insert(
        id: 'cat_other', name: 'Other',
        icon: 'category', color: '#B2BEC3',
      ),
    ];
    await batch((b) => b.insertAll(categoriesTable, defaults));
  }
}
