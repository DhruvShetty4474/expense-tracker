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
            Card(
              margin: EdgeInsets.all(16),
              elevation: 4,
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
                    Text(
                      '\u20B9,250.00',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),

                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: _animation.value,
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
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          '\u20B9 30,000.00',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Card(
              // need to make serperate 3 part this should be a row with Today, Week, Month
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 4,
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
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '\u20B9 1,200',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
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
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '\u20B9 5,600',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
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
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '\u20B9 20,450',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      /// Need to add custom bottom navigation bar here.
    );
  }
}
