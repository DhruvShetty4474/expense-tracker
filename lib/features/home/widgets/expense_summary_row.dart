import 'package:flutter/material.dart';

class ExpenseSummaryRow extends StatefulWidget {
  const ExpenseSummaryRow({super.key,required this.isVisible});

  final bool isVisible;

  @override
  State<ExpenseSummaryRow> createState() => _ExpenseSummaryRowState();
}

class _ExpenseSummaryRowState extends State<ExpenseSummaryRow>
    with TickerProviderStateMixin {
  late AnimationController _countController;
  late Animation<double> _spendToday;
  late Animation<double> _spendWeek;
  late Animation<double> _spendMonth;

  bool _playedOnce = false;

  @override
  void initState() {
    _countController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of the animation
    );
    _spendToday = Tween<double>(begin: 0, end: 1200).animate(
      CurvedAnimation(parent: _countController, curve: Curves.easeInOut),
    );
    _spendWeek = Tween<double>(begin: 0, end: 5600).animate(
      CurvedAnimation(parent: _countController, curve: Curves.easeInOut),
    );
    _spendMonth = Tween<double>(begin: 0, end: 20450).animate(
      CurvedAnimation(parent: _countController, curve: Curves.easeInOut),
    );
    _countController.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ExpenseSummaryRow oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isVisible && !_playedOnce) {
      _countController.forward(from: 0);
      _playedOnce = true;
    }

    if (!widget.isVisible) {
      _playedOnce = false;
      _countController.reset();
    }
  }

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // need to make serperate 3 part this should be a row with Today, Week, Month
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      color: Color(0xFFFFFFFF),
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Today',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  AnimatedBuilder(
                    animation: _spendToday,
                    builder: (context, child) {
                      return Text(
                        '\u20B9 ${_spendToday.value.toInt()}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                ],
              ),
              // DIVIDER
              VerticalDivider(
                color: Colors.grey.shade400,
                thickness: 1.5,
                width: 30, // spacing around divider
              ),
              Column(
                children: [
                  Text(
                    'Week',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),

                  AnimatedBuilder(
                    animation: _spendWeek,
                    builder: (context, child) {
                      return Text(
                        '\u20B9 ${_spendWeek.value.toInt()}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                ],
              ),
              // DIVIDER
              VerticalDivider(
                color: Colors.grey.shade400,
                thickness: 1.5,
                width: 30, // spacing around divider
              ),
              Column(
                children: [
                  Text(
                    'Month',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  AnimatedBuilder(
                    animation: _spendMonth,
                    builder: (context, child) {
                      return Text(
                        '\u20B9 ${_spendMonth.value.toInt()}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
