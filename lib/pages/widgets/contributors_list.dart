import 'package:flutter/material.dart';
import 'package:michango/models/contributor.dart';
import 'package:michango/pages/widgets/add_contributor.dart';
import 'package:michango/pages/widgets/shared/bottom_nav_bar.dart';
import 'package:michango/pages/widgets/shared/michango_app_bar.dart';
import 'package:michango/pages/widgets/widget_home_category.dart';
import 'package:michango/services/contributor_service.dart';
import 'package:michango/utils/format_money.dart';

class Michango extends StatelessWidget {
  void _openAddEntryDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) {
            return AddEntryDialog();
          },
          fullscreenDialog: true),
    ).then((_) => Navigator.pushNamed(context, "/michango"));
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
    super.initState();
    _contributorModel = ContributorService().getContributors();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: makeTable(_contributorModel),
      /*     child: FittedBox(
        child: FutureBuilder(
          future: _contributorModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return makeTable(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ), */
    );
  }
}

Widget makeTable(_contributorModel) {
  return FutureBuilder(
      future: _contributorModel,
      builder: (context, contributorSnap) {
        if (!contributorSnap.hasData) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: contributorSnap.data.length,
            itemBuilder: (context, index) {
              //padding: const EdgeInsets.all(8),
              return Card(
                  child: ListTile(
                      title: Text(
                        contributorSnap.data[index].fullName.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Encode Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Wrap(
                        direction: Axis.vertical,
                        children: <Widget>[
                          Text(
                            'PLEDGE: ${contributorSnap.data[index].pledgedAmount}',
                            style: TextStyle(
                              fontFamily: 'Encode Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'PAID: ${FormatMoney.formatMoney(contributorSnap.data[index].paidAmount)}',
                            style: TextStyle(
                              fontFamily: 'Encode Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'BALANCE: ${contributorSnap.data[index].paidAmount}',
                            style: TextStyle(
                              fontFamily: 'Encode Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      leading: CircleAvatar(
                          child: Text(contributorSnap.data[index].fullName[0].toUpperCase())),
                      trailing: Icon(Icons.add)));
            });
      });
}

Widget _uisetup() {
  return Container(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DashboardItems(),
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 10, bottom: 10),
          //padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            //controller: _password,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                //border: UnderlineInputBorder(),
                //suffixIcon: Icon(Icons.search),
                prefixIcon: Icon(Icons.search),
                labelText: 'Search',
                hintText: 'Search by name or phone no'),
            /*  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  }, */
          ),
        ),
        Expanded(
            child: SizedBox(
          // padding: EdgeInsets.all(0),
          height: 200,
          child: ContributorsList(),
          /*  child: Column(
            children: [
              //DashboardItems(),
              ContributorsList()
              //Text('Widget 2'),
            ],
          ), */
          /*     child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              DashboardItems(),
              ContributorsList()
              //Text('Widget 2'),
            ],
          ), */
        ))
      ],
    ),
  );
}
