import 'package:flutter/material.dart';
import 'package:michango/pages/widgets/login.dart';
import 'package:michango/pages/widgets/registration.dart';
import 'package:michango/pages/widgets/shared/drawer.dart';
import 'package:michango/pages/widgets/shared/michango_app_bar.dart';
import 'package:michango/pages/widgets/shared/bottom_nav_bar.dart';
import 'package:michango/pages/widgets/contributors_list.dart';
import 'package:michango/pages/widgets/dashboard.dart';
import 'package:michango/pages/widgets/message_config.dart';

void main() {
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.cyan[600],
        primarySwatch: Colors.cyan,
        brightness: Brightness.light,
      ),
      routes: {
        '/first': (context) => MichangoApp(),
        '/second': (context) => SecondScreen(),
        '/michango': (context) => Michango(),
        '/registration': (context) => Registration(),
      },
      home: Login(),
    ),
  );
}

class MichangoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MichangoAppBar(),
      body: Dashboard(),
      bottomNavigationBar: BottomNavBar(),
      drawer: MyDrawer(),
    );
  }
}
