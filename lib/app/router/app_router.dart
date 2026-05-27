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

// ── Transition helper ─────────────────────────────────────────────────────────

Page<T> _slidePage<T>(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offset = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

      final fade = Tween<double>(begin: 0.0, end: 1.0)
          .animate(CurvedAnimation(parent: animation, curve: const Interval(0.0, 0.6)));

      return FadeTransition(
        opacity: fade,
        child: SlideTransition(position: offset, child: child),
      );
    },
  );
}

Page<T> _fadePage<T>(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, _, child) => FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
      child: child,
    ),
  );
}

// ── Shell with bottom nav ─────────────────────────────────────────────────────

class _MainShell extends StatelessWidget {
  final Widget child;
  const _MainShell({required this.child});

  static const _tabs = [
    (icon: Icons.home_outlined,                 activeIcon: Icons.home_rounded,                label: 'Home',     path: '/home'),
    (icon: Icons.bar_chart_outlined,            activeIcon: Icons.bar_chart_rounded,           label: 'Analytics',path: '/analytics'),
    (icon: Icons.auto_awesome_outlined,         activeIcon: Icons.auto_awesome,                label: 'AI',       path: '/ai-chat'),
    (icon: Icons.account_balance_wallet_outlined,activeIcon: Icons.account_balance_wallet_rounded,label: 'Budgets', path: '/budgets'),
    (icon: Icons.settings_outlined,             activeIcon: Icons.settings_rounded,            label: 'Settings', path: '/settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).matchedLocation;
    final idx = () {
      final i = _tabs.indexWhere((t) => loc.startsWith(t.path));
      return i < 0 ? 0 : i;
    }();

    return Scaffold(
      backgroundColor: AppColors.amoledBackground,
      body: child,
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColors.surfaceDark,
        indicatorColor: AppColors.accentPurple.withValues(alpha: 0.2),
        selectedIndex: idx,
        animationDuration: const Duration(milliseconds: 300),
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

// ── Placeholder ───────────────────────────────────────────────────────────────

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

// ── Router provider ───────────────────────────────────────────────────────────

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
        if (loc == AppConstants.routeSplash || loc == AppConstants.routeAuth) return null;
        return AppConstants.routeAuth;
      }
      if (authState.valueOrNull != null && loc == AppConstants.routeAuth) {
        return AppConstants.routeOnboarding;
      }
      if (loc == AppConstants.routeSplash) return AppConstants.routeHome;
      return null;
    },
    routes: [
      // ── Auth flow (fade transitions) ───────────────────────────────────
      GoRoute(
        path: AppConstants.routeSplash,
        pageBuilder: (c, s) => _fadePage(c, s, const SplashScreen()),
      ),
      GoRoute(
        path: AppConstants.routeAuth,
        pageBuilder: (c, s) => _fadePage(c, s, const AuthScreen()),
      ),
      GoRoute(
        path: AppConstants.routeOnboarding,
        pageBuilder: (c, s) => _slidePage(c, s, const OnboardingScreen()),
      ),

      // ── Push screens (slide-in transitions) ───────────────────────────
      GoRoute(
        path: AppConstants.routeAddTransaction,
        pageBuilder: (c, s) => _slidePage(c, s, const AddEditTransactionScreen()),
      ),
      GoRoute(
        path: AppConstants.routeEditTransaction,
        pageBuilder: (c, s) => _slidePage(
            c, s, AddEditTransactionScreen(existing: s.extra as Transaction?)),
      ),
      GoRoute(
        path: AppConstants.routeTransactions,
        pageBuilder: (c, s) => _slidePage(c, s, const TransactionListScreen()),
      ),
      GoRoute(
        path: AppConstants.routeSavingsGoals,
        pageBuilder: (c, s) => _slidePage(c, s, const SavingsGoalsScreen()),
      ),
      GoRoute(
        path: AppConstants.routePrivacyDashboard,
        pageBuilder: (c, s) =>
            _slidePage(c, s, const _PlaceholderScreen('Privacy Dashboard')),
      ),
      GoRoute(
        path: AppConstants.routeProfile,
        pageBuilder: (c, s) =>
            _slidePage(c, s, const _PlaceholderScreen('Profile')),
      ),
      GoRoute(
        path: AppConstants.routeSmsReview,
        pageBuilder: (c, s) =>
            _slidePage(c, s, const _PlaceholderScreen('SMS Import Review')),
      ),

      // ── Main shell with bottom nav (fade between tabs) ─────────────────
      ShellRoute(
        builder: (_, __, child) => _MainShell(child: child),
        routes: [
          GoRoute(
            path: AppConstants.routeHome,
            pageBuilder: (c, s) => _fadePage(c, s, const Home()),
          ),
          GoRoute(
            path: AppConstants.routeAnalytics,
            pageBuilder: (c, s) => _fadePage(c, s, const AnalyticsScreen()),
          ),
          GoRoute(
            path: AppConstants.routeAiChat,
            pageBuilder: (c, s) => _fadePage(c, s, const AiChatScreen()),
          ),
          GoRoute(
            path: AppConstants.routeBudgets,
            pageBuilder: (c, s) => _fadePage(c, s, const BudgetScreen()),
          ),
          GoRoute(
            path: AppConstants.routeSettings,
            pageBuilder: (c, s) => _fadePage(c, s, const SettingsScreen()),
          ),
        ],
      ),
    ],
  );
});

class AppRouter {
  static GoRouter of(WidgetRef ref) => ref.watch(appRouterProvider);
}
