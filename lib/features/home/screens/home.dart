import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/animated_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../features/transactions/presentation/providers/transaction_providers.dart';
import '../../../features/transactions/presentation/widgets/transaction_tile.dart';

// ── Solo Leveling theme constants ─────────────────────────────────────────────
const _kBlue = AppColors.electricBlue;

// ─────────────────────────────────────────────────────────────────────────────
// Arc Painter
// ─────────────────────────────────────────────────────────────────────────────

class _ArcPainter extends CustomPainter {
  final double progress; // 0.0 → 1.0
  final bool isOver;

  const _ArcPainter({required this.progress, required this.isOver});

  static const double _startDeg = 145;
  static const double _sweepDeg = 250;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.52);
    final radius = math.min(size.width, size.height) * 0.43;
    final sw = size.width * 0.052;

    final startRad = _startDeg * math.pi / 180;
    final sweepRad = _sweepDeg * math.pi / 180;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final arcColor = isOver ? const Color(0xFFFF3355) : _kBlue;

    // Track ring
    canvas.drawArc(
      rect, startRad, sweepRad, false,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.05)
        ..strokeWidth = sw
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    // Subtle tick marks
    for (int i = 0; i <= 10; i++) {
      final angle = startRad + (sweepRad / 10) * i;
      final innerR = radius - sw * 0.5 - 4;
      final outerR = radius + sw * 0.5 + 4;
      canvas.drawLine(
        Offset(center.dx + innerR * math.cos(angle), center.dy + innerR * math.sin(angle)),
        Offset(center.dx + outerR * math.cos(angle), center.dy + outerR * math.sin(angle)),
        Paint()
          ..color = Colors.white.withValues(alpha: 0.05)
          ..strokeWidth = 1,
      );
    }

    if (progress <= 0) return;
    final clipped = progress.clamp(0.0, 1.0);
    final progressSweep = sweepRad * clipped;

    // Outer glow
    canvas.drawArc(
      rect, startRad, progressSweep, false,
      Paint()
        ..color = arcColor.withValues(alpha: 0.22)
        ..strokeWidth = sw + 12
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14),
    );

    // Mid glow
    canvas.drawArc(
      rect, startRad, progressSweep, false,
      Paint()
        ..color = arcColor.withValues(alpha: 0.45)
        ..strokeWidth = sw + 2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    // Main arc (solid)
    canvas.drawArc(
      rect, startRad, progressSweep, false,
      Paint()
        ..color = arcColor
        ..strokeWidth = sw
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    // Trailing dot
    final endAngle = startRad + progressSweep;
    final dx = center.dx + radius * math.cos(endAngle);
    final dy = center.dy + radius * math.sin(endAngle);

    canvas.drawCircle(
      Offset(dx, dy), sw * 0.72,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7),
    );
    canvas.drawCircle(
      Offset(dx, dy), sw * 0.45,
      Paint()..color = Colors.white,
    );
    // inner dot shine
    canvas.drawCircle(
      Offset(dx - sw * 0.12, dy - sw * 0.12), sw * 0.15,
      Paint()..color = Colors.white.withValues(alpha: 0.7),
    );
  }

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.progress != progress || old.isOver != isOver;
}

// ─────────────────────────────────────────────────────────────────────────────
// Pulsing status dot
// ─────────────────────────────────────────────────────────────────────────────

class _PulseDot extends StatefulWidget {
  final Color color;
  const _PulseDot({required this.color});

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1100));
    _pulse = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
    _ctrl.repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _pulse,
        builder: (_, __) => Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.55 * _pulse.value),
                blurRadius: 8 + 4 * _pulse.value,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Home screen
