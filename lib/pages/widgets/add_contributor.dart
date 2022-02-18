import 'package:flutter/material.dart';
import 'package:michango/ThousandNumberFormatter.dart';
import 'package:michango/services/contributor_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEntryDialog extends StatefulWidget {
  @override
  _AddEntryDialogState createState() => _AddEntryDialogState();
}

class _AddEntryDialogState extends State<AddEntryDialog> {
  TextEditingController _fullName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _pledge = TextEditingController();
  TextEditingController _paidAmount = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongeza Mchangiaji'),
        actions: [
          /*  TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ), */
          TextButton(
            onPressed: _submitForm,
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
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(7),
                  child: TextFormField(
                    controller: _fullName,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please enter Fullname";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Jina kamili',
                      hintText: 'Jina kamili',
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(7),
                  child: TextFormField(
                    controller: _phoneNumber,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Tafadhali ingiza namba ya simu.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Namba ya simu',
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(7),
                  child: TextFormField(
                    controller: _pledge,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Kiasi cha ahadi',
                    ),
                    inputFormatters: [ThousandsSeparatorInputFormatter()],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(7),
                  child: TextFormField(
                    controller: _paidAmount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Kiasi anachopunguza',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _submitForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var eventId = prefs.getString('currentEventId');

    if (_formKey.currentState.validate()) {
      Map contributor = {
        'fullName': _fullName.text,
        'phoneNumber': _phoneNumber.text,
        'pledgedAmount': _pledge.text == '' ? 0 : _pledge.text,
        'paidAmount': _paidAmount.text == '' ? 0 : _paidAmount.text,
        'event': eventId
      };

      try {
        ContributorService contributorService = new ContributorService();

        await contributorService.createContributor(contributor);

        clearInputFields();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: const Text("Contributor added successfully."),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.green),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(e.toString()),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  void clearInputFields() {
    _fullName.clear();
    _phoneNumber.clear();
    _pledge.clear();
    _paidAmount.clear();
  }
}
