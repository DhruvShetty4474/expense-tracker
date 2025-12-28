import 'package:expense_tracker/features/home/helper/helper.dart';
import 'package:expense_tracker/features/home/widgets/expense_summary_row.dart';
import 'package:expense_tracker/features/home/widgets/total_expense_card.dart';
import 'package:expense_tracker/features/home/widgets/expense_list_view.dart';
import 'package:flutter/material.dart';

/// Contains the Home screen of the Expense Tracker app.

// StatefulWidget
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// State for CounterPage
class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final ValueNotifier<bool> summaryVisible = ValueNotifier<bool>(true);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of the animation
    );
    _animation = Tween<double>(
      begin: 0,
      end: 0.82,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward(); // Start the animation
    super.initState();
  }

  @override
  void dispose() {
    summaryVisible.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        // Can Use automaticallyImplyLeading to false if using the menu icon
        // For now use This Icon place holder will make the Darwer...
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            print('Menu');
          },
          icon: Icon(Icons.menu),
        ),
        title: Text('Expense Tracker'),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              print('Search');
            },
            icon: Icon(Icons.search),
          ),
        ],
        elevation: 6,
        shadowColor: Colors.black45,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        // ),
        backgroundColor: Colors.green,
        clipBehavior: Clip.hardEdge,
      ),
      body: SafeArea(
        child: Column(
          children: [
            TotalExpenseCard(25000, 30000),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: false,
                    floating: false,
                    delegate: SummaryHeaderDelegate(
                      onVisibilityChanged: (visible) {
                        summaryVisible.value = visible;
                      },
                      minHeight: 0,
                      maxHeight: 120,
                      child: ExpenseSummaryRow(
                        isVisible: summaryVisible.value,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return ExpenseListView(index: index);
                    }, childCount: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /// Need to add custom bottom navigation bar here.
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.green,
      ),
    );
  }
}
