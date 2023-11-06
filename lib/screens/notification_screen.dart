import 'dart:convert';
import 'dart:developer';
import 'package:social_betting_predictions/screens/chat/chat_screen.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/provider/app_provider.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/services/local_storage.dart';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';
import 'package:social_betting_predictions/widgets/menu.dart';

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String calcTimesAgo(DateTime dt) {
    Duration dur = DateTime.now().difference(dt);
    log("duration in hours " + dur.inHours.toString());
    if (dur.inSeconds < 60) {
      return dur.inSeconds == 1
          ? "${dur.inSeconds} second ago"
          : "${dur.inSeconds} seconds ago";
    }
    if (dur.inMinutes >= 1 && dur.inMinutes < 60) {
      return dur.inMinutes == 1
          ? "${dur.inMinutes} minute ago"
          : "${dur.inMinutes} minutes ago";
    }
    if (dur.inHours >= 1 && dur.inHours < 24) {
      return dur.inHours == 1
          ? "${dur.inHours} hour ago"
          : "${dur.inHours} hours ago";
    }
    if (dur.inHours >= 24) {
      DateTime dateNow =
          DateTime.parse(DateTime.now().toString().substring(0, 10));
      DateTime dte = DateTime.parse(dt.toString().substring(0, 10));
      String date = "${dte.year} ${dte.month} ${dte.day}" ==
              "${dateNow.year} ${dateNow.month} ${(dateNow.day) - 1}"
          ? "1 day ago"
          : "${dte.year} ${dte.month} ${dte.day}" ==
                  "${dateNow.year} ${dateNow.month} ${(dateNow.day) - 2}"
              ? "2 days ago"
              : "${dte.year} ${dte.month} ${dte.day}" ==
                      "${dateNow.year} ${dateNow.month} ${(dateNow.day) - 3}"
                  ? "3 days ago"
                  : "${dte.year} ${dte.month} ${dte.day}" ==
                          "${dateNow.year} ${dateNow.month} ${(dateNow.day) - 4}"
                      ? "4 days ago"
                      : "${dte.year} ${dte.month} ${dte.day}" ==
                              "${dateNow.year} ${dateNow.month} ${(dateNow.day) - 5}"
                          ? "5 days ago"
                          : "${dte.year} ${dte.month} ${dte.day}" ==
                                  "${dateNow.year} ${dateNow.month} ${(dateNow.day) - 6}"
                              ? "6 days ago"
                              : formatDate(dte, [M, ' ', dd, ', ', yyyy]);
      return date;
    }
    return "";
  }

  Future<String> getImage(String username) async {
    Response res =
        await HttpService.post(Api.getProfilePics, {"username": username});
    String imageUrl = jsonDecode(res.data)[0]["avatar"];
    return imageUrl;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
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
      child: appProvider.notifications != null
          ? appProvider.notifications!.isEmpty
              ? Container(
                  margin: EdgeInsets.only(left: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/undraw_Notify_re_65on 1.png'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          "It seems like you don’t have any Notificationss yet. Check back later.",
                          style: TextStyle(
                              color: Color(0xff242A37),
                              fontFamily: 'SFUIText-Regular',
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
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
                          "Notifications",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Spacer()
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(0),
                        itemCount: appProvider.notifications!.length,
                        itemBuilder: (context, index) {
                          String timesAgo = calcTimesAgo(DateTime.parse(
                              appProvider.notifications![index]["dattee"]));
                          return GestureDetector(
                            onTap: () async {
                              /* await HttpService.post(Api.resetRead, {
                                      "username": appProvider.recentChatData![index]
                                          ["Receiver"],
                                      "messageid": appProvider.recentChatData![index]
                                          ["Chat Id"],
                                      "message": appProvider.recentChatData![index]
                                          ["Recent Chats"]
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => ChatScreen(
                                                  senderName:
                                                      appProvider.recentChatData![index]
                                                          ["Receiver"],
                                                  receiverName: appProvider
                                                      .recentChatData![index]["Sender"],
                                                  receiverProfilePics:
                                                      appProvider.recentChatData![index]
                                                          ["ProfileImage"],
                                                )));
                                    appProvider.RecentChatData(
                                        appProvider.recentChatData![index]["Receiver"]);*/
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8.0),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: buttoncolor),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      FutureBuilder<String>(
                                          future: getImage(appProvider
                                              .notifications![index]["ddo"]),
                                          builder: (context, snap) {
                                            return CircleAvatar(
                                              radius: 20,
                                              child: Center(
                                                  child: snap.hasData
                                                      ? snap.data!.isNotEmpty
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              child:
                                                                  Image.network(
                                                                "$appUrl/${snap.data}",
                                                                height: 40,
                                                                width: 40,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )
                                                          : Image.asset(
                                                              "assets/user.png",
                                                              height: 30,
                                                              width: 30,
                                                              fit: BoxFit.cover,
                                                            )
                                                      : Center(
                                                          child:
                                                              CircularProgressIndicator())),
                                            );
                                          }),
                                    ],
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Text(
                                      "${appProvider.notifications![index]["ddo"]} posted a new ${appProvider.notifications![index]["ntype"]} ${timesAgo} with a total odd of ${appProvider.notifications![index]["todd"]}",
                                      style: TextStyle(color: Colors.black),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (ctx, index) => Divider(),
                      ),
                    ),
                  ],
                )
          : Center(child: CircularProgressIndicator()),
    ));
  }
}
