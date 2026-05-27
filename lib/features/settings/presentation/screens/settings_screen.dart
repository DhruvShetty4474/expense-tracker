import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/animated_background.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.amoledBackground,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: Colors.white,
        title: const Text('Settings'),
      ),
      body: AnimatedBackground(
        child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile card
          GlassCard(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.accentPurple.withValues(alpha: 0.2),
                  radius: 28,
                  child: Text(
                    user?.displayName?.substring(0, 1).toUpperCase() ?? '?',
                    style: const TextStyle(
                        color: AppColors.accentPurple,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.displayName ?? 'Guest',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        user?.email ?? 'Guest mode',
                        style: const TextStyle(color: Colors.white54, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SectionHeader('Data & Privacy'),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Dashboard',
            subtitle: 'View, export or delete your data',
            onTap: () => context.push(AppConstants.routePrivacyDashboard),
          ),
          _SettingsTile(
            icon: Icons.ios_share_outlined,
            title: 'Export Data',
            subtitle: 'Download your transactions as CSV',
            onTap: () => _showComingSoon(context),
          ),
          const SizedBox(height: 16),
          _SectionHeader('About'),
          _SettingsTile(
            icon: Icons.info_outline,
            title: 'App Version',
            subtitle: '1.0.0',
            onTap: null,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                await ref.read(authProvider.notifier).signOut();
                if (context.mounted) context.go(AppConstants.routeAuth);
              },
              icon: const Icon(Icons.logout, color: AppColors.expense),
              label: const Text('Sign Out',
                  style: TextStyle(color: AppColors.expense)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.expense),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Coming soon'),
        backgroundColor: Color(0xFF111111),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      );
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: AppColors.accentPurple, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14)),
                Text(subtitle,
                    style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          if (onTap != null)
            const Icon(Icons.chevron_right, color: Colors.white38, size: 20),
        ],
      ),
    );
  }
}
