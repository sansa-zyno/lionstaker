import 'dart:convert';
import 'dart:developer';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/services/local_storage.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';

class PointHistory extends StatefulWidget {
  PointHistory({Key? key}) : super(key: key);

  @override
  State<PointHistory> createState() => _PointHistoryState();
}

class _PointHistoryState extends State<PointHistory> {
  List? pointHistory;
  Future getData() async {
    String username = await LocalStorage().getString("username");
    print(username);
    final res =
        await HttpService.post(Api.pointHistory, {"username": username});
    pointHistory = jsonDecode(res.data);
    log(pointHistory.toString());
    setState(() {});
  }

  String calcTimesAgo(DateTime dt) {
    Duration dur = DateTime.now().difference(dt);
    print(dur.inHours);
    if (dur.inSeconds < 60) {
      return dur.inSeconds == 1
          ? "${dur.inSeconds} sec ago"
          : "${dur.inSeconds} sec ago";
    }
    if (dur.inMinutes >= 1 && dur.inMinutes < 60) {
      return dur.inMinutes == 1
          ? "${dur.inMinutes} min ago"
          : "${dur.inMinutes} mins ago";
    }
    if (dur.inHours >= 1 && dur.inHours < 60) {
      return dur.inHours == 1
          ? "${dur.inHours} hour ago"
          : "${dur.inHours} hours ago";
    }
    if (dur.inHours > 60) {
      DateTime dateNow =
          DateTime.parse(DateTime.now().toString().substring(0, 10));
      DateTime dte = DateTime.parse(dt.toString().substring(0, 10));
      String date = dateNow.compareTo(dte) == 0
          ? "Today"
          : "${dte.year} ${dte.month} ${dte.day}" ==
                  "${dateNow.year} ${dateNow.month} ${(dateNow.day) - 1}"
              ? "Yesterday"
              : formatDate(dte, [M, ' ', dd, ', ', yyyy]);
      return date;
    }
    return "";
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
      wid: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  offset: Offset(2, 2),
                  color: Colors.grey.withOpacity(0.2))
            ]),
        child: pointHistory != null
            ? pointHistory!.isNotEmpty
                ? Column(
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
                            "Point History",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Spacer()
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Hi Chris, you’ve a total of 1,130 points Today!"),
                      Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.only(
                              top: 10,
                            ),
                            itemCount: pointHistory!.length,
                            itemBuilder: (ctx, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: buttoncolor),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                        "${pointHistory![index]["point"]} bonus has been added as your ${pointHistory![index]["ptype"]} bonus ${calcTimesAgo(DateTime.parse(pointHistory![index]["datte"]))}")))),
                      ),
                    ],
                  )
                : Center(child: Text("No data to show"))
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
