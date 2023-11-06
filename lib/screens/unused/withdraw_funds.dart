/*import 'dart:convert';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/services/local_storage.dart';
import 'package:social_betting_predictions/services/notification.service.dart';
import 'package:social_betting_predictions/widgets/GradientButton/GradientButton.dart';
import 'package:social_betting_predictions/widgets/progressBtn/progess_btn.dart';

class WithdrawFund extends StatefulWidget {
  const WithdrawFund({Key? key}) : super(key: key);

  @override
  State<WithdrawFund> createState() => _WithdrawFundState();
}

class _WithdrawFundState extends State<WithdrawFund> {
  TextEditingController amtController = TextEditingController(text: '');
  List? tableDatas;
  Map? totalBalance;
  String? username;

  getData() async {
    /*username = await LocalStorage().getString("username");
    final balance =
        await HttpService.post(Api.totalBalance, {"username": username});
    totalBalance = jsonDecode(balance.data)[0];
    setState(() {});
  }

  bool loading = false;
  withdrawFund() async {
    loading = true;
    setState(() {});
    final res = await HttpService.post(Api.withdrawFunds,
        {"username": username, "amount": amtController.text});
    final result = jsonDecode(res.data);
    print(result);
    if (result["Status"] == "succcess") {
      Get.defaultDialog(
        title: "${result["Report"]}",
        titleStyle:
            TextStyle(color: mycolor, fontWeight: FontWeight.bold),
        middleText: "Transaction successful",
        middleTextStyle: TextStyle(color: mycolor),
      ).then((value) => print("done"));
      amtController.text = "";
    } else {
      Get.defaultDialog(
        title: "${result["Report"]}",
        titleStyle:
            TextStyle(color: mycolor, fontWeight: FontWeight.bold),
        middleText: "Transaction failed",
        middleTextStyle: TextStyle(color: mycolor),
      ).then((value) => print("done"));
    }
    loading = false;
    setState(() {});*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        flexibleSpace: SafeArea(
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: mycolor,
              border: Border.all(
                color: mycolor,
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Withdraw Fund",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: mycolor,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Account Balance",
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      totalBalance != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "NGN ${totalBalance != null ? totalBalance!["money"].replaceAllMapped(reg, mathFunc) : ""}",
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          : SpinKitFadingCircle(
                              color: Colors.white,
                            ),
                      SizedBox(
                        height: 30,
                      ),
                    ]),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          //color: Colors.orange,

                          ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Image.asset(
                          "assets/L3.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text("Amount",
                      style: TextStyle(
                          fontSize: 16,
                          color: mycolor,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: _input("Enter Amount", amtController,
                  type: TextInputType.number),
            ),
            SizedBox(
              height: 100,
            ),
            Button(
                text: "Withraw",
                animate: true,
                context: context,
                callback: () async {
                  await WithdrawFund();
                }),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String hint, TextEditingController controller,
      {bool obscure = false, TextInputType type = TextInputType.text}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(color: mycolor),
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
                  fontStyle: FontStyle.italic),
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
}*/
