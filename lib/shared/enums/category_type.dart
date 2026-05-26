enum CategoryType {
  food,
  transport,
  shopping,
  entertainment,
  health,
  utilities,
  rent,
  emi,
  savings,
  salary,
  investment,
  education,
  travel,
  subscription,
  other;

  String get displayName {
    switch (this) {
      case CategoryType.food: return 'Food & Dining';
      case CategoryType.transport: return 'Transport';
      case CategoryType.shopping: return 'Shopping';
      case CategoryType.entertainment: return 'Entertainment';
      case CategoryType.health: return 'Health & Medical';
      case CategoryType.utilities: return 'Utilities';
      case CategoryType.rent: return 'Rent';
      case CategoryType.emi: return 'EMI & Loans';
      case CategoryType.savings: return 'Savings';
      case CategoryType.salary: return 'Salary';
      case CategoryType.investment: return 'Investment';
      case CategoryType.education: return 'Education';
      case CategoryType.travel: return 'Travel';
      case CategoryType.subscription: return 'Subscriptions';
      case CategoryType.other: return 'Other';
    }
  }

  String get iconName {
    switch (this) {
      case CategoryType.food: return 'restaurant';
      case CategoryType.transport: return 'directions_car';
      case CategoryType.shopping: return 'shopping_bag';
      case CategoryType.entertainment: return 'movie';
      case CategoryType.health: return 'local_hospital';
      case CategoryType.utilities: return 'bolt';
      case CategoryType.rent: return 'home';
      case CategoryType.emi: return 'account_balance';
      case CategoryType.savings: return 'savings';
      case CategoryType.salary: return 'payments';
      case CategoryType.investment: return 'trending_up';
      case CategoryType.education: return 'school';
      case CategoryType.travel: return 'flight';
      case CategoryType.subscription: return 'subscriptions';
      case CategoryType.other: return 'category';
    }
  }
}
