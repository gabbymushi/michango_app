import 'package:flutter/material.dart';

class ContributorsList extends StatefulWidget {
  @override
  _ContributorsList createState() => _ContributorsList();
}

class _ContributorsList extends State<ContributorsList> {
  @override
  Widget build(BuildContext context) {
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
      /*   DataColumn(
            label: Text('Katoa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        DataColumn(
            label: Text('Baki',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))), */
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('1')),
          DataCell(Text('Stephen')),
          DataCell(Text('100,000')),
         /*  DataCell(Text('50,000')),
          DataCell(Text('50,000')), */
        ]),
        DataRow(cells: [
          DataCell(Text('2')),
          DataCell(Text('John')),
          DataCell(Text('100,000')),
         /*  DataCell(Text('50,000')),
          DataCell(Text('50,000')), */
        ]),
        DataRow(cells: [
          DataCell(Text('3')),
          DataCell(Text('Harry')),
          DataCell(Text('100,000')),
         /*  DataCell(Text('50,000')),
          DataCell(Text('50,000')), */
        ]),
        DataRow(cells: [
          DataCell(Text('4')),
          DataCell(Text('Peter')),
          DataCell(Text('100,000')),
         /*  DataCell(Text('50,000')),
          DataCell(Text('50,000')), */
        ]),
      ],
    );
  }
}
