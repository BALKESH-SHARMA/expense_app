import 'package:expense/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartProvider with ChangeNotifier {
  List<Transaction> recentTransaction;
  ChartProvider(this.recentTransaction);

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var itr = 0; itr < recentTransaction.length; itr++) {
        if (recentTransaction[itr].date.day == weekDay.day &&
            recentTransaction[itr].date.month == weekDay.month &&
            recentTransaction[itr].date.year == weekDay.year) {
          totalSum += recentTransaction[itr].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }
}
