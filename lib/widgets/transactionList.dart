import 'package:expense/providers/items.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  // late final List<Transaction> transactions;
  // final Function deleteTx;
  // TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Items>(context);
    return Container(
        child: data.userTransaction.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Column(children: [
                  Text(
                    '${data.userTransaction.length}!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.contain,
                      )),
                ]);
              })
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child:
                                Text('₹${data.userTransaction[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        data.userTransaction[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd()
                            .format(data.userTransaction[index].date),
                      ),
                      trailing: MediaQuery.of(context).size.width > 400
                          ? TextButton.icon(
                              onPressed: () => data.deleteTransaction(
                                  data.userTransaction[index].id),
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                              style: TextButton.styleFrom(
                                  primary: Theme.of(context).errorColor),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => data.deleteTransaction(
                                  data.userTransaction[index].id),
                              color: Theme.of(context).errorColor,
                            ),
                    ),
                  );
                },
                itemCount: data.userTransaction.length,
              ));
  }
}
