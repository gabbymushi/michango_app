import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      //backgroundColor: Color(0xFF6200EE),
      backgroundColor: Colors.cyan[600],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(.60),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      onTap: (index) {
        // Respond to item press.
        switch (index) {
          case 0:
            Navigator.pushNamed(context, "/first");
            break;
          case 1:
            Navigator.pushNamed(context, "/second");
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Tuma SMS',
          icon: Icon(Icons.message),
        ),
        BottomNavigationBarItem(
          label: 'Mualiko',
          icon: Icon(Icons.card_giftcard),
        ),
        BottomNavigationBarItem(
          label: 'Settings',
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}
