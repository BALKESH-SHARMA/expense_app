import 'package:expense/providers/chart_provider.dart';
import 'package:expense/providers/items.dart';
import 'package:expense/widgets/front.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Items(),
        ),
        ChangeNotifierProxyProvider<Items, ChartProvider>(
            create: (ctx) => ChartProvider([]),
            update: (ctx, item, previousProvider) =>
                ChartProvider(item.recentTransaction))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Personal Expenses',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ),
        home: Front(),
      ),
    );
  }
}
