import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../shared/enums/transaction_type.dart';
import '../../../../shared/models/category.dart';
import '../../../../shared/models/transaction.dart';
import '../providers/transaction_providers.dart';

const _fallback = Category(
  id: 'cat_other',
  name: 'Other',
  icon: 'category',
  color: '#B2BEC3',
);

class TransactionTile extends ConsumerWidget {
  final Transaction transaction;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const TransactionTile({
    super.key,
    required this.transaction,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cats = ref.watch(categoriesProvider).valueOrNull ?? [];
    final cat = cats.firstWhere(
      (c) => c.id == transaction.categoryId,
      orElse: () => cats.isNotEmpty ? cats.first : _fallback,
    );

    final isDebit = transaction.type == TransactionType.debit;
    final color = _hexColor(cat.color);

    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.expense.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: AppColors.expense),
      ),
      onDismissed: (_) => onDelete?.call(),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_iconData(cat.icon), color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.merchant ?? cat.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      AppDateUtils.relativeLabel(transaction.timestamp),
                      style: const TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Text(
                '${isDebit ? '-' : '+'}${CurrencyFormatter.formatCompact(transaction.amount)}',
                style: TextStyle(
                  color: isDebit ? AppColors.expense : AppColors.income,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _hexColor(String hex) {
    try {
      return Color(int.parse('FF${hex.replaceFirst('#', '')}', radix: 16));
    } catch (_) {
      return AppColors.neutral;
    }
  }

  IconData _iconData(String name) {
    const map = <String, IconData>{
      'restaurant': Icons.restaurant,
      'directions_car': Icons.directions_car,
      'shopping_bag': Icons.shopping_bag,
      'movie': Icons.movie,
      'local_hospital': Icons.local_hospital,
      'bolt': Icons.bolt,
      'home': Icons.home,
      'account_balance': Icons.account_balance,
      'payments': Icons.payments,
      'savings': Icons.savings,
      'subscriptions': Icons.subscriptions,
      'flight': Icons.flight,
      'category': Icons.category,
      'trending_up': Icons.trending_up,
      'school': Icons.school,
    };
    return map[name] ?? Icons.receipt_long;
  }
}
