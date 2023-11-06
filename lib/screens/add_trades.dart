import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';
import 'package:social_betting_predictions/widgets/menu.dart';
import 'package:social_betting_predictions/widgets/progressBtn/progess_btn.dart';
import 'package:dio/dio.dart' as dio;

class AddTrades extends StatefulWidget {
  const AddTrades({Key? key}) : super(key: key);

  @override
  State<AddTrades> createState() => _AddTradesState();
}

class _AddTradesState extends State<AddTrades> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ///Text Editing Controllers
  TextEditingController amountController = TextEditingController(text: '');
  TextEditingController ansController = TextEditingController(text: '');
  //TextEditingController amountController = TextEditingController(text: '');
  List items = ["Activation"];
  String val = "Activation";
  Map? res;
  String dte = "Choose date";

  PlatformFile? file;

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = result.files.single;
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  String regFee = "";
  /* getAccountDetails() async {
    final rex = await HttpService.get(Api.regFee);
    print(rex);
    regFee = rex.data;
    final response = await HttpService.get(Api.bankDetails);
    res = jsonDecode(response.data)[0];
    setState(() {});
  }*/

  /*String? username;
  getusername() async {
    username = await LocalStorage().getString("username");
  }*/

  bool loading = false;
  aktivate() async {
    /*loading = true;
    setState(() {});
    print(username);
    final res = await HttpService.postWithFiles(Api.activate, {
      "username": username,
      "date": dte,
      "amt": amountController.text,
      "image": dio.MultipartFile.fromBytes(File(file!.path!).readAsBytesSync(),
          filename: file!.name),
      "name": val
    });
    final result = jsonDecode(res.data);
    if (result["Status"] == "succcess") {
      Get.defaultDialog(
        title: "${result["Report"]}",
        titleStyle:
            TextStyle(color: mycolor, fontWeight: FontWeight.bold),
        middleText: "Activation details sent successfully",
        middleTextStyle: TextStyle(
          color: mycolor,
        ),
      ).then((value) => print("done"));
    } else {
      Get.defaultDialog(
        title: "${result["Report"]}",
        titleStyle:
            TextStyle(color: mycolor, fontWeight: FontWeight.bold),
        middleText: "Activation details not sent",
        middleTextStyle: TextStyle(
          color: mycolor,
        ),
      ).then((value) => print("done"));
    }
    loading = false;
    setState(() {});*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getusername();
    //getAccountDetails();
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
                  "Add Trades",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer()
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "Trade Amount",
                      style: TextStyle(
                          fontSize: 16,
                          color: mycolor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                _input("Amount", amountController, type: TextInputType.number),
                SizedBox(height: 25),
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
                SizedBox(height: 8),
                Container(
                  height: 50,
                  width: 350,
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
                      padding: const EdgeInsets.all(15),
                      child: Text("260+140", style: TextStyle(fontSize: 16))),
                ),
                SizedBox(height: 25),
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
                SizedBox(height: 8),
                _input("Answer", ansController, type: TextInputType.number),
                SizedBox(
                  height: 25,
                ),
                Button(
                    text: "Add Trade",
                    animate: true,
                    context: context,
                    callback: () {}),
                SizedBox(
                  height: 25,
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String hint, TextEditingController controller,
      {bool obscure = false,
      bool readOnly = false,
      TextInputType type = TextInputType.text}) {
    return Container(
      height: 50,
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
          keyboardType: type,
          readOnly: readOnly,
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
              hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
              //labelText: label,
              hintText: hint,
              focusColor: Colors.grey,

              //fillColor: Colors.white,

              fillColor: Colors.white),
          //keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
}
