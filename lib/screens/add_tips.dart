import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:social_betting_predictions/services/local_storage.dart';

import 'package:social_betting_predictions/widgets/progressBtn/progess_btn.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController bookCodeController = TextEditingController(text: "");
  String? username;

  String val = "Bet9ja";
  String val2 = "Select Odd";

  PlatformFile? file;

  getUsername() async {
    username = await LocalStorage().getString("username");
  }

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: ["png", "jpg", "jpeg"], type: FileType.custom);

    if (result != null) {
      file = result.files.single;
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  addTips() async {
    final res = await HttpService.postWithFiles(Api.addTips, {
      "username": username,
      "todd": val2,
      "bookmaker": val,
      "betcode": bookCodeController.text,
      "image": dio.MultipartFile.fromBytes(File(file!.path!).readAsBytesSync(),
          filename: file!.name),
    });
    final result = jsonDecode(res.data);
    print(result);
    if (result == "success") {
      Get.defaultDialog(
        title: "${result}",
        titleStyle: TextStyle(color: mycolor, fontWeight: FontWeight.bold),
        middleText: "Your tips was added successfully",
        middleTextStyle: TextStyle(
          color: mycolor,
        ),
      ).then((value) => print("done"));
    } else {
      Get.defaultDialog(
        title: "${result}",
        titleStyle: TextStyle(color: mycolor, fontWeight: FontWeight.bold),
        middleText: "Tips not added",
        middleTextStyle: TextStyle(
          color: mycolor,
        ),
      ).then((value) => print("done"));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }

  @override
  void dispose() {
    bookCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  "Add Tip",
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
            Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(2, 2))
                    ]),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: TextField(
                      controller: bookCodeController,
                      cursorColor: Colors.black45,
                      maxLines: 10,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          border: InputBorder.none,
                          hintText: "Enter Booking code"),
                    ))
                  ],
                )),
            SizedBox(height: 30),
            file != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      height: 160,
                      width: 90,
                      child: Image.file(
                        //"${file!.name.split("/").last}",
                        //style: TextStyle(color: Colors.black, fontSize: 16),
                        File(file!.path!), fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),
            file != null
                ? SizedBox(
                    height: 15,
                  )
                : Container(),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(2, 2))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            getFile();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.image,
                                color: Colors.black45,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                  width: 75,
                                  child: Text(
                                    "Select Your Bookingslip",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ))
                            ],
                          )),
                      Container(
                        height: 50,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey[100]!),
                            borderRadius: BorderRadius.circular(8)),
                        child: DropdownButton<String>(
                            value: val,
                            underline: Container(),
                            style: TextStyle(color: Colors.black),
                            items: [
                              "SportyBet",
                              "Bet9ja",
                              "1XBet",
                              "BetKing",
                              "Betway",
                              "22Bet",
                              "Sportinbet",
                              "Hollywoodbets",
                              "Melbet",
                              "Bet365",
                              "Betika",
                              "SUPABETS",
                              "Bet Winner",
                              "William Hill",
                              "BetMGM",
                              "Caesars",
                              "FanDuel",
                              "Boombet",
                              "Unibet",
                              "Midasbet",
                              "Ladbrokes",
                              "PuntNow",
                              "BetVictor",
                              "Sports Interaction",
                              "Betfair",
                              "Vave",
                              "888sport",
                              "10bet",
                              "Betfred"
                            ]
                                .map<DropdownMenuItem<String>>((value) =>
                                    DropdownMenuItem(
                                        value: value,
                                        child: Container(
                                            width: 70, child: Text("$value"))))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                val = value!;
                              });
                            }),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey[100]!),
                            borderRadius: BorderRadius.circular(8)),
                        child: DropdownButton<String>(
                            value: val2,
                            underline: Container(),
                            style: TextStyle(color: Colors.black),
                            items: [
                              "Select Odd",
                              "2",
                              "3",
                              "4",
                              "5",
                            ]
                                .map<DropdownMenuItem<String>>((value) =>
                                    DropdownMenuItem(
                                        value: value,
                                        child: Container(
                                            width: 50, child: Text("$value"))))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                val2 = value!;
                              });
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: buttoncolor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(2, 2))
                          ]),
                      child: Row(
                        children: [
                          Text(
                            "Post",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.send,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
