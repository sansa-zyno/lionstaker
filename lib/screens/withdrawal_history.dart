import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/services/local_storage.dart';

class WithdrawalHistory extends StatefulWidget {
  const WithdrawalHistory({Key? key}) : super(key: key);

  @override
  State<WithdrawalHistory> createState() => _WithdrawalHistoryState();
}

class _WithdrawalHistoryState extends State<WithdrawalHistory> {
  List? tableDatas;

  getData() async {
    /*String username = await LocalStorage().getString("username");
    final table =
        await HttpService.post(Api.withdrawalHistory, {"username": username});
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
    return tableDatas != null
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: [
                  DataColumn2(
                    label: Text('No',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: Text('Amount',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                  ),
                  DataColumn(
                    label: Text('Date',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                  ),
                  DataColumn(
                    label: Text('Status',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                  ),
                ],
                rows: tableDatas!.isNotEmpty
                    ? List<DataRow>.generate(
                        tableDatas!.length,
                        (index) => DataRow(cells: [
                              DataCell(Text("${index + 1}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                              DataCell(Text(
                                  "\u20A6${tableDatas![index]["amt"]}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                              DataCell(Text("${tableDatas![index]["date"]}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                              DataCell(Text("${tableDatas![index]["status"]}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                            ]))
                    : []),
          )
        : Center(child: SpinKitDualRing(color: mycolor));
  }
}
