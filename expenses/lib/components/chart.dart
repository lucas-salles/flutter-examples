import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      return {
        "day": DateFormat.E("pt_BR").format(weekDay)[0].toUpperCase(),
        "value": totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue => _groupedTransactions.fold(
        0.0,
        (sum, transaction) => sum + (transaction["value"] as double),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactions.map((transaction) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: transaction["day"].toString(),
                value: (transaction["value"] as double),
                percentage: _weekTotalValue == 0
                    ? 0
                    : (transaction["value"] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
