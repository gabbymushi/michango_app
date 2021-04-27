import 'package:flutter/material.dart';
import './drawer.dart';

void main() {
  return runApp(MichangoApp());
}

class MichangoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.amber,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('HARUSI YA FRANK'),
          ),
          body: Center(
            child: Text('My Page'),
          ),
          drawer: MyDrawer()),
    );
  }
}
