import 'package:flutter/material.dart';
import 'expenses_list/expenses_list.dart';
import '../model/expense.dart';
import 'new_expense.dart';
import 'chart/chart.dart';

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

  void _removeExpense(Expense expense) {
    final expenseIndex = _recentExpanses.indexOf(expense);
    setState(() {
      _recentExpanses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        persist: false,
        content: Text('${expense.title} removed.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _recentExpanses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _addExpense() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(onAddExpense: onAddExpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget child = const Center(
      child: Text('No expenses found. Start adding some!'),
    );
    if (_recentExpanses.isNotEmpty) {
      child = ExpensesList(
        expenses: _recentExpanses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _addExpense, icon: const Icon(Icons.add)),
        ],
        title: const Text('Expanses'),
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _recentExpanses),
                Expanded(child: child),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _recentExpanses)),
                Expanded(child: child),
              ],
            ),
    );
  }
}
