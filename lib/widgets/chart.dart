import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/model/transaction.dart';
import 'package:flutter_complete_guide/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransctions;
  Chart(this.recentTransctions);

  List<Map<String,Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
      final weekDay=DateTime.now().subtract(Duration(days: index));
      var totalsum=0.0;
      for(var i=0;i<recentTransctions.length;i++){
        if(recentTransctions[i].date.day==weekDay.day &&
        recentTransctions[i].date.month==weekDay.month &&
        recentTransctions[i].date.year==weekDay.year){
          totalsum+=recentTransctions[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalsum);

     return{'day':DateFormat.E().format(weekDay).substring(0,1),'amount':totalsum};
    }).reversed.toList();
  }

  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum, item){
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'].toString(),
                data['amount']as double,
                totalSpending==0.0?0.0:(data['amount']as double)/totalSpending,
              ),);
          }).toList(),
      ),
    );
  }
}
