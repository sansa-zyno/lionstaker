import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/provider/app_provider.dart';
import 'package:social_betting_predictions/screens/comments.dart';
import 'package:social_betting_predictions/screens/full_screen_image_wrapper.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/services/local_storage.dart';

class MainUi extends StatefulWidget {
  Map data;
  String username;
  MainUi({required this.data, required this.username, Key? key})
      : super(key: key);

  @override
  State<MainUi> createState() => _MainUiState();
}

class _MainUiState extends State<MainUi> {
  late String _localPath;

  Future<Map> getComments(String postid) async {
    Response res =
        await HttpService.post(Api.getPostComments, {"postid": postid});
    log("Comments " + res.data);
    List comments = jsonDecode(res.data);
    return comments.first;
  }

  Future<String> getImage(String username) async {
    Response res =
        await HttpService.post(Api.getProfilePics, {"username": username});
    String imageUrl = jsonDecode(res.data)[0]["avatar"];
    return imageUrl;
  }

  Future<String> getBookmakerLogo(String bookmaker) async {
    Response res =
        await HttpService.post(Api.betlogo, {"bookmaker": bookmaker});
    String logoUrl = res.data;
    log(logoUrl);
    return logoUrl;
  }

  prepare() async {
    await _prepareSaveDir();
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prepare();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: widget.data["BetTips"]["status"] == "0"
              ? null
              : widget.data["BetTips"]["status"] == "1"
                  ? Border.all(color: Color(0xff0e6dfd))
                  : Border.all(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0,
                offset: Offset(2, 2),
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 8,
              ),
              widget.data["ProfileImage"] != "https://lionstaker.com/lionl.jpg"
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        "$appUrl/${widget.data["ProfileImage"]}",
                        width: 40,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: RichText(
                    text: TextSpan(
                        style: GoogleFonts.nunito(
                            color: mycolor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        children: [
                      TextSpan(text: "${widget.data["FullName"]}"),
                      TextSpan(text: " "),
                      TextSpan(
                          style: TextStyle(color: Colors.grey),
                          text: "@${widget.data["BetTips"]["username"]}")
                    ])),
              ),
              Text(
                  "${calcTimesAgo(DateTime.parse(widget.data["BetTips"]["datte"]))}"),
              SizedBox(
                width: 8,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "${widget.data["BetTips"]["bookmaker"]}",
                      style: TextStyle(
                          color: buttoncolor, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 15),
                    FutureBuilder<String>(
                        future: getBookmakerLogo(
                            widget.data["BetTips"]["bookmaker"]),
                        builder: (context, snapshot) {
                          log(snapshot.data.toString() + " book maker image");
                          return snapshot.hasData
                              ? Image.network(
                                  snapshot.data!,
                                  height: 70,
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                  color: buttoncolor,
                                ));
                        })
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                    "${widget.data["BetTips"]["betcode"]} (${widget.data["BetTips"]["status"] == "0" ? "Pending" : widget.data["BetTips"]["status"] == "1" ? "Success" : "Failed"})"),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                            text: widget.data["BetTips"]["betcode"]))
                        .then((_) =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Betcode Copied",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              backgroundColor: buttoncolor,
                            )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Copy Betcode",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 60, right: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              widget.data["BetTips"]["status"] == "0"
                  ? Container(
                      height: 8,
                    )
                  : appProvider.winOrNot.isEmpty ||
                          !appProvider.winOrNot.contains(widget.data["ID"])
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              "DOES THIS CODE WIN?",
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    Response res =
                                        await HttpService.post(Api.betWin, {
                                      "sender": widget.username,
                                      "postid": widget.data["ID"],
                                    });
                                    if (res.data == "Success") {
                                      appProvider.winOrNot
                                          .add(widget.data["ID"]);
                                      appProvider.winOrNot.toSet();
                                      appProvider.winOrNot.toList();
                                      LocalStorage()
                                          .setString("winOrNot",
                                              jsonEncode(appProvider.winOrNot))
                                          .then((value) {
                                        appProvider.getWinOrNot();
                                      });
                                    }
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Text(
                                        "YES",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  onTap: () async {
                                    Response res =
                                        await HttpService.post(Api.betNotWin, {
                                      "sender": widget.username,
                                      "postid": widget.data["ID"],
                                    });
                                    if (res.data == "Success") {
                                      appProvider.winOrNot
                                          .add(widget.data["ID"]);
                                      appProvider.winOrNot.toSet();
                                      appProvider.winOrNot.toList();
                                      LocalStorage()
                                          .setString("winOrNot",
                                              jsonEncode(appProvider.winOrNot))
                                          .then((value) {
                                        appProvider.getWinOrNot();
                                      });
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    padding: EdgeInsets.all(8),
                                    child: Text("NO",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            )
                          ],
                        )
                      : Container(
                          height: 8,
                        ),
              appProvider.spamOrNot.isEmpty ||
                      !appProvider.spamOrNot.contains(widget.data["ID"])
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "IS THIS A SPAM?",
                          style: TextStyle(color: Colors.purple),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                Response res =
                                    await HttpService.post(Api.betIsSpam, {
                                  "sender": widget.username,
                                  "postid": widget.data["ID"],
                                });
                                if (res.data == "Success") {
                                  appProvider.spamOrNot.add(widget.data["ID"]);
                                  appProvider.spamOrNot.toSet();
                                  appProvider.spamOrNot.toList();
                                  LocalStorage()
                                      .setString("spamOrNot",
                                          jsonEncode(appProvider.spamOrNot))
                                      .then((value) {
                                    appProvider.getSpamOrNot();
                                  });
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Text("YES",
                                      style: TextStyle(color: Colors.white))),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                Response res =
                                    await HttpService.post(Api.betIsNotSpam, {
                                  "sender": widget.username,
                                  "postid": widget.data["ID"],
                                });
                                if (res.data == "Success") {
                                  appProvider.spamOrNot.add(widget.data["ID"]);
                                  appProvider.spamOrNot.toSet();
                                  appProvider.spamOrNot.toList();
                                  LocalStorage()
                                      .setString("spamOrNot",
                                          jsonEncode(appProvider.spamOrNot))
                                      .then((value) {
                                    appProvider.getSpamOrNot();
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                padding: EdgeInsets.all(8),
                                child: Text("NO",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    )
                  : Container(
                      height: 8,
                    ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(left: 60, right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ImageFullScreenWrapperWidget(
                      dark: false,
                      child: CachedNetworkImage(
                          imageUrl: "$appUrl/img/${widget.data["BetImage"]}",
                          width: 268,
                          //height: 350,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 50, bottom: 50),
                                child: Container(
                                  width: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                      color: buttoncolor,
                                    ),
                                  ),
                                ),
                              )),
                    )),
              ],
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 0, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LikeButton(int.parse("${widget.data["Likes"]}"),
                    widget.data["ID"], widget.username),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) =>
                                  CommentScreen(widget.data["ID"])));
                    },
                    child: Comments(int.parse("${widget.data["Comments"]}"))),
                UnLikeButton(int.parse("${widget.data["UnLikes"]}"),
                    widget.data["ID"], widget.username),
                IconButton(
                  onPressed: () async {
                    Response res = await HttpService.post(Api.sharePost, {
                      "username": widget.username,
                      "postid": widget.data["ID"]
                    });
                    if (res.statusCode == 200) {
                      Share.share(
                        res.data.toString(),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.share,
                    color: mycolor,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final taskId = await FlutterDownloader.enqueue(
                      url: "$appUrl/img/${widget.data["BetImage"]}",
                      savedDir: _localPath,
                      showNotification:
                          true, // show download progress in status bar (for Android)
                      openFileFromNotification:
                          true, // click on notification to open downloaded file (for Android)
                    );
                  },
                  icon: Icon(
                    Icons.download,
                    color: buttoncolor,
                  ),
                )
              ],
            ),
          ),
          /*SizedBox(height: 15),
          Divider(),*/
          Padding(
            padding: EdgeInsets.only(left: 60, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _commentRow(widget.data["ID"]),
                SizedBox(
                  height: 15,
                ),
                FutureBuilder<Map>(
                  future: getComments(widget.data["ID"]),
                  builder: (ctx, snapshot) => snapshot.hasData
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<String>(
                                future: getImage(snapshot.data!["username"]),
                                builder: (context, snap) {
                                  log("Commentter image " +
                                      snap.data.toString());
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: CircleAvatar(
                                      radius: 20,
                                      child: Center(
                                          child: snap.hasData
                                              ? snap.data!.isNotEmpty
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      child: Image.network(
                                                        snap.data.toString(),
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
                                                      CircularProgressIndicator(
                                                  color: buttoncolor,
                                                ))),
                                    ),
                                  );
                                }),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    width: 210,
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey[50],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Column(
                                      children: [
                                        /*Text("nice post",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15)),
                                                          SizedBox(
                                                            height: 8,
                                                          ),*/
                                        Text("${snapshot.data!["comment"]}",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      "Commented On : " +
                                          "${calcTimesAgo(DateTime.parse(snapshot.data!["datte"]))}",
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 12))
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _commentRow(String postID) {
    //TextEditingController commentController = TextEditingController(text: '');
    return Row(
      children: [
        CircleAvatar(
            backgroundColor: buttoncolor,
            child: Icon(
              Icons.person,
              color: Colors.white,
            )),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                //border: Border.all(),
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10.0,
                      offset: Offset(2, 2),
                      color: Colors.grey.withOpacity(0.2))
                ]),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  maxLines: 1,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => CommentScreen(postID)));
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefix: Text(" "),
                    hintText: "Write Your Comment",
                  ),
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LikeButton extends StatefulWidget {
  int totalLikes;
  final postId;
  final username;
  LikeButton(this.totalLikes, this.postId, this.username);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool like = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    return InkWell(
      onTap: () async {
        Response res = await HttpService.post(Api.addLikes, {
          "sender": widget.username,
          "postid": widget.postId,
        });
        log(res.data);
        if (res.data == "Success") {
          appProvider.getFeeds(widget.username);
          appProvider.liked.add(widget.postId);
          appProvider.liked.toSet();
          appProvider.liked.toList();
          LocalStorage()
              .setString("liked", jsonEncode(appProvider.liked))
              .then((value) {
            appProvider.getLiked();
          });
        }
      },
      child: Row(
        children: [
          Icon(
            Icons.thumb_up_off_alt,
            size: 18,
            color: appProvider.liked.isNotEmpty &&
                    appProvider.liked.contains(widget.postId)
                ? buttoncolor
                : mycolor,
          ),
          SizedBox(width: 8),
          Text(
            '${widget.totalLikes}',
            style: TextStyle(
                color: appProvider.liked.isNotEmpty &&
                        appProvider.liked.contains(widget.postId)
                    ? buttoncolor
                    : mycolor),
          ),
        ],
      ),
    );
  }
}

