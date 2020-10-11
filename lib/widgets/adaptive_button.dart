import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final String selectedText;
  final Function handler;
  final DateTime selectedDate;

  AdaptiveButton(this.text, this.selectedText, this.handler, this.selectedDate);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(
              selectedDate == null ? text : selectedText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : FlatButton(
            onPressed: handler,
            child: Text(
              selectedDate == null ? 'Choose Date' : 'Change Date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            textColor: Theme.of(context).primaryColor,
          );
  }
}
