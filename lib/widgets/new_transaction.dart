import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // grabs text from input fields
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitInput() {
    final submittedTitle = _titleController.text; // store input title string
    final submittedAmount = double.parse(
        _amountController.text); // store and covert amount string to double

    // will not allow data to submit under these two circumstances
    if (submittedTitle.isEmpty || submittedAmount <= 0 || _selectedDate == null || _amountController.text.isEmpty) {
      return;
    }

    widget.addTx(
      submittedTitle,
      submittedAmount,
      _selectedDate,
    );

    // closes top most screen displayed so modal closes after submission
    Navigator.of(context).pop();
  }

  void _showDates() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((uDate) {
      if (uDate == null) {
        return;
      }
      setState(() {
        _selectedDate = uDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitInput(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitInput(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "A date must be selected"
                          : 'Selected Date: ${DateFormat.yMMMMd("en_US").format(_selectedDate)}',
                      style: TextStyle(color: _selectedDate == null ? Colors.red : Theme.of(context).errorColor),
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      "Choose Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _showDates,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              onPressed: _submitInput,
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
