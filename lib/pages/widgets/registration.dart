import 'package:flutter/material.dart';
import 'package:michango/services/event_service.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  TextEditingController _name = TextEditingController();
  TextEditingController _date = TextEditingController();

  TextEditingController _fullName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Usajili MichangoApp'),
        centerTitle: true,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  type: stepperType,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      title: new Text('Taarifa Za Event'),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _name,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Please enter event name";
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: 'Jina La Event'),
                          ),
                          TextFormField(
                            controller: _date,
                            decoration:
                                InputDecoration(labelText: 'Tarehe Ya Event'),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: new Text('Taarifa Za Mtumiaji'),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _fullName,
                            keyboardType: TextInputType.text,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Please enter full name";
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: 'Jina Kamili'),
                          ),
                          TextFormField(
                            controller: _phoneNumber,
                            keyboardType: TextInputType.phone,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Please enter phone number";
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(labelText: 'Namba Ya Simu'),
                          ),
                          TextFormField(
                            controller: _password,
                            obscureText: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Please enter password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Password'),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep == 1
                          ? StepState.complete
                          : StepState.disabled,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  'Tengeneza akaunti',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.cyan,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(
                      fontSize: 15,
                    )),
              ),
            ],
          ),
        ),
      ),
      /*  floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: switchStepsType,
      ), */
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 1 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  Future _submitForm() async {
    if (_formKey.currentState.validate()) {
      Map<String, dynamic> event = {
        'name': _name.text,
        'date': _date.text,
      };

      Map<String, dynamic> user = {
        'fullName': _fullName.text,
        'phoneNumber': _phoneNumber.text,
        'password': _password.text
      };

      Map eventUser = {'event': event, 'user': user};

      EventService eventService = new EventService();

      eventService.createInitialEvent(eventUser);
      //RegistrationUser();
      print("Successful");
    } else {
      print("Unsuccessfull");
    }
  }
}
