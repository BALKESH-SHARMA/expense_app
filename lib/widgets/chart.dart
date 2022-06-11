import 'package:expense/providers/chart_provider.dart';

import '/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chart extends StatelessWidget {
  // late final List<Transaction> recentTransaction;

  // Chart(this.recentTransaction);

  // List<Map<String, Object>> get groupedTransactionValues {
  //   return List.generate(7, (index) {
  //     final weekDay = DateTime.now().subtract(Duration(days: index));
  //     var totalSum = 0.0;
  //     for (var itr = 0; itr < recentTransaction.length; itr++) {
  //       if (recentTransaction[itr].date.day == weekDay.day &&
  //           recentTransaction[itr].date.month == weekDay.month &&
  //           recentTransaction[itr].date.year == weekDay.year) {
  //         totalSum += recentTransaction[itr].amount;
  //       }
  //     }
  //     return {
  //       'day': DateFormat.E().format(weekDay).substring(0, 1),
  //       'amount': totalSum
  //     };
  //   }).reversed.toList();
  // }

  // double get totalSpending {
  //   return groupedTransactionValues.fold(0.0, (sum, item) {
  //     return sum + (item['amount'] as double);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: Provider.of<ChartProvider>(context, listen: false)
              .groupedTransactionValues
              .map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'].toString(),
                  data['amount'] as double,
                  Provider.of<ChartProvider>(context, listen: false)
                              .totalSpending ==
                          0.0
                      ? 0
                      : (data['amount'] as double) /
                          Provider.of<ChartProvider>(context, listen: false)
                              .totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
