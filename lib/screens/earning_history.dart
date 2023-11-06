import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/services/local_storage.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';
import 'package:social_betting_predictions/widgets/menu.dart';

class EarningHistory extends StatefulWidget {
  const EarningHistory({Key? key}) : super(key: key);

  @override
  State<EarningHistory> createState() => _EarningHistoryState();
}

class _EarningHistoryState extends State<EarningHistory> {
  List? tableDatas;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  getData() async {
    /*String username = await LocalStorage().getString("username");
    final table =
        await HttpService.post(Api.fundingHistory, {"username": username});
    tableDatas = jsonDecode(table.data);
    setState(() {});*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
              "Earning History",
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
          height: 8,
        ),
        DataTable2(
            columnSpacing: 8,
            horizontalMargin: 8,
            minWidth: 600,
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
                size: ColumnSize.S,
              ),
              DataColumn(
                label: Text('Amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              DataColumn(
                label: Text('Username',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              DataColumn(
                label: Text('Reason',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              DataColumn(
                label: Text('Downline',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              DataColumn(
                label: Text('Date',
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
                          DataCell(Text("${tableDatas![index]["mName"]}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                          DataCell(Text("${tableDatas![index]["subject"]}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                          DataCell(Text("${tableDatas![index]["message"]}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                          DataCell(Text("${tableDatas![index]["reply"]}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                          DataCell(Text("${tableDatas![index]["date"]}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                        ]))
                : []),
      ],
    ));
  }
}
