import 'dart:convert';
import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';
import 'package:social_betting_predictions/widgets/menu.dart';

class LatestNews extends StatefulWidget {
  const LatestNews({Key? key}) : super(key: key);

  @override
  State<LatestNews> createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List? newsData;
  getNewsData() async {
    final response = await HttpService.get(Api.latestNews);
    log(response.toString());
    newsData = jsonDecode(response.data);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsData();
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
              "Latest News",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer()
          ],
        ),
        SizedBox(
          height: 8,
        ),
        newsData == null
            ? Center(
                child: CircularProgressIndicator(
                color: buttoncolor,
              ))
            : newsData!.isEmpty
                ? Center(child: Text("No news data to show"))
                : Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 30),
                        itemBuilder: (ctx, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Text(
                                    "${newsData![index]["nhead"].toString().toUpperCase()}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                        "$appUrl/${newsData![index]["nimg"]}"),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text:
                                          "${newsData![index]["ndet"].toString().substring(0, (newsData![index]["ndet"].toString().length / 3).ceil())}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text: " Read More",
                                        style: TextStyle(
                                          color: buttoncolor,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      title: Text(
                                                        "${newsData![index]["nhead"].toString().toUpperCase()}",
                                                        style: TextStyle(
                                                            color: buttoncolor,
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      insetPadding:
                                                          EdgeInsets.all(15),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              child: Image.network(
                                                                  "$appUrl/${newsData![index]["nimg"]}"),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(
                                                                "${newsData![index]["ndet"]}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                          })
                                  ])),
                                  SizedBox(height: 10),
                                  Text(
                                    "Published on ${newsData![index]["datte"]} ${newsData![index]["ttime"]}",
                                    style: TextStyle(
                                        color: buttoncolor,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                        separatorBuilder: (ctx, index) => Divider(
                              thickness: 5,
                            ),
                        itemCount: newsData!.length),
                  ),
      ],
    ));
  }
}
