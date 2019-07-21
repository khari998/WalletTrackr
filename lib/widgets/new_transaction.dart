import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // grabs text from input fields
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitInput() {
    final submittedTitle = titleController.text; // store input title string 
    final submittedAmount = double.parse(amountController.text); // store and covert amount string to double

    // will not allow data to submit under these two circumstances
    if (submittedTitle.isEmpty || submittedAmount <= 0) {
      return;
    }

    widget.addTx(
      submittedTitle,
      submittedAmount,
    );

    // closes top most screen displayed so modal closes after submission
    Navigator.of(context).pop(); 

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitInput(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitInput(),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              onPressed: submitInput,
              textColor: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
