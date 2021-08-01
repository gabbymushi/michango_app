import 'package:flutter/material.dart';
import 'package:michango/pages/widgets/shared/bottom_nav_bar.dart';
import 'package:michango/pages/widgets/shared/michango_app_bar.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MichangoAppBar(),
      body: Center(
        child: CircularProgressIndicator()
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}


/* class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[dashBg, content],
      ),
    );
  }

  /*  final List<Object> categories = [
    {"name": "Michango", "icon": Icon(Icons.ac_unit)}
  ]; */

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Michango',
      'icon': Icons.group,
    },
    {
      'name': 'Wauzaji',
      'icon': Icons.shopping_bag_sharp,
    },
    {
      'name': 'Michango',
      'icon': Icons.group,
    },
    {
      'name': 'Wauzaji',
      'icon': Icons.shopping_bag_sharp,
    },
    /* {'name': 'Ming', 'icon': Icon(Icons.add_box)}, */
  ];

  get dashBg => Column(
        children: <Widget>[
          Expanded(
            child: Container(color: Colors.blueAccent),
            flex: 2,
          ),
          Expanded(
            child: Container(color: Colors.transparent),
            flex: 5,
          ),
        ],
      );

  get content => Container(
        child: Column(
          children: <Widget>[
            header,
            grid,
          ],
        ),
      );

  get header => ListTile(
        contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        /*  subtitle: Text(
          'Harusi Ya Frank',
          style: TextStyle(color: Colors.blue),
        ), */
        trailing: CircleAvatar(),
      );

  get grid => Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: GridView.count(
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            crossAxisCount: 2,
            childAspectRatio: .90,
            children: categories.map((category) {
              return InkWell(
                onTap: () => {
                  //final snackBar = SnackBar(content: Text('Tap'));
                  //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  debugPrint('movieTitle: e')
                },
                child: Card(
                  /*  width: 200,
                  height: 200,
                  color: Colors.blue, */
                  //elevation: 2,
                /*   shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)), */
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(category['icon']),
                        Text(category['name'])
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
} */
