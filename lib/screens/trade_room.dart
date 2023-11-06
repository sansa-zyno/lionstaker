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

class TradeRoom extends StatefulWidget {
  const TradeRoom({Key? key}) : super(key: key);

  @override
  State<TradeRoom> createState() => _TradeRoomState();
}

class _TradeRoomState extends State<TradeRoom> {
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
                "Trade Room",
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
            "Hi Aderele, Welcome to your trade room",
            style: TextStyle(),
          ),
          SizedBox(
            height: 15,
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
                  label: Text('Merchant Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                DataColumn(
                  label: Text('Trade Amount',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                DataColumn(
                  label: Text('Initiate',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                )
              ],
              rows: tableDatas != null && tableDatas!.isNotEmpty
                  ? List<DataRow>.generate(
                      tableDatas!.length,
                      (index) => DataRow(cells: [
                            DataCell(Text("${index + 1}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text("${tableDatas![index]["mName"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Text(
                                "\u20A6${tableDatas![index]["tAmount"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                            DataCell(Container(
                              color: Colors.teal,
                              padding: EdgeInsets.all(8),
                              child: Text("Purchase",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            )),
                          ]))
                  : [])
        ],
      ),
    );
  }
}
