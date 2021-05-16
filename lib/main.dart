import 'package:flutter/material.dart';
import 'package:michango/pages/widgets/widget_home_category.dart';
import 'pages/widgets/drawer.dart';

void main() {
  return runApp(MichangoApp());
}

class MichangoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.redAccent,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('HARUSI YA FRANK.'),
        ),
        body: _uisetup(),
        //drawer: MyDrawer(),
      ),
    );
  }
}

Widget _uisetup() {
  return new Container(
    alignment: Alignment.center,
    child: new Column(
      children: <Widget>[
        new Expanded(
            child: Padding(
          padding: EdgeInsets.all(0),
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              DashboardItems(),
              //Text('Widget 2'),
            ],
          ),
        ))
      ],
    ),
  );
}
