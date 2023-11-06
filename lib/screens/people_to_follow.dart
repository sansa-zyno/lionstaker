import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:provider/provider.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/provider/app_provider.dart';
import 'package:social_betting_predictions/screens/add_tips.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/services/local_storage.dart';

class PeopleToFollow extends StatefulWidget {
  String username;
  PeopleToFollow({Key? key, required this.username}) : super(key: key);

  @override
  State<PeopleToFollow> createState() => _PeopleToFollowState();
}

class _PeopleToFollowState extends State<PeopleToFollow> {
  List? peopleToFollow;
  Future getData() async {
    final res = await HttpService.get(Api.whoToFollow);
    print(res.data);
    peopleToFollow = jsonDecode(res.data);
    log(peopleToFollow.toString());
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    List items = ["assets/ls_ad.jpg", "assets/ls_ad.jpg", "assets/ls_ad.jpg"];
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return peopleToFollow != null
        ? peopleToFollow!.isNotEmpty
            ? Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
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
                            readOnly: true,
                            onTap: () {
                              /* Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => AddPostPage()));*/
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                      backgroundColor: Colors.blueGrey[100],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      insetPadding: EdgeInsets.all(8),
                                      contentPadding: EdgeInsets.all(15),
                                      content: AddPostPage()));
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefix: Text("   "),
                              hintText: "Enter Betslip Code",
                              prefixIconConstraints: BoxConstraints(
                                  maxHeight: 35,
                                  minHeight: 35,
                                  maxWidth: 35,
                                  minWidth: 35),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: CircleAvatar(
                                    backgroundColor: buttoncolor,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                    onTap: () {
                                      /* Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => AddPostPage()));*/
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                              backgroundColor:
                                                  Colors.blueGrey[100],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              insetPadding: EdgeInsets.all(8),
                                              contentPadding:
                                                  EdgeInsets.all(15),
                                              content: AddPostPage()));
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: buttoncolor,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ))),
                              ),
                              suffixIconConstraints: BoxConstraints(
                                  maxHeight: 35,
                                  minHeight: 35,
                                  maxWidth: 35,
                                  minWidth: 35),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          autoPlay: true,
                          height: 100,
                          disableCenter: true,
                          viewportFraction: 1),
                      items: items
                          .map(
                            (item) => Image.asset(
                              item,
                              fit: BoxFit.cover,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Most Profitable Member"),
                            Text("View All")
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 0.7),
                              //controller: scrollController,
                              physics: ClampingScrollPhysics(),
                              itemCount: peopleToFollow!.length,
                              itemBuilder: (ctx, index) => Container(
                                    margin: EdgeInsets.only(
                                      top: 8,
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                            Border.all(color: Colors.black45),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 10.0,
                                              offset: Offset(2, 2),
                                              color:
                                                  Colors.grey.withOpacity(0.2))
                                        ]),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.grey[200],
                                          backgroundImage: NetworkImage(
                                            "${peopleToFollow![index]["ProfileImage"]}",
                                          ),
                                          radius: 30,
                                        ),
                                        Text(
                                          "${peopleToFollow![index]["LastName"]} ${peopleToFollow![index]["FirstName"]}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "@${peopleToFollow![index]["username"]}"),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Rating:"),
                                            Text(
                                                "${double.parse(peopleToFollow![index]["Rating"]).toPrecision(2)}")
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            if (appProvider.followed.isEmpty ||
                                                !appProvider.followed.contains(
                                                    peopleToFollow![index]
                                                        ["username"])) {
                                              Response res =
                                                  await HttpService.post(
                                                      Api.follow, {
                                                "username": widget.username,
                                                "usernametofollow":
                                                    peopleToFollow![index]
                                                        ["username"],
                                              });
                                              if (res.data == "Success") {
                                                appProvider.followed.add(
                                                    peopleToFollow![index]
                                                        ["username"]);
                                                appProvider.followed.toSet();
                                                appProvider.followed.toList();
                                                LocalStorage()
                                                    .setString(
                                                        "followed",
                                                        jsonEncode(appProvider
                                                            .followed))
                                                    .then((value) {
                                                  appProvider.getFollowed();
                                                });
                                              }
                                            } else {
                                              Response res =
                                                  await HttpService.post(
                                                      Api.unfollow, {
                                                "username": widget.username,
                                                "usernametounfollow":
                                                    peopleToFollow![index]
                                                        ["username"],
                                              });
                                              if (res.statusCode == 200) {
                                                appProvider.followed.remove(
                                                    peopleToFollow![index]
                                                        ["username"]);
                                                appProvider.followed.toSet();
                                                appProvider.followed.toList();
                                                LocalStorage()
                                                    .setString(
                                                        "followed",
                                                        jsonEncode(appProvider
                                                            .followed))
                                                    .then((value) {
                                                  appProvider.getFollowed();
                                                });
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: appProvider
                                                          .followed.isEmpty ||
                                                      !appProvider.followed
                                                          .contains(
                                                              peopleToFollow![
                                                                      index]
                                                                  ["username"])
                                                  ? Colors.transparent
                                                  : buttoncolor,
                                              border: Border.all(
                                                  color: buttoncolor),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                appProvider.followed.isEmpty ||
                                                        !appProvider.followed
                                                            .contains(
                                                                peopleToFollow![
                                                                        index][
                                                                    "username"])
                                                    ? Icon(Icons.add,
                                                        color: buttoncolor)
                                                    : Icon(Icons.remove,
                                                        color: Colors.white),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  "${appProvider.followed.isEmpty || !appProvider.followed.contains(peopleToFollow![index]["username"]) ? "follow" : "unfollow"}",
                                                  style: TextStyle(
                                                      color: appProvider
                                                                  .followed
                                                                  .isEmpty ||
                                                              !appProvider
                                                                  .followed
                                                                  .contains(peopleToFollow![
                                                                          index]
                                                                      [
                                                                      "username"])
                                                          ? buttoncolor
                                                          : Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(child: Text("No data to show"))
        : Center(
            child: CircularProgressIndicator(
            color: buttoncolor,
          ));
  }
}
