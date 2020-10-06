import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  @override
  final List<Transaction> transactions;
  TransactionsList({@required this.transactions});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.map((tx) {
        return Card(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 1)),
                padding: EdgeInsets.all(10),
                child: Text('${tx.currency + tx.amount.toString()}',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(DateFormat.yMMMMd().format(tx.time),
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal))
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
