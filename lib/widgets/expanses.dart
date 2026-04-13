import 'package:flutter/material.dart';
import 'expenses_list/expenses_list.dart';
import '../model/expense.dart';
import 'new_expense.dart';

class Expanses extends StatefulWidget {
  const Expanses({super.key});

  @override
  State<Expanses> createState() => _ExpansesState();
}

class _ExpansesState extends State<Expanses> {
  final List<Expense> _recentExpanses = [
    Expense(
      title: 'Flutter Course',
      amount: 100.0,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Cinema',
      amount: 50.0,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void onAddExpense(Expense expense) {
    setState(() {
      _recentExpanses.add(expense);
    });
  }

  void _addExpense() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return NewExpense(onAddExpense: onAddExpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _addExpense, icon: const Icon(Icons.add)),
        ],
        title: const Text('Expanses'),
      ),
      body: Column(
        children: [
          const Text('The chart!'),
          Expanded(child: ExpensesList(expenses: _recentExpanses)),
        ],
      ),
    );
  }
}
