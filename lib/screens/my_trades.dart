import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';
import 'package:social_betting_predictions/widgets/menu.dart';

class MyTrades extends StatefulWidget {
  const MyTrades({Key? key}) : super(key: key);

  @override
  State<MyTrades> createState() => _MyTradesState();
}

class _MyTradesState extends State<MyTrades> {
  List? tableDatas;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /* getData() async {
    String username = await LocalStorage().getString("username");
    final table =
        await HttpService.post(Api.incentivesHistory, {"username": username});
    tableDatas = jsonDecode(table.data);
    setState(() {});
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseUI(
        wid: Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 8,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                )),
            Spacer(),
            Text(
              "View My Trades",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer()
          ],
        ),
        Divider(
          color: Colors.black45,
          thickness: 1,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Hi Aderele, Here is your trade history so far",
          style: TextStyle(),
        ),
        SizedBox(
          height: 15,
        ),
        DataTable2(
            columnSpacing: 8,
            horizontalMargin: 8,
            minWidth: 700,
            smRatio: 0.5, //changed
            lmRatio: 1.2, //default
            headingTextStyle: TextStyle(color: Colors.white),
            headingRowColor: MaterialStateProperty.all(Colors.black),
            columns: [
              DataColumn2(
                  label: Text('No',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  size: ColumnSize.S),
              DataColumn(
                label: Text('Trade Amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              DataColumn(
                label: Text('Initiated By',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              DataColumn(
                label: Text('Action',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              DataColumn(
                label: Text('Status',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
            rows: tableDatas != null && tableDatas!.isNotEmpty
                ? List<DataRow>.generate(
                    tableDatas!.length,
                    (index) => DataRow(cells: [
                          DataCell(Text("${index + 1}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                          DataCell(Text("${tableDatas![index]["Tamt"]}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                          DataCell(Text("${tableDatas![index]["Iby"]}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                          DataCell(Text("${tableDatas![index]["action"]}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                          DataCell(Text("${tableDatas![index]["status"]}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                        ]))
                : []),
      ],
    ));
  }
}
