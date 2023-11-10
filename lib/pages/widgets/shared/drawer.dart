import 'package:flutter/material.dart';
import 'package:michango/pages/widgets/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('HARUSI YA FRANK'),
            decoration: BoxDecoration(
              color: Colors.cyan[600],
            ),
          ),
          ListTile(
            title: Text('Orodha'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Kumbusha wachangiaji'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.blue, fontSize: 25),
            ),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login()));
            },
          ),
        ],
      ),
    );
  }
}
