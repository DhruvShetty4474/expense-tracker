import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../app/di/providers.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/animated_background.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/onboarding_provider.dart';

// ── Step metadata ──────────────────────────────────────────────────────────

const _steps = [
  (icon: Icons.person_rounded,       title: 'About You',       color: AppColors.accentPurple),
  (icon: Icons.receipt_long_rounded, title: 'EMIs',            color: Color(0xFFFF6B6B)),
  (icon: Icons.savings_rounded,      title: 'Goals',           color: AppColors.accentGreen),
  (icon: Icons.account_balance_wallet_rounded, title: 'Budgets', color: Color(0xFFFFD740)),
  (icon: Icons.security_rounded,     title: 'Privacy',         color: AppColors.accentCyan),
];

// ── Main screen ────────────────────────────────────────────────────────────

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with TickerProviderStateMixin {
  late final PageController _page;
  late final AnimationController _iconCtrl;
  late final Animation<double> _iconAnim;

  @override
  void initState() {
    super.initState();
    _page = PageController();
    _iconCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _iconAnim = CurvedAnimation(parent: _iconCtrl, curve: Curves.elasticOut);
    _iconCtrl.forward();
  }

  @override
  void dispose() {
    _page.dispose();
    _iconCtrl.dispose();
    super.dispose();
  }

  void _animateIcon() {
    _iconCtrl.reset();
    _iconCtrl.forward();
  }

  Future<void> _next(int current) async {
    if (current < _steps.length - 1) {
      ref.read(onboardingProvider.notifier).nextStep();
      _animateIcon();
      _page.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      final db = ref.read(databaseProvider);
      final user = ref.read(currentUserProvider);
      await ref.read(onboardingProvider.notifier).complete(db, user?.uid ?? 'guest');
      if (mounted) context.go(AppConstants.routeHome);
    }
  }

  void _back(int current) {
    if (current > 0) {
      ref.read(onboardingProvider.notifier).prevStep();
      _animateIcon();
      _page.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(onboardingProvider);
    final step = data.currentStep;
    final stepMeta = _steps[step];
    return Scaffold(
      backgroundColor: AppColors.amoledBackground,
      body: AnimatedBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),

              // ── Logo row ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.accentPurple, AppColors.accentCyan],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.auto_graph_rounded,
                          color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text('FinAI',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    const Spacer(),
                    Text('${step + 1} / ${_steps.length}',
                        style: const TextStyle(
                            color: Colors.white38, fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ── Step indicator bar ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: List.generate(_steps.length, (i) {
                    final done = i <= step;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: i < _steps.length - 1 ? 6 : 0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: done
                                ? stepMeta.color
                                : Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 28),

              // ── Animated step icon ────────────────────────────────────
              ScaleTransition(
                scale: _iconAnim,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey(step),
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          stepMeta.color.withValues(alpha: 0.3),
                          stepMeta.color.withValues(alpha: 0.05),
                        ],
                      ),
                      border: Border.all(
                          color: stepMeta.color.withValues(alpha: 0.4), width: 1.5),
                    ),
                    child: Icon(stepMeta.icon, color: stepMeta.color, size: 40),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ── Step title ────────────────────────────────────────────
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Text(
                  key: ValueKey('title_$step'),
                  stepMeta.title,
                  style: TextStyle(
                    color: stepMeta.color,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 4),

              // ── Page content (non-scrollable header handled above) ────
              Expanded(
                child: PageView(
                  controller: _page,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    _StepSalary(),
                    _StepEmi(),
                    _StepGoals(),
                    _StepBudgets(),
                    _StepPermissions(),
                  ],
                ),
              ),

              // ── Navigation buttons ────────────────────────────────────
              _NavRow(
                step: step,
                stepColor: stepMeta.color,
                onBack: () => _back(step),
                onNext: () => _next(step),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Nav row ────────────────────────────────────────────────────────────────

class _NavRow extends StatelessWidget {
  final int step;
  final Color stepColor;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const _NavRow({
    required this.step,
    required this.stepColor,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final isLast = step == _steps.length - 1;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
      child: Row(
        children: [
          AnimatedOpacity(
            opacity: step > 0 ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: GlassCard(
              onTap: step > 0 ? onBack : null,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              borderRadius: 14,
              child: const Row(
                children: [
                  Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white54, size: 16),
                  SizedBox(width: 6),
                  Text('Back', style: TextStyle(color: Colors.white54, fontSize: 14)),
                ],
              ),
            ),
          ),
          if (step > 0) const SizedBox(width: 12),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [stepColor, stepColor.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: stepColor.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onNext,
                  borderRadius: BorderRadius.circular(14),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isLast ? 'Get Started' : 'Continue',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isLast ? Icons.rocket_launch_rounded : Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
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

// ── Step wrapper ───────────────────────────────────────────────────────────

class _StepWrapper extends StatelessWidget {
  final String headline;
  final String sub;
  final Widget child;
  const _StepWrapper({required this.headline, required this.sub, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(headline,
              style: const TextStyle(
                  color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(sub,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.45), fontSize: 13)),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

// ── Shared glass field ─────────────────────────────────────────────────────

class _GlassField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  const _GlassField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white38, fontSize: 13),
        prefixIcon: Icon(icon, color: Colors.white38, size: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accentPurple, width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.06),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

// ── Step 1: Salary ─────────────────────────────────────────────────────────

class _StepSalary extends ConsumerStatefulWidget {
  const _StepSalary();

  @override
  ConsumerState<_StepSalary> createState() => _StepSalaryState();
}

class _StepSalaryState extends ConsumerState<_StepSalary> {
  final _nameCtrl = TextEditingController();
  final _salaryCtrl = TextEditingController();
  int _salaryDate = 1;

  @override
  void initState() {
    super.initState();
    final d = ref.read(onboardingProvider);
    _nameCtrl.text = d.name;
    _salaryCtrl.text = d.monthlySalary > 0 ? d.monthlySalary.toStringAsFixed(0) : '';
    _salaryDate = d.salaryDate;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _salaryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final n = ref.read(onboardingProvider.notifier);
    return _StepWrapper(
      headline: 'Tell us about you',
      sub: 'FinAI personalises insights based on your income.',
      child: Column(
        children: [
          _GlassField(controller: _nameCtrl, label: 'Your name', icon: Icons.person_outline, onChanged: n.setName),
          const SizedBox(height: 14),
          _GlassField(
            controller: _salaryCtrl,
            label: 'Monthly take-home (₹)',
            icon: Icons.payments_outlined,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (v) => n.setSalary(double.tryParse(v) ?? 0),
          ),
          const SizedBox(height: 14),
          GlassCard(
            padding: const EdgeInsets.all(16),
            borderRadius: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Salary credited on day',
                    style: TextStyle(color: Colors.white54, fontSize: 13)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [1, 5, 10, 15, 20, 25, 28, 30, 31].map((day) {
                    final sel = _salaryDate == day;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _salaryDate = day);
                        n.setSalaryDate(day);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 46,
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: sel
                              ? AppColors.accentPurple
                              : Colors.white.withValues(alpha: 0.07),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: sel
                                ? AppColors.accentPurple
                                : Colors.white.withValues(alpha: 0.1),
                          ),
                          boxShadow: sel
                              ? [BoxShadow(color: AppColors.accentPurple.withValues(alpha: 0.4), blurRadius: 10)]
                              : null,
                        ),
                        child: Text('$day',
                            style: TextStyle(
                                color: sel ? Colors.white : Colors.white54,
                                fontWeight: sel ? FontWeight.bold : FontWeight.normal,
                                fontSize: 13)),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Step 2: EMIs ───────────────────────────────────────────────────────────

class _StepEmi extends ConsumerStatefulWidget {
  const _StepEmi();

  @override
  ConsumerState<_StepEmi> createState() => _StepEmiState();
}

class _StepEmiState extends ConsumerState<_StepEmi> {
  final _nameCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  int _dueDay = 1;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  void _add() {
    final name = _nameCtrl.text.trim();
    final amount = double.tryParse(_amountCtrl.text) ?? 0;
    if (name.isEmpty || amount <= 0) return;
    ref.read(onboardingProvider.notifier).addEmi(EmiEntry(name: name, amount: amount, dueDateOfMonth: _dueDay));
    _nameCtrl.clear();
    _amountCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(onboardingProvider).emiEntries;
    final n = ref.read(onboardingProvider.notifier);

    return _StepWrapper(
      headline: 'Recurring Expenses',
      sub: 'Loans, subscriptions, or any fixed monthly cost.',
      child: Column(
        children: [
          GlassCard(
            padding: const EdgeInsets.all(16),
            borderRadius: 14,
            child: Column(
              children: [
                _GlassField(controller: _nameCtrl, label: 'Name (e.g. Home Loan)', icon: Icons.label_outline),
                const SizedBox(height: 12),
                _GlassField(
                  controller: _amountCtrl,
                  label: 'Monthly amount (₹)',
                  icon: Icons.currency_rupee,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Due on day:', style: TextStyle(color: Colors.white54, fontSize: 13)),
                    const SizedBox(width: 12),
                    DropdownButton<int>(
                      value: _dueDay,
                      dropdownColor: AppColors.cardDark,
                      style: const TextStyle(color: Colors.white),
                      underline: const SizedBox.shrink(),
                      items: List.generate(28, (i) => DropdownMenuItem(value: i + 1, child: Text('${i + 1}'))),
                      onChanged: (v) => setState(() => _dueDay = v!),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _add,
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: const Text('Add EMI'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFFF6B6B),
                      side: const BorderSide(color: Color(0xFFFF6B6B)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ...entries.asMap().entries.map((e) => _EmiTile(entry: e.value, onRemove: () => n.removeEmi(e.key))),
          if (entries.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('Skip if you have no fixed expenses.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 13)),
            ),
        ],
      ),
    );
  }
}

class _EmiTile extends StatelessWidget {
  final EmiEntry entry;
  final VoidCallback onRemove;
  const _EmiTile({required this.entry, required this.onRemove});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          borderRadius: 12,
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B6B).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.account_balance, color: Color(0xFFFF6B6B), size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14)),
                    Text('₹${entry.amount.toStringAsFixed(0)} · due day ${entry.dueDateOfMonth}',
                        style: const TextStyle(color: Colors.white38, fontSize: 12)),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.delete_outline, color: Colors.white24, size: 20), onPressed: onRemove),
            ],
          ),
        ),
      );
}

// ── Step 3: Goals ──────────────────────────────────────────────────────────

class _StepGoals extends ConsumerStatefulWidget {
  const _StepGoals();

  @override
  ConsumerState<_StepGoals> createState() => _StepGoalsState();
}

class _StepGoalsState extends ConsumerState<_StepGoals> {
  final _nameCtrl = TextEditingController();
  final _targetCtrl = TextEditingController();
  String _color = '#00E676';

  static const _palette = [
    '#00E676', '#7C4DFF', '#00E5FF', '#FFD740',
    '#FF6B6B', '#4ECDC4', '#FF9800', '#E91E63',
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _targetCtrl.dispose();
    super.dispose();
  }

  void _add() {
    final name = _nameCtrl.text.trim();
    final target = double.tryParse(_targetCtrl.text) ?? 0;
    if (name.isEmpty || target <= 0) return;
    ref.read(onboardingProvider.notifier).addGoal(GoalEntry(name: name, target: target, color: _color));
    _nameCtrl.clear();
    _targetCtrl.clear();
  }

  Color _toColor(String hex) =>
      Color(int.parse('FF${hex.replaceFirst('#', '')}', radix: 16));

  @override
  Widget build(BuildContext context) {
    final goals = ref.watch(onboardingProvider).goalEntries;
    final n = ref.read(onboardingProvider.notifier);

    return _StepWrapper(
      headline: 'Savings Goals',
      sub: 'What are you saving for? FinAI tracks your progress.',
      child: Column(
        children: [
          GlassCard(
            padding: const EdgeInsets.all(16),
            borderRadius: 14,
            child: Column(
              children: [
                _GlassField(controller: _nameCtrl, label: 'Goal name (e.g. Emergency Fund)', icon: Icons.flag_outlined),
                const SizedBox(height: 12),
                _GlassField(
                  controller: _targetCtrl,
                  label: 'Target amount (₹)',
                  icon: Icons.savings_outlined,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 14),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Pick a colour', style: TextStyle(color: Colors.white38, fontSize: 12)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: _palette.map((c) {
                    final selected = _color == c;
                    return GestureDetector(
                      onTap: () => setState(() => _color = c),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        width: selected ? 32 : 26,
                        height: selected ? 32 : 26,
                        decoration: BoxDecoration(
                          color: _toColor(c),
                          shape: BoxShape.circle,
                          border: selected ? Border.all(color: Colors.white, width: 2) : null,
                          boxShadow: selected
                              ? [BoxShadow(color: _toColor(c).withValues(alpha: 0.6), blurRadius: 12)]
                              : null,
                        ),
                        child: selected
                            ? const Icon(Icons.check, color: Colors.white, size: 14)
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _add,
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: const Text('Add Goal'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.accentGreen,
                      side: const BorderSide(color: AppColors.accentGreen),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ...goals.asMap().entries.map((e) {
            final color = _toColor(e.value.color);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                borderRadius: 12,
                child: Row(
                  children: [
                    Container(
                      width: 12, height: 12,
                      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.value.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                          Text('₹${e.value.target.toStringAsFixed(0)}',
                              style: const TextStyle(color: Colors.white38, fontSize: 12)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.white24, size: 20),
                      onPressed: () => n.removeGoal(e.key),
                    ),
                  ],
                ),
              ),
            );
          }),
          if (goals.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('Skip for now — you can add goals later.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 13)),
            ),
        ],
      ),
    );
  }
}

// ── Step 4: Budgets ────────────────────────────────────────────────────────

class _StepBudgets extends ConsumerWidget {
  const _StepBudgets();

  static const _cats = [
    (id: 'cat_food',          label: 'Food & Dining',  icon: Icons.restaurant,     color: Color(0xFFFF9800)),
    (id: 'cat_transport',     label: 'Transport',      icon: Icons.directions_car, color: Color(0xFF2196F3)),
    (id: 'cat_shopping',      label: 'Shopping',       icon: Icons.shopping_bag,   color: Color(0xFFE91E63)),
    (id: 'cat_entertainment', label: 'Entertainment',  icon: Icons.movie,          color: Color(0xFF9C27B0)),
    (id: 'cat_health',        label: 'Health',         icon: Icons.local_hospital, color: Color(0xFF4CAF50)),
    (id: 'cat_utilities',     label: 'Utilities',      icon: Icons.bolt,           color: Color(0xFFFFD740)),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgets = ref.watch(onboardingProvider.select((d) => d.categoryBudgets));
    final n = ref.read(onboardingProvider.notifier);

    return _StepWrapper(
      headline: 'Monthly Budgets',
      sub: 'Set limits per category — optional, adjust anytime.',
      child: Column(
        children: _cats.map((cat) => _BudgetRow(
          id: cat.id, label: cat.label, icon: cat.icon,
          color: cat.color,
          value: budgets[cat.id] ?? 0,
          onChanged: (v) => n.setCategoryBudget(cat.id, v),
        )).toList(),
      ),
    );
  }
}

class _BudgetRow extends StatefulWidget {
  final String id;
  final String label;
  final IconData icon;
  final Color color;
  final double value;
  final ValueChanged<double> onChanged;

  const _BudgetRow({
    required this.id, required this.label, required this.icon,
    required this.color, required this.value, required this.onChanged,
  });

  @override
  State<_BudgetRow> createState() => _BudgetRowState();
}

class _BudgetRowState extends State<_BudgetRow> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.value > 0 ? widget.value.toStringAsFixed(0) : '');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        borderRadius: 12,
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: widget.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(widget.icon, color: widget.color, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(widget.label, style: const TextStyle(color: Colors.white, fontSize: 13))),
            SizedBox(
              width: 96,
              child: TextField(
                controller: _ctrl,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  isDense: true,
                  prefixText: '₹',
                  prefixStyle: const TextStyle(color: Colors.white38, fontSize: 14),
                  hintText: '—',
                  hintStyle: const TextStyle(color: Colors.white24),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: widget.color, width: 1.5),
                  ),
                  filled: true,
                  fillColor: widget.color.withValues(alpha: 0.07),
                ),
                onChanged: (v) => widget.onChanged(double.tryParse(v) ?? 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Step 5: Privacy ────────────────────────────────────────────────────────

class _StepPermissions extends ConsumerWidget {
  const _StepPermissions();

  static const _points = [
    (icon: Icons.phone_android_rounded,   text: 'SMS parsed locally — never leaves your device'),
    (icon: Icons.block_rounded,           text: 'OTPs and personal messages are ignored'),
    (icon: Icons.cloud_off_rounded,       text: 'Raw SMS is never sent to any server'),
    (icon: Icons.data_object_rounded,     text: 'Only structured transaction data is stored'),
    (icon: Icons.delete_forever_rounded,  text: 'Delete all data anytime from Settings'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final granted = ref.watch(onboardingProvider.select((d) => d.smsPermissionGranted));

    return _StepWrapper(
      headline: 'Your privacy first',
      sub: 'FinAI reads SMS locally to auto-detect transactions.',
      child: Column(
        children: [
          GlassCard(
            padding: const EdgeInsets.all(20),
            borderRadius: 16,
            child: Column(
              children: [
                ..._points.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    children: [
                      Container(
                        width: 34, height: 34,
                        decoration: BoxDecoration(
                          color: AppColors.accentCyan.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(p.icon, color: AppColors.accentCyan, size: 18),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(p.text, style: const TextStyle(color: Colors.white70, fontSize: 13))),
                    ],
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: granted
                ? GlassCard(
                    key: const ValueKey('granted'),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    borderRadius: 14,
                    borderColor: AppColors.accentGreen.withValues(alpha: 0.4),
                    child: Row(
                      children: [
                        Container(
                          width: 36, height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.accentGreen.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check_rounded, color: AppColors.accentGreen, size: 20),
                        ),
                        const SizedBox(width: 12),
                        const Text('SMS access granted',
                            style: TextStyle(color: AppColors.accentGreen, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  )
                : SizedBox(
                    key: const ValueKey('request'),
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final status = await Permission.sms.request();
                        ref.read(onboardingProvider.notifier).setSmsPermission(status.isGranted);
                      },
                      icon: const Icon(Icons.sms_outlined, size: 20),
                      label: const Text('Grant SMS Access', style: TextStyle(fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentCyan,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => ref.read(onboardingProvider.notifier).setSmsPermission(false),
            child: Text(
              'Skip — I\'ll add transactions manually',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
