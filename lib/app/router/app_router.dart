import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../features/ai_assistant/presentation/screens/ai_chat_screen.dart';
import '../../features/analytics/presentation/screens/analytics_screen.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/budgets/presentation/screens/budget_screen.dart';
import '../../features/home/screens/home.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/savings/presentation/screens/savings_goals_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/transactions/presentation/screens/add_edit_transaction_screen.dart';
import '../../features/transactions/presentation/screens/transaction_list_screen.dart';
import '../../shared/models/transaction.dart';

// ── Bottom-nav shell ─────────────────────────────────────────────────────────

class _MainShell extends StatelessWidget {
  final Widget child;
  const _MainShell({required this.child});

  static const _tabs = [
    (icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home', path: '/home'),
    (icon: Icons.bar_chart_outlined, activeIcon: Icons.bar_chart, label: 'Analytics', path: '/analytics'),
    (icon: Icons.auto_awesome_outlined, activeIcon: Icons.auto_awesome, label: 'AI', path: '/ai-chat'),
    (icon: Icons.account_balance_wallet_outlined, activeIcon: Icons.account_balance_wallet, label: 'Budgets', path: '/budgets'),
    (icon: Icons.settings_outlined, activeIcon: Icons.settings, label: 'Settings', path: '/settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex =
        _tabs.indexWhere((t) => location.startsWith(t.path));
    final idx = currentIndex < 0 ? 0 : currentIndex;

    return Scaffold(
      backgroundColor: AppColors.amoledBackground,
      body: child,
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColors.surfaceDark,
        indicatorColor: AppColors.accentPurple.withValues(alpha: 0.2),
        selectedIndex: idx,
        onDestinationSelected: (i) => context.go(_tabs[i].path),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: _tabs
            .map((t) => NavigationDestination(
                  icon: Icon(t.icon, color: Colors.white38),
                  selectedIcon: Icon(t.activeIcon, color: AppColors.accentPurple),
                  label: t.label,
                ))
            .toList(),
      ),
    );
  }
}

// ── Placeholder ──────────────────────────────────────────────────────────────

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.amoledBackground,
        appBar: AppBar(
          backgroundColor: AppColors.surfaceDark,
          foregroundColor: Colors.white,
          title: Text(title),
        ),
        body: Center(
          child: Text(title,
              style: const TextStyle(color: Colors.white54, fontSize: 18)),
        ),
      );
}

// ── Router provider ──────────────────────────────────────────────────────────

final appRouterProvider = Provider<GoRouter>((ref) {
  final authNotifier = ValueNotifier<bool>(false);
  ref.listen(authProvider, (_, __) => authNotifier.value = !authNotifier.value);

  return GoRouter(
    initialLocation: AppConstants.routeSplash,
    refreshListenable: authNotifier,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoading = authState.isLoading;
      final isAuthenticated = authState.valueOrNull != null;
      final loc = state.matchedLocation;

      if (isLoading) {
        return loc == AppConstants.routeSplash ? null : AppConstants.routeSplash;
      }
      if (!isAuthenticated) {
        if (loc == AppConstants.routeSplash || loc == AppConstants.routeAuth) {
          return null;
        }
        return AppConstants.routeAuth;
      }
      if (authState.valueOrNull != null && loc == AppConstants.routeAuth) {
        return AppConstants.routeOnboarding;
      }
      if (loc == AppConstants.routeSplash) return AppConstants.routeHome;
      return null;
    },
    routes: [
      GoRoute(
        path: AppConstants.routeSplash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppConstants.routeAuth,
        builder: (_, __) => const AuthScreen(),
      ),
      GoRoute(
        path: AppConstants.routeOnboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),
      // Transaction push routes (no bottom nav)
      GoRoute(
        path: AppConstants.routeAddTransaction,
        builder: (_, __) => const AddEditTransactionScreen(),
      ),
      GoRoute(
        path: AppConstants.routeEditTransaction,
        builder: (_, state) =>
            AddEditTransactionScreen(existing: state.extra as Transaction?),
      ),
      GoRoute(
        path: AppConstants.routeTransactions,
        builder: (_, __) => const TransactionListScreen(),
      ),
      GoRoute(
        path: AppConstants.routeSavingsGoals,
        builder: (_, __) => const SavingsGoalsScreen(),
      ),
      GoRoute(
        path: AppConstants.routePrivacyDashboard,
        builder: (_, __) => const _PlaceholderScreen('Privacy Dashboard'),
      ),
      GoRoute(
        path: AppConstants.routeProfile,
        builder: (_, __) => const _PlaceholderScreen('Profile'),
      ),
      GoRoute(
        path: AppConstants.routeSmsReview,
        builder: (_, __) => const _PlaceholderScreen('SMS Import Review'),
      ),
      // Main shell — tabs with bottom nav
      ShellRoute(
        builder: (_, __, child) => _MainShell(child: child),
        routes: [
          GoRoute(
            path: AppConstants.routeHome,
            builder: (_, __) => const Home(),
          ),
          GoRoute(
            path: AppConstants.routeAnalytics,
            builder: (_, __) => const AnalyticsScreen(),
          ),
          GoRoute(
            path: AppConstants.routeAiChat,
            builder: (_, __) => const AiChatScreen(),
          ),
          GoRoute(
            path: AppConstants.routeBudgets,
            builder: (_, __) => const BudgetScreen(),
          ),
          GoRoute(
            path: AppConstants.routeSettings,
            builder: (_, __) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
});

class AppRouter {
  static GoRouter of(WidgetRef ref) => ref.watch(appRouterProvider);
}
