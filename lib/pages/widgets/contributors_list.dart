import 'package:flutter/material.dart';
import 'package:michango/models/contributor.dart';
import 'package:michango/pages/widgets/add_contributor.dart';
import 'package:michango/pages/widgets/shared/bottom_nav_bar.dart';
import 'package:michango/pages/widgets/shared/michango_app_bar.dart';
import 'package:michango/pages/widgets/widget_home_category.dart';
import 'package:michango/services/contributor_service.dart';

class Michango extends StatelessWidget {
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
        appBar: MichangoAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openAddEntryDialog(context),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: _uisetup(),
        bottomNavigationBar: BottomNavBar());
  }
}

class ContributorsList extends StatefulWidget {
  @override
  _ContributorsList createState() => _ContributorsList();
}

class _ContributorsList extends State<ContributorsList> {
  Future<List<Contributor>> _contributorModel;

  @override
  void initState() {
    _contributorModel = ContributorService().getContributors();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FittedBox(
        child: FutureBuilder(
          future: _contributorModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return makeTable(snapshot.data);
            } else {
              return SizedBox(
                  child: new CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

Widget makeTable(List<Contributor> contributors) {
  return DataTable(
    columns: [
      DataColumn(
          label: Text('SN',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Jina',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Ahadi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Katoa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Baki',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    ],
    rows: contributors
        .map((contributor) => DataRow(cells: [
              DataCell(Text('1', style: TextStyle(fontSize: 14))),
              DataCell(
                  Text(contributor.fullName, style: TextStyle(fontSize: 16))),
              DataCell(Text(contributor.amount.toString(),
                  style: TextStyle(fontSize: 14))),
              DataCell(Text(contributor.balance.toString(),
                  style: TextStyle(fontSize: 14))),
              DataCell(Text(contributor.balance.toString(),
                  style: TextStyle(fontSize: 14))),
            ]))
        .toList(),
  );
}

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
