import 'package:flutter/material.dart';
import 'package:michango/pages/widgets/add_contributor.dart';
import 'package:michango/pages/widgets/contributors_list.dart';
import 'package:michango/pages/widgets/widget_home_category.dart';
//import 'pages/widgets/drawer.dart';

void main() {
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.redAccent,
      ),
      home: MichangoApp(),
    ),
  );
}

class MichangoApp extends StatelessWidget {
  void _openAddEntryDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) {
            return AddEntryDialog();
          },
          fullscreenDialog: true),
    );
    //Navigator.of(context).push(AddEntryDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HARUSI YA FRANK.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddEntryDialog(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _uisetup(),
      //drawer: MyDrawer(),
    );
  }
}

/* void _openAddEntryDialog(){
  Navigator.of(context).push(MaterialPageRoute<null>(builder: (Build context){
    return new AddEntryDialog();
  },
  fullScreenDialog:true,);
} */

Widget _uisetup() {
  return Container(
    alignment: Alignment.center,
    child: Column(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(0),
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              DashboardItems(),
              ContributorsList()
              //Text('Widget 2'),
            ],
          ),
        ))

      ],
    ),
  );
}
