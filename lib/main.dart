import 'package:ExpensesApp/chart/Chart.dart';
import 'package:flutter/material.dart';
import 'package:ExpensesApp/user_transactions/Transaction.dart';
import 'package:ExpensesApp/user_transactions/transaction_input/TransactionInput.dart';
import 'package:ExpensesApp/user_transactions/transactions_list/TransactionList.dart';
import 'package:flutter/services.dart';

void main() {
/*   WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]); */
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Daca Expenses App",
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: "Quicksand",
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                ),
          )),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: DateTime.now().toString(),
        amount: 2,
        date: DateTime.now().subtract(Duration(days: 1)),
        title: "Something"),
    /*  Transaction(
        id: 1, amount: 10, date: DateTime.now(), title: "Transaction 1"),
    Transaction(
        id: 2, amount: 11, date: DateTime.now(), title: "Transaction 2"),
    Transaction(
        id: 3, amount: 12, date: DateTime.now(), title: "Transaction 3"),
    Transaction(
        id: 4, amount: 13, date: DateTime.now(), title: "Transaction 4"),
    Transaction(
        id: 5, amount: 14, date: DateTime.now(), title: "Transaction 5"),
   */
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList(); //if the function returns ture, it keeps the element in the list
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime date) {
    print(
        "DATE FKINJG PICKED AW0IJFDRoae'jfinEASO?JFN eas'iofrewas'9+nj -> $date, date now is -> ${DateTime.now()}");
    final newTransaction = Transaction(
      title: txTitle,
      amount: txAmount,
      date: date,
      id: date.toString(),
    );

    setState(() {
      this._transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((item) {
        return id == item.id;
      });
    });
  }

  void _openAddNewTransactionBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return TransactionInput(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Expenses app"),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () => _openAddNewTransactionBottomSheet(context),
        )
      ],
    );

    final double availableScreenSpace = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //takes all the space it can get by defalut
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text("Show chart."),
                Switch(
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            _showChart
                ? Container(
                    height: availableScreenSpace * 0.28,
                    child: Chart(_recentTransactions))
                : Container(
                    height: availableScreenSpace * 0.72,
                    child: TransactionList(_transactions, _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _openAddNewTransactionBottomSheet(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
