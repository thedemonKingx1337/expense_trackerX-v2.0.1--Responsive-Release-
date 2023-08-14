import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_march/expense_tracker/models/transaction.dart';
import 'package:project_march/expense_tracker/widgets/chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].created.day == weekDay.day &&
            recentTransactions[i].created.month == weekDay.month &&
            recentTransactions[i].created.year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].amount;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 3),
        "amount": totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0,
        (previousValue, element_iterated) {
      return previousValue + element_iterated["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((iterated_DayAmount) {
              return Flexible(
                fit: FlexFit.tight,
                child: Chart_Bars(
                    iterated_DayAmount["day"],
                    iterated_DayAmount["amount"],
                    totalSpending == 0.0
                        ? 0.0
                        : (iterated_DayAmount["amount"] as double) /
                            totalSpending),
              );
            }).toList()),
      ),
    );
  }
}
