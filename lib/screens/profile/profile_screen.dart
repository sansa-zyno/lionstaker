import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:achievement_view/achievement_view.dart';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/provider/app_provider.dart';
import 'package:social_betting_predictions/screens/profile/profile_screen_widgets/commented_posts.dart';
import 'package:social_betting_predictions/screens/profile/profile_screen_widgets/likedordisliked.dart';
import 'package:social_betting_predictions/screens/profile/profile_screen_widgets/posts.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/services/local_storage.dart';
import 'package:social_betting_predictions/widgets/TextWidgets/poppins_text.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = PageController();
  Map? profileData;
  String? username;
  XFile? image;
  //bool about = true;
  bool posts = true;
  bool likesOrdislikes = false;
  bool comments = false;

  getProfileData() async {
    username = await LocalStorage().getString("username");
    Response res = await HttpService.post(Api.profile, {"username": username});
    log(res.data.toString());
    profileData = jsonDecode(res.data)[0];
    setState(() {});
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

  uploadImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    if (image != null) {
      Response res = await HttpService.postWithFiles(Api.changeProfilePics, {
        "username": username,
        "image": MultipartFile.fromBytes(File(image!.path).readAsBytesSync(),
            filename: image!.name)
      });
      final result = jsonDecode(res.data);
      log(result.toString());
      if (result["Status"] == "succcess") {
        appProvider.getImage(username!);
        AchievementView(
          context,
          color: mycolor,
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ),
          title: "Success!",
          elevation: 20,
          subTitle: "Profile picture uploaded successfully",
          isCircle: true,
        ).show();
      } else {
        AchievementView(
          context,
          color: Colors.red,
          icon: Icon(
            Icons.bug_report,
            color: Colors.white,
          ),
          title: "Failed!",
          elevation: 20,
          subTitle: "Profile picture upload failed",
          isCircle: true,
        ).show();
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return profileData != null
        ? profileData!.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      CircularProfileAvatar(
                        '',
                        backgroundColor: Color(0xffDCf0EF),
                        child: appProvider.imageUrl != ""
                            ? Image.network(
                                appProvider.imageUrl,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/user.png",
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                              ),
                        initialsText: Text(
                          "+",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w900,
                              fontSize: 21,
                              color: Colors.white),
                        ),
                        borderWidth: 2,
                        elevation: 10,
                        radius: 50,
                        onTap: () async {
                          uploadImage();
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Column(
                        children: [
                          PoppinsText(
                            text:
                                "${profileData!["Last Name"]} ${profileData!["First Name"]}",
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                          username != null
                              ? PoppinsText(
                                  text: "@${username}",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  clr: Colors.black45,
                                )
                              : Text(""),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          Icon(
                            Icons.link,
                            color: mycolor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: PoppinsText(
                                text: "${profileData!["Profile Link"]}",
                                fontSize: 16,
                                clr: Colors.blue),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          Icon(
                            Icons.calendar_month,
                            color: mycolor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: PoppinsText(
                                text:
                                    "Joined ${calcTimesAgo(DateTime.parse(profileData!["Registered Date"]))}",
                                fontSize: 16,
                                clr: mycolor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      PoppinsText(
                        text: "Wallet Balance: \$1",
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      PoppinsText(
                        text: "Invite Link: ",
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            PoppinsText(text: "https://lionstaker.com/Hazyno"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(8)),
                        child: PoppinsText(
                          text: "Copy Invite Link",
                          clr: Colors.white,
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PoppinsText(
                                    text: "Main Wallet Balance",
                                    fontSize: 16,
                                    clr: mycolor,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/mw.png",
                                        width: 40,
                                      ),
                                      Text(": "),
                                      PoppinsText(
                                        text: "\$1.00",
                                        fontSize: 16,
                                        clr: mycolor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      PoppinsText(
                                        text: "Ledger Balance",
                                        fontSize: 16,
                                        clr: mycolor,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                    backgroundColor:
                                                        Colors.blueGrey[100],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    insetPadding:
                                                        EdgeInsets.all(8),
                                                    contentPadding:
                                                        EdgeInsets.all(15),
                                                    content: PoppinsText(
                                                      text:
                                                          "These are funds you would be able to withdraw when those you have reffered start to subscribe and would move to main wallet authomatically for each referal subscription activated ",
                                                    )));
                                          },
                                          child: Icon(Icons.info_sharp))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/lw.png",
                                        width: 40,
                                      ),
                                      Text(": "),
                                      PoppinsText(
                                        text: "\$0.00",
                                        fontSize: 16,
                                        clr: mycolor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PoppinsText(
                                    text: "Funding Wallet Balance",
                                    align: TextAlign.start,
                                    fontSize: 16,
                                    clr: mycolor,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/fw.png",
                                        width: 40,
                                      ),
                                      Text(": "),
                                      PoppinsText(
                                        text: "\$1.00",
                                        fontSize: 16,
                                        clr: mycolor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PoppinsText(
                                    text: "Subscription Status: Inactive",
                                    align: TextAlign.start,
                                    fontSize: 16,
                                    clr: mycolor,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  PoppinsText(
                                    text: "End Date: ",
                                    fontSize: 16,
                                    clr: mycolor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                PoppinsText(
                                  text: "Followers",
                                  fontSize: 16,
                                  clr: mycolor,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                PoppinsText(
                                  text: "${profileData!["Followers"]}",
                                  fontSize: 16,
                                  clr: mycolor,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                PoppinsText(
                                  text: "Following",
                                  fontSize: 16,
                                  clr: mycolor,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                PoppinsText(
                                  text: "${profileData!["Following"]}",
                                  fontSize: 16,
                                  clr: mycolor,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                PoppinsText(
                                  text: "Rating",
                                  fontSize: 16,
                                  clr: mycolor,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                PoppinsText(
                                  text: "${profileData!["Rate"]}",
                                  fontSize: 16,
                                  clr: mycolor,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                PoppinsText(
                                  text: "Net Roi",
                                  fontSize: 16,
                                  clr: mycolor,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                PoppinsText(
                                  text: "${profileData!["Net Roi"]}",
                                  fontSize: 16,
                                  clr: mycolor,
                                ),
                              ],
                            ),
                          ]),
                      /*Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  height: 50,
                                  child: GradientButton(
                                    title:
                                        "${profileData!["Followers"]} Followers",
                                    textClr: mycolor,
                                    clrs: [Colors.white, Colors.white],
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    onpressed: () {
                                      /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => Connection()));*/
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  height: 50,
                                  child: GradientButton(
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    title:
                                        "${profileData!["Following"]} Following",
                                    textClr: mycolor,
                                    clrs: [Colors.white, Colors.white],
                                    //border: Border.all(color: widget.clr),
                                    onpressed: () {
                                      /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => Achievement()));*/
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),*/
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /*Flexible(
                              child: GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: about == true
                                        ? Border(
                                            bottom: BorderSide(
                                              color: mycolor,
                                              width: 2,
                                            ),
                                          )
                                        : null,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: PoppinsText(
                                      text: "About",
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    about = true;
                                    posts = false;
                                    likes = false;
                                    comments = false;
                                  });
                                },
                              ),
                            ),*/
                          Flexible(
                            child: GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: posts == true
                                      ? Border(
                                          bottom: BorderSide(
                                            color: mycolor,
                                            width: 2,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: PoppinsText(
                                    text: "Posts ",
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  posts = true;
                                  likesOrdislikes = false;
                                  comments = false;
                                });
                              },
                            ),
                          ),
                          Flexible(
                            child: GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: likesOrdislikes == true
                                      ? Border(
                                          bottom: BorderSide(
                                            color: mycolor,
                                            width: 2,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: PoppinsText(
                                    text: "Likes/Unlikes",
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  posts = false;
                                  likesOrdislikes = true;
                                  comments = false;
                                });
                              },
                            ),
                          ),
                          Flexible(
                            child: GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: comments == true
                                      ? Border(
                                          bottom: BorderSide(
                                            color: mycolor,
                                            width: 2,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: PoppinsText(
                                    text: "Comments ",
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  posts = false;
                                  likesOrdislikes = false;
                                  comments = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      //about == true ? About() : Container(),
                      posts == true
                          ? Posts(
                              username: username!,
                            )
                          : Container(),
                      likesOrdislikes == true
                          ? LikesOrDislikes(username: username!)
                          : Container(),
                      comments == true
                          ? CommentsTab(username: username!)
                          : Container(),
                      SizedBox(height: 50)
                    ],
                  ),
                ),
              )
            : Center(child: Text("No profile data to show"))
        : Center(
            child: CircularProgressIndicator(
            color: buttoncolor,
          ));
  }
}
