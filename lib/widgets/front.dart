import 'dart:io';

import 'package:expense/providers/items.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'chart.dart';
import 'transactionList.dart';

class Front extends StatefulWidget {
  const Front({Key? key}) : super(key: key);

  @override
  State<Front> createState() => _FrontState();
}

class _FrontState extends State<Front> {
  bool _showChart = false;

  Future? _expenseFuture;
  Future _obtainedExpenseFuture() {
    return Provider.of<Items>(context, listen: false).fetchAndSetProduct();
  }

  @override
  void initState() {
    _expenseFuture = _obtainedExpenseFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemsData = Provider.of<Items>(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Personal Expenses',
        style: TextStyle(
          fontFamily: 'Open Sans',
        ),
      ),
      shadowColor: Colors.black,
      elevation: 5,
      //255, 94, 255, 239
      actions: [
        IconButton(
            onPressed: () => itemsData.startAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );
    final txListWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.65,
      child: TransactionList(),
    );
    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
        future: _expenseFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(

                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (isLandscape)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Show Chart'),
                          Switch.adaptive(
                            value: _showChart,
                            onChanged: (val) {
                              setState(() {
                                _showChart = val;
                              });
                            },
                          ),
                        ],
                      ),
                    if (!isLandscape)
                      Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.35,
                        child: Chart(),
                      ),
                    if (!isLandscape) txListWidget,
                    if (isLandscape)
                      _showChart
                          ? Container(
                              height: (MediaQuery.of(context).size.height -
                                      appBar.preferredSize.height -
                                      MediaQuery.of(context).padding.top) *
                                  0.7,
                              child: Chart(),
                            )
                          : txListWidget,
                  ]),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              onPressed: () => itemsData.startAddNewTransaction(context),
              child: Icon(Icons.add),
            ),
    );
  }
}
