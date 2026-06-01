import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../domain/entities/app_user.dart';
import '../providers/auth_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _slideAnim;
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _showEmailForm = false;
  bool _isSignUp = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _slideAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _handleAuthResult(AsyncValue<AppUser?> auth) {
    auth.whenOrNull(
      data: (user) {
        if (user != null) {
          context.go(user.isGuest
              ? AppConstants.routeOnboarding
              : AppConstants.routeHome);
        }
      },
      error: (e, _) {
        final msg = e.toString()
            .replaceAll('UnimplementedError: ', '')
            .replaceAll('StateError: ', '')
            .replaceAll('FirebaseAuthException: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: AppColors.error),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    ref.listen(authProvider, (_, next) => _handleAuthResult(next));

    return Scaffold(
      backgroundColor: AppColors.amoledBackground,
      body: Stack(
        children: [
          // Gradient background blobs
          _BackgroundBlobs(),
          SafeArea(
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.15),
                end: Offset.zero,
              ).animate(_slideAnim),
              child: FadeTransition(
                opacity: _slideAnim,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      _Logo(),
                      const SizedBox(height: 48),
                      Text(
                        'Welcome back',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to access your financial insights.',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 14),
                      ),
                      const SizedBox(height: 40),

                      // Google sign-in
                      _AuthButton(
                        onPressed: isLoading
                            ? null
                            : () => ref
                                .read(authProvider.notifier)
                                .signInWithGoogle(),
                        icon: 'G',
                        label: 'Continue with Google',
                        isOutlined: true,
                      ),
                      const SizedBox(height: 12),

                      // Email toggle
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: _showEmailForm
                            ? _EmailForm(
                                emailCtrl: _emailCtrl,
                                passwordCtrl: _passwordCtrl,
                                obscurePassword: _obscurePassword,
                                isSignUp: _isSignUp,
                                onToggleMode: () =>
                                    setState(() => _isSignUp = !_isSignUp),
                                onTogglePassword: () => setState(
                                    () => _obscurePassword = !_obscurePassword),
                                onSubmit: isLoading
                                    ? null
                                    : () {
                                        final email = _emailCtrl.text.trim();
                                        final pass = _passwordCtrl.text;
                                        final n = ref.read(authProvider.notifier);
                                        if (_isSignUp) {
                                          n.signUpWithEmail(email, pass);
                                        } else {
                                          n.signInWithEmail(email, pass);
                                        }
                                      },
                              )
                            : _AuthButton(
                                onPressed: () =>
                                    setState(() => _showEmailForm = true),
                                icon: '✉',
                                label: 'Continue with Email',
                                isOutlined: true,
                              ),
                      ),

                      const SizedBox(height: 24),
                      const _Divider(),
                      const SizedBox(height: 24),

                      // Guest mode
                      _AuthButton(
                        onPressed: isLoading
                            ? null
                            : () => ref
                                .read(authProvider.notifier)
                                .signInAsGuest(),
                        icon: '👤',
                        label: 'Continue as Guest',
                        isPrimary: true,
                      ),

                      const SizedBox(height: 32),
                      Center(
                        child: Text(
                          'Your data is private and stored securely on device.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.35),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      if (isLoading)
                        const Padding(
                          padding: EdgeInsets.only(top: 24),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Private sub-widgets ────────────────────────────────────────────────────

class _BackgroundBlobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -80,
          left: -60,
          child: _Blob(color: AppColors.accentPurple, size: 260),
        ),
        Positioned(
          bottom: 80,
          right: -80,
          child: _Blob(color: AppColors.accentCyan, size: 200),
        ),
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  final Color color;
  final double size;
  const _Blob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: 0.35), Colors.transparent],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.accentPurple, AppColors.accentCyan],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.auto_graph_rounded,
              color: Colors.white, size: 24),
        ),
        const SizedBox(width: 12),
        const Text(
          'FinAI',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _AuthButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String icon;
  final String label;
  final bool isOutlined;
  final bool isPrimary;

  const _AuthButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    this.isOutlined = false,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentPurple,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: Text('$icon  $label',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ),
      );
    }
    return GlassCard(
      onTap: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      borderRadius: 14,
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 16),
          Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _EmailForm extends StatelessWidget {
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final bool obscurePassword;
  final bool isSignUp;
  final VoidCallback onToggleMode;
  final VoidCallback onTogglePassword;
  final VoidCallback? onSubmit;

  const _EmailForm({
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.obscurePassword,
    required this.isSignUp,
    required this.onToggleMode,
    required this.onTogglePassword,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderRadius: 14,
      child: Column(
        children: [
          TextField(
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Email', Icons.email_outlined),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: passwordCtrl,
            obscureText: obscurePassword,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration(
              'Password',
              Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white54,
                ),
                onPressed: onTogglePassword,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(isSignUp ? 'Create Account' : 'Sign In',
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
          TextButton(
            onPressed: onToggleMode,
            child: Text(
              isSignUp
                  ? 'Already have an account? Sign in'
                  : 'New here? Create account',
              style: const TextStyle(color: AppColors.accentCyan, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon,
      {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: Colors.white54),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            const BorderSide(color: AppColors.accentPurple, width: 1.5),
      ),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.05),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(color: Colors.white.withValues(alpha: 0.15),
                thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('or',
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.35), fontSize: 13)),
        ),
        Expanded(
            child: Divider(color: Colors.white.withValues(alpha: 0.15),
                thickness: 1)),
      ],
    );
  }
}
