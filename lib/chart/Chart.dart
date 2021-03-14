import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../user_transactions/Transaction.dart';
import '../chart/bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get _groupedTransactionValues {
    print("Recent transactions number -> ${_recentTransactions.length}");
    return List.generate(7, (index) {
      final DateTime weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      double amount = 0.0;
      for (int i = 0; i < _recentTransactions.length; i++) {
        if (_recentTransactions[i].date.day == weekDay.day &&
            _recentTransactions[i].date.month == weekDay.month) {
          amount += _recentTransactions[i].amount;
          if (index == _recentTransactions.length - 1 &&
              _recentTransactions[i].date.hour < weekDay.hour) {
            amount -= _recentTransactions[i].amount;
          }
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': amount};
    }).reversed.toList();
  }

  double get _maxSpending {
    return _groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          child: Expanded(
            child: Row(
              children: [
                ..._groupedTransactionValues.map((groupedTransaction) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: Bar(
                        groupedTransaction['day'],
                        groupedTransaction['amount'],
                        _maxSpending == 0
                            ? 0
                            : (groupedTransaction['amount'] as double) /
                                _maxSpending),
                  );
                })
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          padding: EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 20),
        ),
        elevation: 5,
        margin: EdgeInsets.all(30),
      ),
      width: double
          .infinity, //Card uzima velicinu djeteta, osim ako nema parent koji ima mogucnost promjene layout parametra
    );
  }
}
