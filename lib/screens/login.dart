import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/screens/forgot_password.dart';
import 'package:social_betting_predictions/screens/home.dart';
import 'package:social_betting_predictions/screens/register.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/services/local_storage.dart';
import 'package:social_betting_predictions/widgets/GradientButton/GradientButton.dart';
import 'package:social_betting_predictions/widgets/TextWidgets/rounded_textfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ///Text Editing Controllers
  TextEditingController userNameController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  bool loading = false;
  bool obscurePass = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: ListView(children: [
            SizedBox(
              height: 25,
            ),
            Image.asset(
              'assets/lstakerLogo.png',
              fit: BoxFit.contain,
              height: 70,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Hi, Welcome Back!",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Hello again, you’ve been missed!",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text("Username",
                    style: TextStyle(
                        fontSize: 16,
                        color: mycolor,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: RoundedTextField(
                      hint: "Enter your username",
                      type: TextInputType.text,
                      obsecureText: false,
                      icon: Icon(
                        Icons.badge,
                        color: Color(0xff00AEFF),
                      ),
                      iconColor: Colors.cyan,
                      label: "",
                      controller: userNameController,
                      onChange: (text) {},
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Text("Enter Password",
                    style: TextStyle(
                        fontSize: 16,
                        color: mycolor,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextField(
                      cursorColor: Colors.black45,
                      onChanged: (text) {},
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: obscurePass,
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          //alignLabelWithHint: false,
                          //floatingLabelBehavior: FloatingLabelBehavior.auto,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: buttoncolor, width: 2.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          /* disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mycolor, width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),*/
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black45, width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          hintText: "Enter password",
                          //labelText: "",
                          //labelStyle:TextStyle(fontFamily: "Nunito", color: mycolor),
                          hintStyle: TextStyle(fontFamily: "Nunito"),
                          suffixIcon: IconButton(
                              onPressed: () {
                                obscurePass = !obscurePass;
                                setState(() {});
                              },
                              icon: !obscurePass
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: buttoncolor,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: buttoncolor,
                                    ))),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                            child: ForgotPassword()),
                      );
                    },
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    )),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            /*Button(
                text: "Next",
                animate: true,
                context: context,
                callback: () async {
                  /*Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => ForgotPassword()));*/
                  await Future.delayed(Duration(seconds: 5), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => Home(
                                  username: "username",
                                )));
                  });
                }),*/
            loading
                ? Center(
                    child: CircularProgressIndicator(
                    color: buttoncolor,
                  ))
                : Container(
                    width: 250,
                    height: 50,
                    child: GradientButton(
                      title: "Login",
                      clrs: [buttoncolor, buttoncolor],
                      onpressed: () {
                        signin();
                        /*Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                                child: Home(
                                  username: userNameController.text,
                                  pageIndex: 0,
                                )),
                            (route) => false);*/
                      },
                    ),
                  ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                          color: mycolor,
                          fontSize: 16,
                        ),
                        children: [
                      TextSpan(text: "Dont have an account? "),
                      TextSpan(
                          text: "Sign up",
                          style: TextStyle(
                              color: Colors.pink, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => Register()),
                                  (route) => false);
                            })
                    ])),
                SizedBox(
                  width: 50,
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  signin() async {
    loading = true;
    setState(() {});
    try {
      final apiResult = await HttpService.post(
        Api.login,
        {
          "username": userNameController.text,
          "password": passwordController.text,
        },
      );
      print(apiResult.data);
      //Map<String, String> result = apiResult.data as Map<String, String>;
      final result = jsonDecode(apiResult.data);
      print(result);
      if (result["Report"] == "Sucess") {
        LocalStorage().setString("username", userNameController.text);
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                child: Home(
                  username: userNameController.text,
                  pageIndex: 0,
                )),
            (route) => false);
      } else {
        Get.defaultDialog(
          title: "${result["Report"]}",
          titleStyle: TextStyle(color: mycolor, fontWeight: FontWeight.bold),
          middleText: "Please check your sign in credentials",
          middleTextStyle: TextStyle(color: mycolor),
        ).then((value) => print("done"));
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        titleStyle: TextStyle(color: mycolor, fontWeight: FontWeight.bold),
        middleText: "Please check your internet connection and try again",
        middleTextStyle: TextStyle(color: mycolor),
      ).then((value) => print("done"));
    }
    loading = false;
    setState(() {});
  }

  /*Widget _input(String hint, TextEditingController controller,
      {bool obscure = false}) {
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
  }*/
}
