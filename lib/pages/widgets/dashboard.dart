import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      'color': Colors.green[200],
      'title': 'Michango',
      'icon': Icons.monetization_on
    },
    {'color': Colors.pink[200], 'title': 'Wauzaji', 'icon': Icons.shop},
     {
      'color': Colors.purple[200],
      'title': 'Manage events',
      'icon': Icons.event
    },
    {'color': Colors.blue[200], 'title': 'Settings', 'icon': Icons.settings},
   

    /*   {'color': Colors.pink[200], 'title': 'Walk', 'icon': Icons.directions_walk},
    {'color': Colors.blue[200], 'title': 'Contact', 'icon': Icons.contact_mail},
    {
      'color': Colors.green[200],
      'title': 'Bicycle',
      'icon': Icons.directions_bike
    },
    {'color': Colors.pink[200], 'title': 'Boat', 'icon': Icons.directions_boat}, */
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (2 / 1),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        childrenDelegate: SliverChildListDelegate(
          categories
              .map(
                (data) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/michango');
                    },
                    child: Container(
                      width: 200,
                      height: 400,
                      padding: const EdgeInsets.all(5),
                      color: data['color'],
                      child: Column(
                        children: [
                          Icon(
                            data['icon'],
                            size: 40,
                          ),
                          Text(data['title'],
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    )),
              )
              .toList(),
        ));
  }
}
