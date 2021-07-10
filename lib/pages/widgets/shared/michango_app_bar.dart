import 'package:flutter/material.dart';

class MichangoAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: DropdownButton<String>(
          value: 'HARUSI YA FRANK',
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w200,
              fontFamily: 'Encode Sans'),
          /*    underline: Container(
                height: 2,
                color: Colors.white,
              ), */
          onChanged: (String newValue) {
            /*   setState(() {
          dropdownValue = newValue!;
        }); */
          },
          items: <String>['HARUSI YA FRANK', 'SENDOFF YA ESHER']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
