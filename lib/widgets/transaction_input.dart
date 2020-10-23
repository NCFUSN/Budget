import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/adaptive_button.dart';

class TransactionInput extends StatefulWidget {
  final Function addTransaction;
  TransactionInput(this.addTransaction);

  @override
  _TransactionInputState createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTransaction(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop(); // closes most top screen
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // scrolview for scrolling the entire card over the top of keybord
      child: Card(
        child: Container(
          // padding for overlapping skeybord fix
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData()),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date choosen'
                          : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
                    ),
                    AdaptiveButton('Choose Date', 'Change Date',
                        _presentDatePicker, _selectedDate),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _submitData();
                },
                child: const Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