class UnLikeButton extends StatefulWidget {
  int totalUnLikes;
  final postId;
  final username;
  UnLikeButton(this.totalUnLikes, this.postId, this.username);

  @override
  _UnLikeButtonState createState() => _UnLikeButtonState();
}

class _UnLikeButtonState extends State<UnLikeButton> {
  bool like = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    return InkWell(
        onTap: () async {
          Response res = await HttpService.post(Api.addUnLikes, {
            "sender": widget.username,
            "postid": widget.postId,
          });
          log(res.data);
          if (res.data == "Success") {
            appProvider.getFeeds(widget.username);
            appProvider.unliked.add(widget.postId);
            appProvider.unliked.toSet();
            appProvider.unliked.toList();
            LocalStorage()
                .setString("unliked", jsonEncode(appProvider.unliked))
                .then((value) {
              appProvider.getUnLiked();
            });
          }
        },
        child: Row(
          children: [
            Icon(
              Icons.thumb_down_off_alt,
              size: 18,
              color: appProvider.unliked.isNotEmpty &&
                      appProvider.unliked.contains(widget.postId)
                  ? buttoncolor
                  : mycolor,
            ),
            SizedBox(width: 8),
            Text(
              '${widget.totalUnLikes}',
              style: TextStyle(
                color: appProvider.unliked.isNotEmpty &&
                        appProvider.unliked.contains(widget.postId)
                    ? buttoncolor
                    : mycolor,
              ),
            ),
          ],
        ));
  }
}

class Comments extends StatefulWidget {
  int comments;

  Comments(
    this.comments,
  );

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  // int docsLength;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*FirebaseFirestore.instance
        .collection(POSTS_COLLECTION)
        .doc(widget.id)
        .collection(POSTS_COMMENTS_SUBCOLLECTION)
        .snapshots()
        .listen((event) {
      docsLength = event.docs.length;
      setState(() {});
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.chat_bubble_outline),
        SizedBox(width: 8),
        Text(
          "${widget.comments}",
          style: TextStyle(color: mycolor),
        ),
      ],
    );
  }
}
