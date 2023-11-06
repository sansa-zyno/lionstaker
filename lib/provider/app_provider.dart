import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:date_format/date_format.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/services/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../services/http.service.dart';

class AppProvider extends ChangeNotifier {
  String type = "";
  bool reply = false;
  String senderReplied = "";
  String chatid = "";
  String msgreplied = "";

  List? feeds;
  List? forumData;
  List? chatData;
  List? notifications;
  List? recentChatData;
  String imageUrl = "";
  Timer? timer;

  List winOrNot = [];
  List spamOrNot = [];
  List liked = [];
  List unliked = [];
  List followed = [];
  BuildContext? mainContext;

  AppProvider() {
    getUsername().then((username) {
      getFeeds(username);
      RecentChatData(username);
      getImage(username);
    });
    timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await getNotifications();
      if (mainContext != null) {
        log("maincontext not null");
        notifi(mainContext!);
      }
    });
    getWinOrNot();
    getSpamOrNot();
    getLiked();
    getUnLiked();
    getFollowed();
  }

  /* @override
  dispose() {
    timer!.cancel();
    super.dispose();
  }*/

  disp() {
    timer!.cancel();
    timer = null;
  }

  getMainContext(BuildContext context) {
    mainContext = context;
  }

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

  Future<String> getImageFromNotifi(String username) async {
    Response res =
        await HttpService.post(Api.getProfilePics, {"username": username});
    String imageUrl = jsonDecode(res.data)[0]["avatar"];
    return imageUrl;
  }

  notifi(BuildContext context) async {
    //AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    LocalStorage().getString("notification").then((value) => null
        //log("notification ${value.toString()}")
        );
    var savedStringNotification =
        await LocalStorage().getString("notification");
    Map savedMapNotification = savedStringNotification != null
        ? jsonDecode(savedStringNotification.toString())
        : {};
    //log("passed jsondecode error");
    //log((notifications!.first["id"] != savedMapNotification["id"]).toString());
    if (notifications != null && notifications!.isNotEmpty) {
      if (notifications!.first["id"] != savedMapNotification["id"]) {
        String timesAgo =
            calcTimesAgo(DateTime.parse(notifications!.first["dattee"]));
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Notification",
                        style: TextStyle(
                            color: Color(0xff4B0973),
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      InkWell(
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 30,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  insetPadding: EdgeInsets.all(8),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        FutureBuilder<String>(
                            future:
                                getImageFromNotifi(notifications!.first["ddo"]),
                            builder: (context, snap) {
                              return CircleAvatar(
                                radius: 20,
                                child: Center(
                                    child: snap.hasData
                                        ? snap.data!.isNotEmpty
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Image.network(
                                                  "$appUrl/${snap.data}",
                                                  height: 40,
                                                  width: 40,
                                                  fit: BoxFit.cover,
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
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${notifications!.first["ddo"]} posted a new ${notifications!.first["ntype"]} ${timesAgo} with a total odd of ${notifications!.first["todd"]}",
                          style: TextStyle(color: Colors.black),
                          softWrap: true,
                        )
                      ],
                    ),
                  ),
                ));
        LocalStorage()
            .setString("notification", jsonEncode(notifications!.first));
        //log("notification saved ${notifications!.first}");
      }
    }
  }

  Future<String> getUsername() async {
    String username = await LocalStorage().getString("username");
    return username;
  }

  Future getFeeds(username) async {
    final res = await HttpService.post(Api.feeds, {"username": username});
    feeds = jsonDecode(res.data);
    log(feeds.toString());
    notifyListeners();
  }

  updateVal(String msg, String typ, bool rep, String sender, String chatId) {
    msgreplied = msg;
    type = typ;
    reply = rep;
    senderReplied = sender;
    chatid = chatId;
    notifyListeners();
  }

  getForumData() async {
    Response response = await HttpService.post(Api.forum, {});
    forumData = jsonDecode(response.data);
    notifyListeners();
    log(forumData.toString());
  }

  getChatData(String sender, String receiver) async {
    chatData = null;
    notifyListeners();
    Response response = await HttpService.post(
        Api.chat, {"sender": sender, "receiver": receiver});
    chatData = jsonDecode(response.data);
    notifyListeners();
    //log(chatData.toString());
  }

  RecentChatData(String username) async {
    Response response =
        await HttpService.post(Api.recentChats, {"username": username});

    recentChatData = jsonDecode(response.data);
    notifyListeners();
    //log(recentChatData.toString());
  }

  Future getNotifications() async {
    Response response = await HttpService.post(Api.notifications, {});
    notifications = jsonDecode(response.data);
    notifyListeners();
  }

  getImage(String username) async {
    try {
      Response res =
          await HttpService.post(Api.getProfilePics, {"username": username});
      imageUrl = jsonDecode(res.data)[0]["avatar"];
    } catch (e) {
      imageUrl = "";
    }
    notifyListeners();
  }

  getWinOrNot() async {
    String stringList = await LocalStorage().getString("winOrNot") ?? "";
    winOrNot = stringList.isNotEmpty ? jsonDecode(stringList) : [];
    notifyListeners();
  }

  getSpamOrNot() async {
    String stringList = await LocalStorage().getString("spamOrNot") ?? "";
    spamOrNot = stringList.isNotEmpty ? jsonDecode(stringList) : [];
    notifyListeners();
  }

  getLiked() async {
    String stringList = await LocalStorage().getString("liked") ?? "";
    liked = stringList.isNotEmpty ? jsonDecode(stringList) : [];
    notifyListeners();
  }

  getUnLiked() async {
    String stringList = await LocalStorage().getString("unliked") ?? "";
    unliked = stringList.isNotEmpty ? jsonDecode(stringList) : [];
    notifyListeners();
  }

  getFollowed() async {
    String stringList = await LocalStorage().getString("followed") ?? "";
    followed = stringList.isNotEmpty ? jsonDecode(stringList) : [];
    notifyListeners();
  }
}
