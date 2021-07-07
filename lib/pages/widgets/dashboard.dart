import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: MaterialButton(
                  height: 100.0,
                  minWidth: 130.0,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text("Michango"),
                  onPressed: () => {},
                  splashColor: Colors.redAccent,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: MaterialButton(
                  height: 100.0,
                  minWidth: 130.0,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text("Ukumbi"),
                  onPressed: () => {},
                  splashColor: Colors.redAccent,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: MaterialButton(
                  height: 100.0,
                  minWidth: 130.0,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text("MCs"),
                  onPressed: () => {},
                  splashColor: Colors.redAccent,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: MaterialButton(
                  height: 100.0,
                  minWidth: 130.0,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text("Wapiga Picha"),
                  onPressed: () => {},
                  splashColor: Colors.redAccent,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
