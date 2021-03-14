import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionInput extends StatefulWidget {
  final void Function(String title, double amount, DateTime date)
      _onInputTransaciton;

  TransactionInput(this._onInputTransaciton);

  @override
  _TransactionInputState createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  DateTime _pickedDate;

  void _submitNewTransactionData() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _pickedDate == null) return;
    widget._onInputTransaciton(_titleController.text,
        double.parse(_amountController.text), _pickedDate);
    Navigator.of(context).pop();
  }

  void _openDatePicker() {
    showDatePicker(
            context: this.context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime(2021, 12, 31))
        .then((date) {
      setState(() {
        _pickedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: Container(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
              onSubmitted: (_) => _submitNewTransactionData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
              controller: _amountController,
              onSubmitted: (_) => _submitNewTransactionData(),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Text(_pickedDate == null
                      ? "No date selected"
                      : DateFormat.yMd().format(_pickedDate)),
                  TextButton(
                    child: Text("Set date"),
                    onPressed: _openDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                "Add transaction",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.button.color),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: _submitNewTransactionData,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
        padding: EdgeInsets.only(
          bottom: 2,
          right: 10,
          left: 10,
          top: 2,
        ),
      )),
      margin: EdgeInsets.only(
        left: 30,
        right: 30,
      ),
    );
  }
}
