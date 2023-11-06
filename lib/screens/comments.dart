import 'dart:convert';
import 'dart:developer';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/services/local_storage.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';

class CommentScreen extends StatefulWidget {
  final String postID;
  CommentScreen(this.postID);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final _scacffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController commentController = TextEditingController(text: '');
  List? comments;
  String? username;
  getComments() async {
    username = await LocalStorage().getString("username");
    Response res =
        await HttpService.post(Api.getPostComments, {"postid": widget.postID});
    log(res.toString());
    comments = jsonDecode(res.data);
    setState(() {});
  }

  Future<String> getImage(String username) async {
    Response res =
        await HttpService.post(Api.getProfilePics, {"username": username});
    String imageUrl = jsonDecode(res.data)[0]["avatar"];
    return imageUrl;
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
    getComments();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
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
                "Comments",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer()
            ],
          ),
          Divider(
            color: Colors.black45,
            thickness: 1,
          ),
          Expanded(
            child: Stack(children: [
              comments != null
                  ? comments!.isNotEmpty
                      ? Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: ListView.builder(
                              padding: EdgeInsets.all(0),
                              physics: BouncingScrollPhysics(),
                              itemCount: comments!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: FutureBuilder<String>(
                                      future: getImage(
                                          comments![index]["username"]),
                                      builder: (context, snap) {
                                        return CircleAvatar(
                                          radius: 20,
                                          child: Center(
                                              child: snap.hasData
                                                  ? snap.data!.isNotEmpty
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          child: Image.network(
                                                            "https://lionstaker.com/office/${snap.data}",
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
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${comments![index]["username"]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(
                                          "${calcTimesAgo(DateTime.parse(comments![index]["datte"]))}",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle:
                                      Text("${comments![index]["comment"]}"),
                                );
                              }))
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child:
                              Center(child: Text("No comments on this post")))
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: CircularProgressIndicator())),
              Positioned(
                bottom: 0,
                left: 0,
                width: MediaQuery.of(context).size.width - 16,
                child: _commentRow(widget.postID),
              )
            ]),
          ),
        ],
      ),
    );
  }

  Widget _commentRow(String postID) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                //filled: true,
                //fillColor: Colors.white60,
                border: InputBorder.none,
                hintText: 'Write Your Comment',
                prefix: Text("  "),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: GestureDetector(
                      onTap: () async {
                        Response res = await HttpService.post(Api.addComments, {
                          "sender": username,
                          "postid": postID,
                          "comment": commentController.text
                        });
                        if (res.data == "Success") {
                          commentController.text = "";
                          getComments();
                        }
                      },
                      child: Text(
                        "Post",
                        style: TextStyle(color: buttoncolor),
                      )),
                ),
                /*suffixIconConstraints: BoxConstraints(
                      maxHeight: 35, minHeight: 35, maxWidth: 35, minWidth: 35)*/
              ),
            ),
          ),
        ],
      ),
    );
  }
}
