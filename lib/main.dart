import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/model/transaction.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
          button: TextStyle(color: Colors.white),
        ),
        errorColor: Colors.red,

        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                subtitle1: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  // String titleText='';
  // String amountText='';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: "01",
    //   title: "Sh siam",
    //   amount: 20.0,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "02",
    //   title: "Sh siam",
    //   amount: 30.0,
    //   date: DateTime.now(), // date and time
    // ),
  ];
List<Transaction> get _recentTransaction{
  return _userTransaction.where((tx){
    return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
  }).toList();
}
  void _addNewTransaction(String txTitle, double txAmount,DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(), title: txTitle, amount: txAmount, date: chosenDate);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }
void _deleteTransaction(String id){
  setState(() {
    _userTransaction.removeWhere((tx) =>tx.id==id );
  });

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(_recentTransaction),
            TransactionList(_userTransaction,_deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
