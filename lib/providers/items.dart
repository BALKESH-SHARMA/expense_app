import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/transaction.dart';
import '../widgets/new_transaction.dart';

class Items with ChangeNotifier {
  List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'Shoes',
    //   amount: 549.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Food',
    //   amount: 500.99,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get userTransaction {
    return [..._userTransaction];
  }

  List<Transaction> get recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  Future<void> fetchAndSetProduct() async {
    var url1 = Uri.parse(
        'https://expense-6881c-default-rtdb.firebaseio.com/spendings.json');
    final response = await http.get(url1);
    final List<Transaction> loadedExpense = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    extractedData.forEach((expenseID, expenseData) {
      loadedExpense.add(
        Transaction(
          id: expenseID,
          title: expenseData['title'],
          amount: expenseData['amount'],
          date: DateTime.parse(expenseData['date']),
        ),
      );
    });
    _userTransaction = loadedExpense;
    notifyListeners();
  }

  Future<void> _addNewTransaction(
      String txTitle, double txAmount, DateTime txdate) async {
    final url = Uri.parse(
        'https://expe-c970c-default-rtdb.firebaseio.com/spendings.json');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'title': txTitle,
          'amount': txAmount,
          'date': txdate.toIso8601String(),
        },
      ),
    );
    final newTx = Transaction(
      id: json.decode(response.body)['name'], //DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: txdate,
    );

    _userTransaction.add(newTx);
    notifyListeners();
  }

  Future<void> deleteTransaction(String id) async {
    final url = Uri.parse(
        'https://expe-c970c-default-rtdb.firebaseio.com/spendings/$id.json');
    final existingExpenseIndex =
        _userTransaction.indexWhere((tx) => tx.id == id);
    var existingExpense = _userTransaction[existingExpenseIndex];
    _userTransaction.removeAt(existingExpenseIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _userTransaction.insert(existingExpenseIndex, existingExpense);
      notifyListeners();
    }
    existingExpense = null as Transaction;
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
            onTap: () {}, child: NewTransaction(_addNewTransaction));
      },
    );
  }
}
