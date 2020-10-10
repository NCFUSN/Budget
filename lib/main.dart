import 'package:Budget/widgets/transactions_list.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_input.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MyExpenses',
        home: MyHomePage(),
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            accentColor: Colors.blueGrey,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontFamily: 'OpenSans', fontSize: 20.0)),
            )));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    /*Transaction(
        amount: 12.54,
        id: '4564433677',
        title: 'Clothes',
        time: DateTime.now(),
        currency: '£'),
    Transaction(
        amount: 34.27,
        id: '4564433678',
        title: 'Fishing Kit',
        time: DateTime.now(),
        currency: '£')*/
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.time
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    final transaction = Transaction(
        amount: amount,
        title: title,
        currency: '£',
        time: date,
        id: DateTime.now().toString());
    setState(() {
      _transactions.add(transaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _presentAddTransactionModalList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: TransactionInput(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title:
          Text('Personal Expenses', style: TextStyle(fontFamily: 'Open Sans')),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _presentAddTransactionModalList(context)),
      ],
    );
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.4,
                  child: Chart(_recentTransactions)),
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.6, // dedact navbar + status bar height
                child: TransactionsList(
                  transactions: _transactions,
                  deleteTransaction: _deleteTransaction,
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _presentAddTransactionModalList(context),
        ));
  }
}
