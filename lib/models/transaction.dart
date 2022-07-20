import 'package:flutter/foundation.dart';

class Transaction {
  late final String id;
  late final String title;
  late final double amount;
  late final DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['amount'] = amount;
    map['date'] = date.toIso8601String();
    return map;
  }

  static fromMap(Map map) {
    return Transaction(
        id: map['id'],
        title: map['title'],
        amount: map['amount'],
        date: DateTime.parse(map['date']));
  }
}
