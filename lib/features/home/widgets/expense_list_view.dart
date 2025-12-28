import 'package:flutter/material.dart';

class ExpenseListView extends StatefulWidget {
  const ExpenseListView({super.key, required this.index});

  final int index;

  @override
  State<ExpenseListView> createState() => _ExpenseListViewState();
}

class _ExpenseListViewState extends State<ExpenseListView> {
  @override
  Widget build(BuildContext context) {
    return  Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Expense Item ${widget.index + 1}'),
              subtitle: Text('Description for expense item ${widget.index + 1}'),
              trailing: Text('-\$${(widget.index + 1) * 10}.00'),
            ),
          );
  }
}
