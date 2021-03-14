import 'package:flutter/material.dart';
import '../Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _transactions.isEmpty
          ? Column(
              children: [
                Text(
                  "No transactions yet.",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  height: 150,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 15),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      child: FittedBox(
                        child: Text(
                          _transactions[index].amount.toStringAsFixed(2),
                          style: TextStyle(
                            color: Theme.of(context).textTheme.button.color,
                          ),
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    title: Text(
                      _transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat().format(_transactions[index].date),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () =>
                          _deleteTransaction(_transactions[index].id),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
              itemCount: _transactions.length,
            ),
    );
  }
}
