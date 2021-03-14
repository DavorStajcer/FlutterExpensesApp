import 'package:flutter/material.dart';
import 'package:ExpensesApp/user_transactions/Transaction.dart';

class TransactionAmount extends StatelessWidget {
  final Transaction _transaction;

  TransactionAmount(this._transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        child: Text(
          _transaction.amount.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
      margin: EdgeInsets.only(left: 12, top: 5, bottom: 5, right: 12),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.purple,
        ),
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    );
  }
}
