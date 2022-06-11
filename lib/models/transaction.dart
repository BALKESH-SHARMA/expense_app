import 'package:flutter/foundation.dart';

class Transaction {
  late final String id;
  late final String title;
  late final double amount;
  late final DateTime date;

  Transaction(
      {@required required this.id,
      @required required this.title,
      @required required this.amount,
      @required required this.date});
}