// ─────────────────────────────────────────────────────────────────────────────

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with TickerProviderStateMixin {
  late final AnimationController _entryCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _entryCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _fadeAnim =
        CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutCubic);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutCubic));
    _entryCtrl.forward();
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    super.dispose();
  }

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final monthlySpent = ref.watch(monthlySpendingProvider);
    final monthlyIncome = ref.watch(monthlyIncomeProvider);
    final todaySpent = ref.watch(todaySpendingProvider);
    final weekSpent = ref.watch(weekSpendingProvider);
    final recentTxns = ref.watch(allTransactionsProvider);
    final user = ref.watch(currentUserProvider);
    final displayName =
        user?.displayName?.split(' ').first ?? 'there';

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _greeting(),
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              displayName == 'there' ? 'FinAI' : 'Hi, $displayName',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () => context.push(AppConstants.routeTransactions),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _kBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _kBlue.withValues(alpha: 0.25)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.receipt_long_outlined, color: _kBlue, size: 14),
                  SizedBox(width: 5),
                  Text('All',
                      style: TextStyle(
                          color: _kBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: AnimatedBackground(
        child: RefreshIndicator(
          color: _kBlue,
          backgroundColor: AppColors.cardDark,
          onRefresh: () async {
            ref.invalidate(monthlySpendingProvider);
            ref.invalidate(monthlyIncomeProvider);
            ref.invalidate(todaySpendingProvider);
            ref.invalidate(weekSpendingProvider);
            ref.invalidate(allTransactionsProvider);
          },
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                        height: MediaQuery.paddingOf(context).top +
                            kToolbarHeight +
                            8),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        // ── Main status window (arc card) ─────────────
                        _StatusWindow(
                          spentAsync: monthlySpent,
                          incomeAsync: monthlyIncome,
                        ),

                        // ── Quick stats row ────────────────────────────
                        _QuickStatsRow(
                          todayAsync: todaySpent,
                          weekAsync: weekSpent,
                          monthAsync: monthlySpent,
                        ),

                        // ── Quick actions ──────────────────────────────
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                          child: Row(
                            children: [
                              _QuickAction(
                                icon: Icons.add_rounded,
                                label: 'Add',
                                color: _kBlue,
                                onTap: () => context
                                    .push(AppConstants.routeAddTransaction),
                              ),
                              const SizedBox(width: 8),
                              _QuickAction(
                                icon: Icons.bar_chart_rounded,
                                label: 'Analytics',
                                color: AppColors.accentPurple,
                                onTap: () =>
                                    context.go(AppConstants.routeAnalytics),
                              ),
                              const SizedBox(width: 8),
                              _QuickAction(
                                icon: Icons.account_balance_wallet_outlined,
                                label: 'Budgets',
                                color: AppColors.accentAmber,
                                onTap: () =>
                                    context.go(AppConstants.routeBudgets),
                              ),
                              const SizedBox(width: 8),
                              _QuickAction(
                                icon: Icons.auto_awesome,
                                label: 'FinAI',
                                color: AppColors.accentCyan,
                                onTap: () =>
                                    context.go(AppConstants.routeAiChat),
                              ),
                            ],
                          ),
                        ),

                        // ── Recent activity header ─────────────────────
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16, 4, 16, 10),
                          child: Row(
                            children: [
                              Container(
                                width: 3,
                                height: 17,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [_kBlue, AppColors.accentPurple],
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: _kBlue, blurRadius: 6)
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'RECENT ACTIVITY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 2,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => context
                                    .push(AppConstants.routeTransactions),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _kBlue.withValues(alpha: 0.09),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color:
                                            _kBlue.withValues(alpha: 0.2)),
                                  ),
                                  child: const Text(
                                    'VIEW ALL',
                                    style: TextStyle(
                                        color: _kBlue,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Transaction list ───────────────────────────────────
                  recentTxns.when(
                    loading: () => const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator(color: _kBlue),
                        ),
                      ),
                    ),
                    error: (e, _) => SliverToBoxAdapter(
                      child: Center(
                          child: Text('Error: $e',
                              style:
                                  const TextStyle(color: Colors.red))),
                    ),
                    data: (txns) {
                      if (txns.isEmpty) {
                        return SliverToBoxAdapter(
                          child: GlassCard(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all(40),
                            borderRadius: 20,
                            borderColor: _kBlue.withValues(alpha: 0.15),
                            child: Column(
                              children: [
                                Icon(Icons.receipt_long_outlined,
                                    color: Colors.white
                                        .withValues(alpha: 0.15),
                                    size: 52),
                                const SizedBox(height: 14),
                                Text(
                                  'No transactions yet.\nTap Add to record one.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white
                                          .withValues(alpha: 0.3),
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      final recent = txns.take(20).toList();
                      return SliverPadding(
                        padding:
                            const EdgeInsets.fromLTRB(16, 0, 16, 100),
                        sliver: SliverList.builder(
                          itemCount: recent.length,
                          itemBuilder: (ctx, i) =>
                              TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: 1),
                            duration: Duration(
                                milliseconds: 350 +
                                    (i * 40).clamp(0, 400)),
                            curve: Curves.easeOutCubic,
                            builder: (_, v, child) => Opacity(
                              opacity: v,
                              child: Transform.translate(
                                offset: Offset(0, 10 * (1 - v)),
                                child: child,
                              ),
                            ),
                            child: TransactionTile(
                              transaction: recent[i],
                              onTap: () => context.push(
                                  AppConstants.routeEditTransaction,
                                  extra: recent[i]),
                              onDelete: () => ref
                                  .read(transactionFormProvider.notifier)
                                  .remove(recent[i].id),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppConstants.routeAddTransaction),
        backgroundColor: _kBlue,
        elevation: 8,
        highlightElevation: 12,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text('Add',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Status Window — main arc card
// ─────────────────────────────────────────────────────────────────────────────

class _StatusWindow extends StatefulWidget {
  final AsyncValue<double> spentAsync;
  final AsyncValue<double> incomeAsync;

  const _StatusWindow(
      {required this.spentAsync, required this.incomeAsync});

  @override
  State<_StatusWindow> createState() => _StatusWindowState();
}

class _StatusWindowState extends State<_StatusWindow>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1700));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _ctrl.forward();
  }

  @override
  void didUpdateWidget(_StatusWindow old) {
    super.didUpdateWidget(old);
    _ctrl
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  /// S-rank = spent < 50% of income, etc.
  static String _rank(double p) {
    if (p < 0.50) return 'S';
    if (p < 0.70) return 'A';
    if (p < 0.85) return 'B';
    if (p < 1.00) return 'C';
    return 'D';
  }

  static Color _rankColor(String r) {
    switch (r) {
      case 'S':
        return const Color(0xFF00E5FF);
      case 'A':
        return const Color(0xFF00E676);
      case 'B':
        return const Color(0xFFFFD740);
      case 'C':
        return const Color(0xFFFF9100);
      default:
        return const Color(0xFFFF3355);
    }
  }

  @override
  Widget build(BuildContext context) {
    final spent = widget.spentAsync.valueOrNull ?? 0;
    final income = widget.incomeAsync.valueOrNull ?? 0;
    final net = income - spent;
    final progress =
        income > 0 ? (spent / income).clamp(0.0, 1.0) : 0.0;
    final isOver = progress >= 1.0;
    final arcColor = isOver ? const Color(0xFFFF3355) : _kBlue;
    final rank = _rank(progress);
    final rankColor = _rankColor(rank);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D1117), Color(0xFF07090F)],
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
            color: arcColor.withValues(alpha: 0.32), width: 1),
        boxShadow: [
          BoxShadow(
            color: arcColor.withValues(alpha: 0.16),
            blurRadius: 36,
            spreadRadius: -8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            child: Column(
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 5),
                      decoration: BoxDecoration(
                        color: arcColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: arcColor.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _PulseDot(color: arcColor),
                          const SizedBox(width: 6),
                          Text(
                            'SYSTEM STATUS',
                            style: TextStyle(
                              color: arcColor,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Rank badge
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: rankColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(
                            color: rankColor.withValues(alpha: 0.45)),
                        boxShadow: [
                          BoxShadow(
                              color: rankColor.withValues(alpha: 0.22),
                              blurRadius: 12)
                        ],
                      ),
                      child: Center(
                        child: Text(
                          rank,
                          style: TextStyle(
                            color: rankColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Arc ring + center text
                AnimatedBuilder(
                  animation: _anim,
                  builder: (_, __) {
                    final ap = progress * _anim.value;
                    return SizedBox(
                      height: 200,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(200, 200),
                            painter: _ArcPainter(
                                progress: ap, isOver: isOver),
                          ),
                          // Center content
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 8),
                              widget.spentAsync.when(
                                loading: () => const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: _kBlue),
                                ),
                                error: (_, __) => const Text('—',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                data: (_) => TweenAnimationBuilder<
                                    double>(
                                  tween: Tween(begin: 0, end: spent),
                                  duration: const Duration(
                                      milliseconds: 1500),
                                  curve: Curves.easeOutCubic,
                                  builder: (_, v, __) => Text(
                                    CurrencyFormatter.format(v),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'MONTHLY SPENT',
                                style: TextStyle(
                                  color:
                                      Colors.white.withValues(alpha: 0.28),
                                  fontSize: 8,
                                  letterSpacing: 2.2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 3),
                                decoration: BoxDecoration(
                                  color: arcColor.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: arcColor.withValues(alpha: 0.3)),
                                ),
                                child: Text(
                                  '${(ap * 100).toStringAsFixed(0)}%',
                                  style: TextStyle(
                                    color: arcColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // Net indicator
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: (net >= 0 ? AppColors.income : AppColors.expense)
                          .withValues(alpha: 0.07),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: (net >= 0
                                ? AppColors.income
                                : AppColors.expense)
                            .withValues(alpha: 0.18),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          net >= 0
                              ? Icons.shield_outlined
                              : Icons.warning_amber_rounded,
                          color: net >= 0
                              ? AppColors.income
                              : AppColors.expense,
                          size: 13,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          net >= 0
                              ? '₹${CurrencyFormatter.formatCompact(net)} available'
                              : '₹${CurrencyFormatter.formatCompact(net.abs())} over limit',
                          style: TextStyle(
                            color: net >= 0
                                ? AppColors.income
                                : AppColors.expense,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Spent / Income chips
                Row(
                  children: [
                    Expanded(
                      child: _SystemChip(
                        label: 'SPENT',
                        value: CurrencyFormatter.formatCompact(spent),
                        color: AppColors.expense,
                        icon: Icons.arrow_upward_rounded,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _SystemChip(
                        label: 'INCOME',
                        value: CurrencyFormatter.formatCompact(income),
                        color: _kBlue,
                        icon: Icons.arrow_downward_rounded,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// System chip (Spent / Income)
// ─────────────────────────────────────────────────────────────────────────────

class _SystemChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _SystemChip({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Icon(icon, color: color, size: 13),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        color: color.withValues(alpha: 0.55),
                        fontSize: 9,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w700)),
                Text('₹$value',
                    style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Quick stats row (Today / Week / Month)
// ─────────────────────────────────────────────────────────────────────────────

class _QuickStatsRow extends StatelessWidget {
  final AsyncValue<double> todayAsync;
  final AsyncValue<double> weekAsync;
  final AsyncValue<double> monthAsync;

  const _QuickStatsRow({
    required this.todayAsync,
    required this.weekAsync,
    required this.monthAsync,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: Row(
        children: [
          _StatPanel(
              label: 'TODAY',
              valueAsync: todayAsync,
              icon: Icons.wb_sunny_outlined),
          const SizedBox(width: 8),
          _StatPanel(
              label: 'WEEK',
              valueAsync: weekAsync,
              icon: Icons.date_range_outlined),
          const SizedBox(width: 8),
          _StatPanel(
              label: 'MONTH',
              valueAsync: monthAsync,
              icon: Icons.calendar_month_outlined),
        ],
      ),
    );
  }
}

class _StatPanel extends StatelessWidget {
  final String label;
  final AsyncValue<double> valueAsync;
  final IconData icon;

  const _StatPanel(
      {required this.label,
      required this.valueAsync,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: 0.055),
              Colors.white.withValues(alpha: 0.025),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          border:
              Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Column(
          children: [
            Icon(icon,
                color: _kBlue.withValues(alpha: 0.7), size: 15),
            const SizedBox(height: 5),
            Text(label,
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.3),
                    fontSize: 9,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            valueAsync.when(
              loading: () => const SizedBox(
                  width: 13,
                  height: 13,
                  child: CircularProgressIndicator(
                      strokeWidth: 1.5, color: _kBlue)),
              error: (_, __) => const Text('—',
                  style: TextStyle(color: Colors.white)),
              data: (v) => TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: v),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                builder: (_, val, __) => Text(
                  '₹${CurrencyFormatter.formatCompact(val)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Quick action buttons row
// ─────────────────────────────────────────────────────────────────────────────

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.1),
                color.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withValues(alpha: 0.22)),
            boxShadow: [
              BoxShadow(
                  color: color.withValues(alpha: 0.1), blurRadius: 12)
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 5),
              Text(label,
                  style: TextStyle(
                      color: color.withValues(alpha: 0.85),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3)),
            ],
          ),
        ),
      ),
    );
  }
}
