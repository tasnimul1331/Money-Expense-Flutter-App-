import 'package:expence_traker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expence_traker/model/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => ExpensesItem(expense: expenses[index]),
    );
  }
}
