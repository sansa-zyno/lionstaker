import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/services/local_storage.dart';
import 'package:achievement_view/achievement_view.dart';
import 'package:social_betting_predictions/widgets/TextWidgets/rounded_textfield.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';
import 'package:social_betting_predictions/widgets/menu.dart';
import 'package:social_betting_predictions/widgets/progressBtn/progess_btn.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ///Text Editing Controllers
  TextEditingController firstNameController = TextEditingController(text: '');
  TextEditingController lastNameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController descController = TextEditingController(text: '');
  /* TextEditingController accountNameController = TextEditingController(text: '');
  TextEditingController accountNoController = TextEditingController(text: '');
  TextEditingController bankController = TextEditingController(text: '');*/
  bool loading = false;
  bool onPageLoad = false;
  String? username;

  OnPageLoad() async {
    onPageLoad = true;
    setState(() {});
    username = await LocalStorage().getString("username");
    final res =
        await HttpService.post(Api.getProfileDetails, {"username": username});
    log(res.toString());
    Map result = jsonDecode(res.data)[0];
    firstNameController.text = result["fisrtname"] ?? "";
    lastNameController.text = result["lastname"] ?? "";
    emailController.text = result["email"] ?? "";
    phoneController.text = result["phone"] ?? "";
    //accountNameController.text = result["aname"] ?? "";
    //accountNoController.text = result["anum"] ?? "";
    //bankController.text = result["bname"] ?? "";
    onPageLoad = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OnPageLoad();
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
                  "Edit Profile",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer()
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            "First Name",
                            style: TextStyle(
                                fontSize: 16,
                                color: mycolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      _input("", firstNameController),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Text(
                            "Last Name",
                            style: TextStyle(
                                fontSize: 16,
                                color: mycolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      _input("", lastNameController),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Text(
                            "Phone Number",
                            style: TextStyle(
                                fontSize: 16,
                                color: mycolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      _input("", phoneController, type: TextInputType.phone),
                      SizedBox(height: 25),
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
                      SizedBox(height: 8),
                      _input("", emailController,
                          readOnly: emailController.text == "" ? false : true),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 16,
                                color: mycolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black45),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
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
                                controller: descController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 8),
                                  border: InputBorder.none,
                                ),
                              ))
                            ],
                          )),
                      SizedBox(height: 25),
                      Button(
                          text: "Submit",
                          animate: true,
                          context: context,
                          callback: () async {
                            await update();
                          }),
                      SizedBox(height: 25),
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

  update() async {
    loading = true;
    setState(() {});
    final apiResponse = await HttpService.post(Api.editProfile, {
      "username": username,
      "firstname": firstNameController.text,
      "lastname": lastNameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "desc": descController.text
    });
    final result = jsonDecode(apiResponse.data);
    print(result);
    if (result["Status"] == "succcess") {
      AchievementView(
        context,
        alignment: Alignment.topRight,
        color: mycolor,
        icon: Icon(
          Icons.check,
          color: Colors.white,
        ),
        title: "Success!",
        elevation: 20,
        subTitle: "Profile updated successfully",
        isCircle: true,
      ).show();
      Navigator.pop(context);
    } else {
      Get.defaultDialog(
        title: "${result["Report"]}",
        titleStyle: TextStyle(color: mycolor, fontWeight: FontWeight.bold),
        middleText: "Your input fields could not be updated",
        middleTextStyle: TextStyle(color: mycolor),
      ).then((value) => print("done"));
    }
    loading = false;
    setState(() {});
  }

  Widget _input(String hint, TextEditingController controller,
      {bool obscure = false,
      bool readOnly = false,
      TextInputType type = TextInputType.text}) {
    return RoundedTextField(
      hint: hint,
      type: TextInputType.text,
      obsecureText: false,
      icon: Icon(
        Icons.badge,
        color: Color(0xff00AEFF),
      ),
      iconColor: Colors.cyan,
      controller: controller,
      onChange: (text) {},
    );
  }
}
