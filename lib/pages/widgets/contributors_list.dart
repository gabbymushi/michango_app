import 'package:flutter/material.dart';
import 'package:michango/models/contributor.dart';
import 'package:michango/pages/widgets/add_contributor.dart';
import 'package:michango/pages/widgets/shared/bottom_nav_bar.dart';
import 'package:michango/pages/widgets/shared/michango_app_bar.dart';
import 'package:michango/pages/widgets/widget_home_category.dart';
import 'package:michango/services/contributor_service.dart';
import 'package:michango/utils/utils.dart';

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
        width: double.infinity, child: makeTable(_contributorModel));
  }
}

Widget makeTable(_contributorModel) {
  return FutureBuilder(
      future: _contributorModel,
      builder: (context, contributorSnap) {
        if (!contributorSnap.hasData) {
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
                        'PLEDGE: ${Utils.formatMoney(contributorSnap.data[index].pledgedAmount)}',
                        style: TextStyle(
                          fontFamily: 'Encode Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'PAID: ${Utils.formatMoney(contributorSnap.data[index].paidAmount)}',
                        style: TextStyle(
                          fontFamily: 'Encode Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'BALANCE: ${Utils.formatMoney(contributorSnap.data[index].pledgedAmount - contributorSnap.data[index].paidAmount)}',
                        style: TextStyle(
                          fontFamily: 'Encode Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  leading: CircleAvatar(
                      child: Text(contributorSnap.data[index].fullName[0]
                          .toUpperCase())),
                  trailing: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        showDialogWithFields(
                            context,
                            contributorSnap.data[index].fullName.toUpperCase(),
                            contributorSnap.data[index].pledgedAmount,
                            contributorSnap.data[index].paidAmount,
                            contributorSnap.data[index].id);
                      }),
                ),
              );
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
                prefixIcon: Icon(Icons.search),
                labelText: 'Search',
                hintText: 'Search by name or phone no'),
          ),
        ),
        Expanded(
            child: SizedBox(
          // padding: EdgeInsets.all(0),
          height: 200,
          child: ContributorsList(),
        ))
      ],
    ),
  );
}

void showDialogWithFields(context, name, pledge, paidAmount, contributorId) {
  num balance = pledge - paidAmount;

  showDialog(
    context: context,
    builder: (_) {
      TextEditingController _amount = TextEditingController();

      return AlertDialog(
        title: Text(
          'ADD CONTRIBUTION',
          style: TextStyle(
            fontFamily: 'Encode Sans',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        content: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 7),
              child: Row(
                children: [
                  Text('Contributor: ',
                      style: TextStyle(
                          fontFamily: 'Encode Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey[600])),
                  Flexible(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Encode Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 7),
              child: Row(
                children: [
                  Text(
                    'Pledge: ',
                    style: TextStyle(
                        fontFamily: 'Encode Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.grey[600]),
                  ),
                  Text(
                    Utils.formatMoney(pledge),
                    style: TextStyle(
                      fontFamily: 'Encode Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      //color: Colors.yellow[600]
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 7),
              child: Row(
                children: [
                  Text(
                    'Paid Amount: ',
                    style: TextStyle(
                        fontFamily: 'Encode Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.grey[600]),
                  ),
                  Text(
                    Utils.formatMoney(paidAmount),
                    style: TextStyle(
                      fontFamily: 'Encode Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      //color: Colors.green
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 7),
              child: Row(
                children: [
                  Text(
                    'Balance: ',
                    style: TextStyle(
                        fontFamily: 'Encode Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.grey[600]),
                  ),
                  Text(
                    Utils.formatMoney(balance),
                    style: TextStyle(
                        fontFamily: 'Encode Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.red),
                  )
                ],
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _amount,
              decoration: InputDecoration(
                hintText: 'Amount',
                border: OutlineInputBorder(),
              ),
              maxLines: 1,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Map contribution = {
                'amount': _amount.text == '' ? 0 : _amount.text
              };

              await _submitForm(context, contribution, contributorId);

              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  ).then((_) => Navigator.pushNamed(context, "/michango"));
}

Future _submitForm(context, contribution, contributorId) async {
  try {
    ContributorService contributorService = new ContributorService();

    await contributorService.recordContribution(contribution, contributorId);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: const Text("Contribution added successfully."),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red),
    );
  }
}
