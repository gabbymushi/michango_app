import 'package:flutter/material.dart';
import 'package:michango/services/contributor_service.dart';

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
              Padding(
                padding: EdgeInsets.all(10),
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
                    hintText: 'Enter a search term',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _phoneNumber,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter phone number";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Namba ya simu',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _pledge,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Kiasi cha ahadi',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _paidAmount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Kiasi anachopunguza',
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
    if (_formKey.currentState.validate()) {
      Map<String, dynamic> contributor = {
        'fullName': _fullName.text,
        'phoneNumber': _phoneNumber.text,
        'pledgedAmount': _pledge.text,
        'paidAmount': _paidAmount.text,
      };

      ContributorService contributorService = new ContributorService();

      contributorService.createContributor(contributor);
      //RegistrationUser();
      print("Successful");
    } else {
      print("Unsuccessfull");
    }
  }
}
