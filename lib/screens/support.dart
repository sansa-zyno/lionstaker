import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_betting_predictions/Widgets/GradientButton/GradientButton.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/services/local_storage.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';
import 'package:social_betting_predictions/widgets/menu.dart';
import 'package:social_betting_predictions/widgets/progressBtn/progess_btn.dart';

class Support extends StatefulWidget {
  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController fullController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController subjectController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  String? username;

  getUserName() async {
    username = await LocalStorage().getString("username");
  }

  bool loading = false;
  contact() async {
    loading = true;
    setState(() {});
    print(username);
    final res = await HttpService.post(Api.support, {
      "username": username,
      "fullname": fullController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "subject": subjectController.text,
      "comment": commentController.text,
      "question": questionController.text,
      "answer": answerController.text
    });
    final result = jsonDecode(res.data);
    if (result["Status"] == "succcess") {
      Get.defaultDialog(
        title: "${result["Report"]}",
        titleStyle: TextStyle(color: mycolor, fontWeight: FontWeight.bold),
        middleText: "Message sent successfully",
        middleTextStyle: TextStyle(color: mycolor),
      ).then((value) => print("done"));
    } else {
      Get.defaultDialog(
        title: "${result["Report"]}",
        titleStyle: TextStyle(color: mycolor, fontWeight: FontWeight.bold),
        middleText: "Message not sent",
        middleTextStyle: TextStyle(color: mycolor),
      ).then((value) => print("done"));
    }
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
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
        child: Column(
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
                  "Contact Form",
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
            Text(
              "How can we help?",
              style: TextStyle(),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Kindly fill the form to reach out to us!",
              style: TextStyle(),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            "Full name",
                            style: TextStyle(
                                fontSize: 16,
                                color: mycolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      _input("Full name", fullController),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 16,
                                color: mycolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      _input("Email", emailController),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Phone number",
                            style: TextStyle(
                                fontSize: 16,
                                color: mycolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      _input("Phone number", phoneController),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Subject",
                            style: TextStyle(
                                fontSize: 16,
                                color: mycolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      _input("Subject", subjectController),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Enter Your Message",
                            style: TextStyle(
                                fontSize: 16,
                                color: mycolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 350,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "Leave a comment here"),
                              controller: commentController,
                              maxLines: 15,
                              maxLength: 450,
                            ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Question",
                            style: TextStyle(
                                fontSize: 16,
                                color: mycolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      _input("Question", questionController),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Answer",
                            style: TextStyle(
                                fontSize: 16,
                                color: mycolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      _input("Answer", answerController),
                      SizedBox(height: 30),
                      Button(
                          text: "Submit",
                          animate: true,
                          context: context,
                          callback: () async {
                            await contact();
                          }),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String hint, TextEditingController controller,
      {bool obscure = false}) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(color: Colors.black45),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(2, 2))
          ]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 15, 0),
        child: TextFormField(
          cursorColor: mycolor,
          obscureText: obscure,
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "This field must not be empty.";
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                //fontStyle: FontStyle.italic
              ),
              //labelText: label,
              hintText: hint,
              focusColor: Colors.grey,

              //fillColor: Colors.white,

              fillColor: Color.fromARGB(255, 136, 0, 0)),
          //keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
}
