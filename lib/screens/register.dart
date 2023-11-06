import 'dart:convert';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/screens/home.dart';
import 'package:social_betting_predictions/screens/login.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/services/local_storage.dart';
import 'package:social_betting_predictions/widgets/GradientButton/GradientButton.dart';
import 'package:social_betting_predictions/widgets/TextWidgets/rounded_textfield.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  ///Text Editing Controllers
  TextEditingController userNameController = TextEditingController(text: '');
  TextEditingController inviteCodeController = TextEditingController(text: '');
  TextEditingController firstNameController = TextEditingController(text: '');
  TextEditingController lastNameController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '');
  bool loading = false;
  String isoCode = "";
  String dialcode = "+234";
  String countrySel = "";
  bool obscurePass1 = true;
  bool obscurePass2 = true;

  bool hearAboutUs = false;
  String selectedHearAboutUs = "";
  bool a = false;
  bool b = false;
  bool c = false;
  bool d = false;
  bool e = false;
  bool f = false;
  bool g = false;
  bool h = false;

  bool showGenderOptions = false;
  String selectedGender = "";
  bool selGender = false;
  bool male = false;
  bool female = false;

  String riskAppetite = "";
  bool showRiskAppetite = false;
  bool vlow = false;
  bool low = false;
  bool avg = false;
  bool high = false;
  bool vhigh = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: ListView(
          children: [
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
              "Create Account",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Earn and connect with friends today!",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  "How did you hear about us? *",
                  style: TextStyle(
                      fontSize: 16,
                      color: mycolor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {
                      hearAboutUs = !hearAboutUs;
                      setState(() {});
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black45)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                                "${selectedHearAboutUs != "" ? selectedHearAboutUs : "How did you hear about us ?"}",
                                style: TextStyle(color: mycolor)),
                          ],
                        )),
                  ),
                ),
              ],
            ),
            Visibility(
                visible: hearAboutUs,
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          a = true;
                          b = false;
                          c = false;
                          d = false;
                          e = false;
                          f = false;
                          g = false;
                          h = false;
                          selectedHearAboutUs = "Facebook";
                          hearAboutUs = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: a ? buttoncolor : Colors.transparent),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                "Facebook",
                                style: TextStyle(
                                    color: a ? Colors.white : Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          a = false;
                          b = true;
                          c = false;
                          d = false;
                          e = false;
                          f = false;
                          g = false;
                          h = false;
                          selectedHearAboutUs = "Google";
                          hearAboutUs = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: b ? buttoncolor : Colors.transparent),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("Google",
                                  style: TextStyle(
                                      color: b ? Colors.white : Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          a = false;
                          b = false;
                          c = true;
                          d = false;
                          e = false;
                          f = false;
                          g = false;
                          h = false;
                          selectedHearAboutUs = "Friend/Refferal";
                          hearAboutUs = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: c ? buttoncolor : Colors.transparent),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("Friend/Referral",
                                  style: TextStyle(
                                      color: c ? Colors.white : Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          a = false;
                          b = false;
                          c = false;
                          d = true;
                          e = false;
                          f = false;
                          g = false;
                          h = false;
                          selectedHearAboutUs = "Twitter";
                          hearAboutUs = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: d ? buttoncolor : Colors.transparent),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("Twitter",
                                  style: TextStyle(
                                      color: d ? Colors.white : Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          a = false;
                          b = false;
                          c = false;
                          d = false;
                          e = true;
                          f = false;
                          g = false;
                          h = false;
                          selectedHearAboutUs = "Whatsapp";
                          hearAboutUs = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: e ? buttoncolor : Colors.transparent),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("Whatsapp",
                                  style: TextStyle(
                                      color: e ? Colors.white : Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          a = false;
                          b = false;
                          c = false;
                          d = false;
                          e = false;
                          f = true;
                          g = false;
                          h = false;
                          selectedHearAboutUs = "Nairaland";
                          hearAboutUs = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: f ? buttoncolor : Colors.transparent),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("Nairaland",
                                  style: TextStyle(
                                      color: f ? Colors.white : Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          a = false;
                          b = false;
                          c = false;
                          d = false;
                          e = false;
                          f = false;
                          g = true;
                          h = false;
                          selectedHearAboutUs = "SMS";
                          hearAboutUs = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: g ? buttoncolor : Colors.transparent),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("SMS",
                                  style: TextStyle(
                                      color: g ? Colors.white : Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          a = false;
                          b = false;
                          c = false;
                          d = false;
                          e = false;
                          f = false;
                          g = false;
                          h = true;
                          selectedHearAboutUs = "Other";
                          hearAboutUs = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: h ? buttoncolor : Colors.transparent),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("Other",
                                  style: TextStyle(
                                      color: h ? Colors.white : Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  "What's your Risk Appetite *",
                  style: TextStyle(
                      fontSize: 16,
                      color: mycolor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {
                      showRiskAppetite = !showRiskAppetite;
                      setState(() {});
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black45)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                                "${riskAppetite != "" ? riskAppetite : "Select Risk Appetite"}",
                                style: TextStyle(color: mycolor)),
                          ],
                        )),
                  ),
                ),
              ],
            ),
            Visibility(
                visible: showRiskAppetite,
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          vlow = true;
                          low = false;
                          avg = false;
                          high = false;
                          vhigh = false;
                          riskAppetite = "Very Low";
                          showRiskAppetite = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: vlow ? buttoncolor : Colors.transparent),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("Very Low",
                                  style: TextStyle(
                                      color:
                                          vlow ? Colors.white : Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          vlow = false;
                          low = true;
                          avg = false;
                          high = false;
                          vhigh = false;
                          riskAppetite = "Low";
                          showRiskAppetite = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: low
                                  ? buttoncolor
                                  : Color.fromARGB(0, 158, 40, 40)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("Low",
                                  style: TextStyle(
                                      color:
                                          low ? Colors.white : Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          vlow = false;
                          low = false;
                          avg = true;
                          high = false;
                          vhigh = false;
                          riskAppetite = "Average";
                          showRiskAppetite = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: avg
                                  ? buttoncolor
                                  : Color.fromARGB(0, 26, 18, 18)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("Average",
                                  style: TextStyle(
                                      color:
                                          avg ? Colors.white : Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          vlow = false;
                          low = false;
                          avg = false;
                          high = true;
                          vhigh = false;
                          riskAppetite = "High";
                          showRiskAppetite = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: high
                                  ? buttoncolor
                                  : Color.fromARGB(0, 26, 18, 18)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("High",
                                  style: TextStyle(
                                      color:
                                          high ? Colors.white : Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          vlow = false;
                          low = false;
                          avg = false;
                          high = false;
                          vhigh = true;
                          riskAppetite = "Very High";
                          showRiskAppetite = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: vhigh
                                  ? buttoncolor
                                  : Color.fromARGB(0, 26, 18, 18)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("Very High",
                                  style: TextStyle(
                                      color:
                                          vhigh ? Colors.white : Colors.black)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  "Username",
                  style: TextStyle(
                      fontSize: 16,
                      color: mycolor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Hero(
                      tag: "Username",
                      child: RoundedTextField(
                        hint: "Username",
                        type: TextInputType.text,
                        obsecureText: false,
                        icon: Icon(
                          Icons.badge,
                          color: Color(0xff00AEFF),
                        ),
                        iconColor: Colors.cyan,
                        label: "Username",
                        controller: userNameController,
                        onChange: (text) {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Text(
                  "Enter your invite code",
                  style: TextStyle(
                      fontSize: 16,
                      color: mycolor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Hero(
                      tag: "Invite code",
                      child: RoundedTextField(
                        hint: "Enter your invite code or Leave empty",
                        type: TextInputType.text,
                        obsecureText: false,
                        icon: Icon(
                          Icons.badge,
                          color: Color(0xff00AEFF),
                        ),
                        iconColor: Colors.cyan,
                        label: "Enter invite code",
                        controller: inviteCodeController,
                        onChange: (text) {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  "First Name *",
                  style: TextStyle(
                      fontSize: 16,
                      color: mycolor,
                      fontWeight: FontWeight.bold),
                ),
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
                      hint: "First Name",
                      type: TextInputType.text,
                      obsecureText: false,
                      icon: Icon(
                        Icons.badge,
                        color: Color(0xff00AEFF),
                      ),
                      iconColor: Colors.cyan,
                      label: "First Name",
                      controller: firstNameController,
                      onChange: (text) {},
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Text(
                  "Last Name *",
                  style: TextStyle(
                      fontSize: 16,
                      color: mycolor,
                      fontWeight: FontWeight.bold),
                ),
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
                      hint: "Last Name",
                      type: TextInputType.text,
                      obsecureText: false,
                      icon: Icon(
                        Icons.badge,
                        color: Color(0xff00AEFF),
                      ),
                      iconColor: Colors.cyan,
                      label: "Last Name",
                      controller: lastNameController,
                      onChange: (text) {},
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Text(
                  "Select Gender *",
                  style: TextStyle(
                      fontSize: 16,
                      color: mycolor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {
                      showGenderOptions = !showGenderOptions;
                      setState(() {});
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black45)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                                "${selectedGender != "" ? selectedGender : "Select Gender"}",
                                style: TextStyle(color: mycolor)),
                          ],
                        )),
                  ),
                ),
              ],
            ),
            Visibility(
                visible: showGenderOptions,
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          selGender = true;
                          male = false;
                          female = false;
                          selectedGender = "";
                          showGenderOptions = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color:
                                  selGender ? buttoncolor : Colors.transparent),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("Select Gender",
                                  style: TextStyle(
                                      color: selGender
                                          ? Colors.white
                                          : Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          selGender = false;
                          male = true;
                          female = false;
                          selectedGender = "Male";
                          showGenderOptions = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: male ? buttoncolor : Colors.transparent),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("Male",
                                  style: TextStyle(
                                      color:
                                          male ? Colors.white : Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          selGender = false;
                          male = false;
                          female = true;
                          selectedGender = "Female";
                          showGenderOptions = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: female ? buttoncolor : Colors.transparent),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            children: [
                              Text("Female",
                                  style: TextStyle(
                                      color: female
                                          ? Colors.white
                                          : Colors.black)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            SizedBox(height: 25),
            Row(
              children: [
                Text(
                  "Select Country *",
                  style: TextStyle(
                      fontSize: 16,
                      color: mycolor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showSearch: false,
                        showPhoneCode:
                            false, // optional. Shows phone code before the country name.
                        onSelect: (Country country) {
                          print('Select country: ${country.displayName}');
                          countrySel = country.displayName;
                          setState(() {});
                        },
                      );
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black45)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              countrySel == "" ? "Select Country" : countrySel,
                              style: TextStyle(color: mycolor),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  "Phone Number *",
                  style: TextStyle(
                      fontSize: 16,
                      color: mycolor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(width: 10),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xffE8E8E8),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: CountryCodePicker(
                      onChanged: (value) {
                        isoCode = value.code!;
                        dialcode = value.dialCode!;
                      },
                      hideSearch: true,
                      builder: (value) => buildButton(value!),
                      initialSelection: '+234',
                      textStyle: Theme.of(context).textTheme.caption,
                      showFlag: false,
                      showFlagDialog: true,
                      favorite: ['+234', 'US'],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: RoundedTextField(
                          hint: "Phone Number",
                          type: TextInputType.text,
                          obsecureText: false,
                          icon: Icon(
                            Icons.badge,
                            color: Color(0xff00AEFF),
                          ),
                          iconColor: Colors.cyan,
                          label: "Phone Number",
                          controller: phoneController,
                          onChange: (text) {},
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Text(
                  "Email Address *",
                  style: TextStyle(
                      fontSize: 16,
                      color: mycolor,
                      fontWeight: FontWeight.bold),
                ),
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
                      hint: "Email Address",
                      type: TextInputType.text,
                      obsecureText: false,
                      icon: Icon(
                        Icons.badge,
                        color: Color(0xff00AEFF),
                      ),
                      iconColor: Colors.cyan,
                      label: "Email Address",
                      controller: emailController,
                      onChange: (text) {},
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Password *",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: TextField(
                                  onChanged: (text) {},
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  obscureText: obscurePass1,
                                  decoration: new InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: buttoncolor, width: 2.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      /* disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: mycolor, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),*/
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black45, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      hintText: "Password",
                                      hintStyle:
                                          TextStyle(fontFamily: "Nunito"),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            obscurePass1 = !obscurePass1;
                                            setState(() {});
                                          },
                                          icon: !obscurePass1
                                              ? Icon(
                                                  Icons.visibility_off,
                                                  color: buttoncolor,
                                                )
                                              : Icon(
                                                  Icons.visibility,
                                                  color: buttoncolor,
                                                ))),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Confirm Password *",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: mycolor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: TextField(
                                  onChanged: (text) {},
                                  controller: confirmPasswordController,
                                  keyboardType: TextInputType.text,
                                  obscureText: obscurePass2,
                                  decoration: new InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: buttoncolor, width: 2.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      /*disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: mycolor, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),*/
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black45, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      hintText: "Confirm Password",
                                      hintStyle:
                                          TextStyle(fontFamily: "Nunito"),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            obscurePass2 = !obscurePass2;
                                            setState(() {});
                                          },
                                          icon: !obscurePass2
                                              ? Icon(
                                                  Icons.visibility_off,
                                                  color: buttoncolor,
                                                )
                                              : Icon(
                                                  Icons.visibility,
                                                  color: buttoncolor,
                                                ))),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            /* Button(
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
                      title: "Register",
                      clrs: [buttoncolor, buttoncolor],
                      onpressed: () {
                        signup();
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
                      TextSpan(text: "Already have an account ? "),
                      TextSpan(
                          text: "Login",
                          style: TextStyle(
                              color: Colors.pink, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (ctx) => Login()),
                                  (route) => false);
                            })
                    ])),
                SizedBox(
                  width: 50,
                )
              ],
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      )),
    );
  }

  signup() async {
    loading = true;
    setState(() {});
    try {
      final apiResult = await HttpService.post(
        Api.register,
        {
          "username": userNameController.text,
          "firstname": firstNameController.text,
          "lastname": lastNameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "heardAboutUs": selectedHearAboutUs,
          "gender": selectedGender,
          "country": countrySel,
          "riskAppetite": riskAppetite,
          "inviteCode": inviteCodeController.text,
          "password": passwordController.text,
          "password2": confirmPasswordController.text,
        },
      );
      print(apiResult);
      final result = jsonDecode(apiResult.data);
      print(result);
      if (result["Report"] == "Success") {
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
          middleText: "Please check your sign up credentials",
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

  /* Widget _input(String hint, TextEditingController controller,
      {bool obscure = false}) {
    return Container(
      height: 60,
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

              fillColor: Color.fromARGB(255, 136, 0, 0)),
          //keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }*/

  buildButton(CountryCode isoCode) {
    return Row(
      children: <Widget>[
        Text(
          '$isoCode',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
