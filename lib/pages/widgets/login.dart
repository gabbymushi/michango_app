import 'package:flutter/material.dart';
import 'package:michango/main.dart';
import 'package:michango/services/user_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 20),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 100,
                      /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                      child: Image.asset('assets/images/event.jpeg')),
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: _phoneNumber,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone number',
                      hintText: 'Phone number'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter phone number";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: _login,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              /*    SizedBox(
                height: 130,
              ), */
              //Text('New User? Create Account')
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registration');
                },
                child: Text(
                  'New User? Create Account',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _login() async {
    if (_formKey.currentState.validate()) {
      Map loginInfo = {
        'phoneNumber': _phoneNumber.text,
        'password': _password.text
      };

      UserService userService = new UserService();

      var hasLoggein = await userService.login(loginInfo);

      if (hasLoggein) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MichangoApp()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: const Text("Wrong username or password."),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red),
        );
      }
    } 
  }
}
