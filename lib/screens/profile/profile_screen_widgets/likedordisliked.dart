import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/widgets/main_ui.dart';

class LikesOrDislikes extends StatefulWidget {
  String username;
  LikesOrDislikes({Key? key, required this.username}) : super(key: key);

  @override
  State<LikesOrDislikes> createState() => _LikesOrDislikesState();
}

class _LikesOrDislikesState extends State<LikesOrDislikes> {
  int i = 5;
  Future<List> getLikedOrDislikedPosts() async {
    Response res = await HttpService.post(
        Api.likedOrDislikedPosts, {"username": widget.username});
    log(res.data);
    List posts = jsonDecode(res.data);
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List?>(
      future: getLikedOrDislikedPosts(),
      builder: (ctx, snapshot) {
        return snapshot.hasData
            ? snapshot.data!.isNotEmpty
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return index != (snapshot.data!.take(i).toList().length)
                          ? MainUi(
                              data: snapshot.data![index],
                              username: widget.username,
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Center(
                                child: InkWell(
                                    onTap: () {
                                      i += 5;
                                      setState(() {});
                                    },
                                    child: Text("Show more",
                                        style: TextStyle(color: mycolor))),
                              ));
                    },
                  )
                : Container(
                    height: 300,
                    child: Center(
                        child: Text("You have no liked or unliked post")))
            : Container(
                height: 300,
                child: Center(
                    child: CircularProgressIndicator(
                  color: buttoncolor,
                )));
      },
    );
  }
}
