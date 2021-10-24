import 'package:flutter/material.dart';
import 'package:michango/utils/hex_color.dart';

class DashboardItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildListCategory(context),
        ],
      ),
    );
  }
}

_buildListCategory(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);

  return Container(
    height: 100,
    child: GridView.count(
      crossAxisCount: 3,
      children: [
        makeDashboardItem(
            mediaQueryData,
            "Ahadi",
            "#FFCD42",
            Icon(Icons.help),
            Border(
              right: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
              bottom: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            () => {}),
        makeDashboardItem(
            mediaQueryData,
            "Makusanyo",
            "#3FC379",
            Icon(Icons.verified_user),
            Border(
              right: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
              bottom: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            () => {}),
        makeDashboardItem(
            mediaQueryData,
            "Deni",
            "#D13839",
            Icon(Icons.file_copy),
            Border(
              right: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
              bottom: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            () => {}),
      ],
    ),
  );
}

Card makeDashboardItem(MediaQueryData query, String title, String color,
    Icon icon, Border border, Function onTap) {
  double width = query.size.width;
  double fontSize = (width * 4) / 100;
  double imageSize = (width * 18) / 100;

  return Card(
    elevation: 5,
    color: HexColor(color),
    margin: EdgeInsets.all(5.0),
    child: Container(
      decoration: BoxDecoration(color: new HexColor(color)),
      child: Center(
        child: new InkWell(
          onTap: onTap,
          child: FractionalTranslation(
            translation: Offset(0.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: [
                Center(
                  child: ClipOval(
                    child: Container(
                      height: imageSize,
                      width: imageSize,
                      child: Center(
                        child: icon,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                new Center(
                  child: new Text(
                    title.toUpperCase(),
                    style: new TextStyle(
                        fontSize: fontSize,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 5.0)
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
