import 'package:flutter/material.dart';

import '../helpers/db_helper.dart';
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
    final dataList = await DBHelper.getData('user_data');
    print(dataList);
    print('printing');
    //printing

    List<Transaction> loadedProducts = [];
    // print(loadedProducts);
    // _userTransaction =  List.generate(
    //     dataList.length, (index) => Transaction.fromMap(dataList[index]));
    // print(loadedProducts);
    print(loadedProducts);
    loadedProducts = dataList
        .map(
          (item) => Transaction(
            id: item['id'],
            title: item['title'],
            amount: item['amount'],
            date: item['date'],
          ),
        )
        .toList();
    print(loadedProducts);
    // print(dataList);
    // _userTransaction = List.generate(
    //     dataList.length, (index) => Transaction.fromMap(dataList[index]));
    // print(loadedProducts);
    print('not printing');
    _userTransaction = loadedProducts;

    notifyListeners();
  }

  Future<void> _addNewTransaction(
      String txTitle, double txAmount, DateTime txdate) async {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: txdate,
    );
    DBHelper.insert('user_data', {
      'id': newTx.id,
      'title': newTx.title,
      'amount': newTx.amount,
      'date': newTx.date.toIso8601String(),
    });

    _userTransaction.add(newTx);
    notifyListeners();
  }

  Future<void> deleteTransaction(String id) async {
    // final url = Uri.parse(
    //     'https://expe-c970c-default-rtdb.firebaseio.com/spendings/$id.json');
    // final existingExpenseIndex =
    //     _userTransaction.indexWhere((tx) => tx.id == id);
    // var existingExpense = _userTransaction[existingExpenseIndex];
    // _userTransaction.removeAt(existingExpenseIndex);
    // notifyListeners();
    // final response = await http.delete(url);
    // if (response.statusCode >= 400) {
    //   _userTransaction.insert(existingExpenseIndex, existingExpense);
    //   notifyListeners();
    // }
    // existingExpense = null as Transaction;
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
