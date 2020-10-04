import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime time;
  final String currency;

  Transaction(
      {@required this.id,
      @required this.time,
      @required this.title,
      @required this.amount,
      @required this.currency});
}
