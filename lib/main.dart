import 'dart:io';
import 'package:Budget/widgets/transactions_list.dart';
import 'package:flutter/cupertino.dart';
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
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20.0)),
            )));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _isShowChart = false;

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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expenses'), // navbar title in iOS
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  // use GestureDetector to build iOS buttons
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _presentAddTransactionModalList(context),
                )
              ],
            ),
          )
        : AppBar(
            title: const Text('Personal Expenses',
                style: TextStyle(fontFamily: 'Open Sans')),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _presentAddTransactionModalList(context)),
            ],
          );
    final transactionsList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7, // dedact navbar + status bar height
      child: TransactionsList(
        transactions: _transactions,
        deleteTransaction: _deleteTransaction,
      ),
    );

    final body = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show Chart',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _isShowChart,
                    onChanged: (value) {
                      setState(() {
                        _isShowChart = value;
                      });
                    }),
              ],
            ),
          if (!isLandscape)
            Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.3,
              child: Chart(_recentTransactions),
            ),
          if (!isLandscape) transactionsList,
          if (isLandscape)
            _isShowChart
                ? Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(_recentTransactions))
                : transactionsList
        ],
      ),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: body,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _presentAddTransactionModalList(context),
                  ));
  }
}
