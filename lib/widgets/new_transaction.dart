import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleText = TextEditingController();
  final amountText = TextEditingController();
  DateTime _selectedDate=DateTime.parse('0000-00-00');

  void _submitData() {
    if(amountText.text.isEmpty){
      return;
    }
    final enteredTitle = titleText.text;
    final enteredAmount = double.parse(amountText.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => _submitData(),
              // onChanged: (value)=>titleText=value,
              controller: titleText,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged:(value){
              // amountText=value;
              // },
              controller: amountText,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == DateTime.parse('0000-00-00')
                        ? 'No date Chosen!'
                        : 'Picked Date:${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                    onPressed: _presentDatePicker,
                    child: Text('Choose Date'),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            RaisedButton(
                child: Text('Add Transaction'),
                color: Colors.green,
                onPressed: () {
                  _submitData();
                }),
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
