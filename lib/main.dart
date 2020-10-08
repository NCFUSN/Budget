import 'package:Budget/widgets/transactions_list.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_input.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
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
        currency: '£')
  ];

  void _addTransaction(String title, double amount) {
    final transaction = Transaction(
        amount: amount,
        title: title,
        currency: '£',
        time: DateTime.now(),
        id: DateTime.now().toString());
    setState(() {
      _transactions.add(transaction);
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Expences Summary'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _presentAddTransactionModalList(context)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.blue,
                  elevation: 5,
                  child: Text('Chartssss'),
                ),
              ),
              TransactionsList(transactions: _transactions)
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
