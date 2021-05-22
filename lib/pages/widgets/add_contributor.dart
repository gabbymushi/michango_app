import 'package:flutter/material.dart';

class AddEntryDialog extends StatefulWidget {
  @override
  _AddEntryDialogState createState() => _AddEntryDialogState();
}

class _AddEntryDialogState extends State<AddEntryDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Entry'),
        actions: [
          TextButton(
            onPressed: () => {},
            child: Text(
              'Save',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.white),
            ),
          )
        ],
      ),
      body: Text('Foo'),
    );
  }
}
