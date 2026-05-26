import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/database/app_database.dart';
import 'package:drift/drift.dart' hide Column, JsonKey;
import 'package:uuid/uuid.dart';

part 'onboarding_provider.freezed.dart';

// ── Onboarding state ──────────────────────────────────────────────────────

@freezed
class OnboardingData with _$OnboardingData {
  const factory OnboardingData({
    @Default(0) int currentStep,
    @Default('') String name,
    @Default(0.0) double monthlySalary,
    @Default(1) int salaryDate,
    @Default([]) List<EmiEntry> emiEntries,
    @Default([]) List<GoalEntry> goalEntries,
    @Default({}) Map<String, double> categoryBudgets,
    @Default(false) bool smsPermissionGranted,
  }) = _OnboardingData;
}

@freezed
class EmiEntry with _$EmiEntry {
  const factory EmiEntry({
    required String name,
    required double amount,
    required int dueDateOfMonth,
  }) = _EmiEntry;
}

@freezed
class GoalEntry with _$GoalEntry {
  const factory GoalEntry({
    required String name,
    required double target,
    required String color,
  }) = _GoalEntry;
}

// ── Notifier ──────────────────────────────────────────────────────────────

class OnboardingNotifier extends Notifier<OnboardingData> {
  @override
  OnboardingData build() => const OnboardingData();

  void nextStep() =>
      state = state.copyWith(currentStep: state.currentStep + 1);

  void prevStep() =>
      state = state.copyWith(currentStep: (state.currentStep - 1).clamp(0, 4));

  void setName(String name) => state = state.copyWith(name: name);

  void setSalary(double salary) =>
      state = state.copyWith(monthlySalary: salary);

  void setSalaryDate(int date) => state = state.copyWith(salaryDate: date);

  void addEmi(EmiEntry entry) =>
      state = state.copyWith(emiEntries: [...state.emiEntries, entry]);

  void removeEmi(int index) {
    final list = [...state.emiEntries];
    list.removeAt(index);
    state = state.copyWith(emiEntries: list);
  }

  void addGoal(GoalEntry entry) =>
      state = state.copyWith(goalEntries: [...state.goalEntries, entry]);

  void removeGoal(int index) {
    final list = [...state.goalEntries];
    list.removeAt(index);
    state = state.copyWith(goalEntries: list);
  }

  void setCategoryBudget(String categoryId, double amount) {
    final map = {...state.categoryBudgets, categoryId: amount};
    state = state.copyWith(categoryBudgets: map);
  }

  void setSmsPermission(bool granted) =>
      state = state.copyWith(smsPermissionGranted: granted);

  Future<void> complete(AppDatabase db, String userId) async {
    final uuid = const Uuid();
    final now = DateTime.now();
    final yyyymm = now.year * 100 + now.month;

    // Save user profile
    await db.into(db.userProfileTable).insertOnConflictUpdate(
          UserProfileTableCompanion.insert(
            id: userId,
            name: Value(state.name.isNotEmpty ? state.name : null),
            monthlySalary: Value(state.monthlySalary),
            salaryDate: Value(state.salaryDate),
            onboardingComplete: const Value(true),
          ),
        );

    // Save category budgets
    for (final entry in state.categoryBudgets.entries) {
      if (entry.value > 0) {
        await db.into(db.budgetsTable).insertOnConflictUpdate(
              BudgetsTableCompanion.insert(
                id: uuid.v4(),
                categoryId: entry.key,
                month: yyyymm,
                amount: entry.value,
              ),
            );
      }
    }

    // Save savings goals
    for (final goal in state.goalEntries) {
      await db.into(db.savingsGoalsTable).insertOnConflictUpdate(
            SavingsGoalsTableCompanion.insert(
              id: uuid.v4(),
              name: goal.name,
              target: goal.target,
              color: goal.color,
            ),
          );
    }
  }
}

final onboardingProvider =
    NotifierProvider<OnboardingNotifier, OnboardingData>(
  OnboardingNotifier.new,
);
