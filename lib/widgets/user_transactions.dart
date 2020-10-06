import 'package:flutter/material.dart';
import './transaction_input.dart';
import './transactions_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  UserTransactions({Key key}) : super(key: key);

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionInput(_addTransaction),
        TransactionsList(transactions: _transactions)
      ],
    );
  }
}
