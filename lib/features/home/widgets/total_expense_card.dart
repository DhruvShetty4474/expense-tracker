import 'package:flutter/material.dart';

class TotalExpenseCard extends StatefulWidget {
  final double totalBudget;
  final double spendAmount;
  const TotalExpenseCard(this.spendAmount, this.totalBudget, {super.key});

  @override
  State<TotalExpenseCard> createState() => _TotalExpenseCardState();
}

class _TotalExpenseCardState extends State<TotalExpenseCard>
    with TickerProviderStateMixin {
  late AnimationController _progressIndicatorcontroller;
  late Animation<double> _progressIndicatorAnimation;

  late AnimationController _countController;
  late Animation<double> _spendTextAnimation;
  late Animation<double> _totalBudgetAnimation;

  @override
  void initState() {
    _progressIndicatorcontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of the animation
    );
    _progressIndicatorAnimation = Tween<double>(
      begin: 0,
      end:
          widget.spendAmount /
          widget
              .totalBudget, // Need to make it dynamic based on budget that has been set.
    ).animate(
      CurvedAnimation(
        parent: _progressIndicatorcontroller,
        curve: Curves.easeInOut,
      ),
    );
    _progressIndicatorcontroller.forward(); // Start the animation

    _countController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of the animation
    );

    _spendTextAnimation = Tween<double>(
      begin: 0,
      end: widget.spendAmount,
    ).animate(
      CurvedAnimation(parent: _countController, curve: Curves.easeInOut),
    );

    _totalBudgetAnimation = Tween<double>(
      begin: 0,
      end: widget.totalBudget,
    ).animate(
      CurvedAnimation(parent: _countController, curve: Curves.easeInOut),
    );

    _countController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _progressIndicatorcontroller.dispose();
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      color: Color(0xFFFFFFFF),
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Expenses',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            AnimatedBuilder(
              animation: _spendTextAnimation,
              builder: (context, child) {
                return Text(
                  '\u20B9 ' +
                      _spendTextAnimation.value.toStringAsFixed(
                        0,
                      ), // 1 decimal place
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                );
              },
            ),
            SizedBox(height: 8),
            AnimatedBuilder(
              animation: _progressIndicatorcontroller,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _progressIndicatorAnimation.value,
                  backgroundColor: Colors.grey[300],
                  color: Colors.red,
                  minHeight: 5,
                  borderRadius: BorderRadius.circular(10),
                );
              },
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Budget',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                AnimatedBuilder(
                  animation: _totalBudgetAnimation,
                  builder: (context, child) {
                    return Text(
                      '\u20B9 ' +
                          _totalBudgetAnimation.value.toStringAsFixed(
                            0,
                          ), // 1 decimal place
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
