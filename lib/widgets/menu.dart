import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:achievement_view/achievement_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_betting_predictions/constants/api.dart';
import 'package:social_betting_predictions/provider/app_provider.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/screens/add_trades.dart';
import 'package:social_betting_predictions/screens/earning_history.dart';
import 'package:social_betting_predictions/screens/faq.dart';
import 'package:social_betting_predictions/screens/fund_merchant.dart';
import 'package:social_betting_predictions/screens/funding/fund_wallet.dart';
import 'package:social_betting_predictions/screens/home.dart';
import 'package:social_betting_predictions/screens/instant_crypto_trading.dart';
import 'package:social_betting_predictions/screens/latest_news.dart';
import 'package:social_betting_predictions/screens/login.dart';
import 'package:social_betting_predictions/screens/my_trades.dart';
import 'package:social_betting_predictions/screens/notification_screen.dart';
import 'package:social_betting_predictions/screens/point_history.dart';
import 'package:social_betting_predictions/screens/privacy_policy.dart';
import 'package:social_betting_predictions/screens/profile/edit_profile_setup.dart';
import 'package:social_betting_predictions/screens/subscription.dart';
import 'package:social_betting_predictions/screens/terms&conditions.dart';
import 'package:social_betting_predictions/screens/trade_history.dart';
import 'package:social_betting_predictions/screens/trade_room.dart';
import 'package:social_betting_predictions/screens/view_messages.dart';
import 'package:social_betting_predictions/screens/withdraw.dart';
import 'package:social_betting_predictions/services/http.service.dart';
import 'package:social_betting_predictions/services/local_storage.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:social_betting_predictions/screens/support.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  //bool subscription = false;
  //bool fundWallet = false;
  //bool payment = false;
  bool merchant = false;
  bool p2p = false;
  bool profile = false;
  bool extra = false;

  XFile? image;
  String? username;
  String? useremail;

  getUserData() async {
    username = await LocalStorage().getString("username");
    final response =
        await HttpService.post(Api.getEmail, {"username": username});
    useremail = response.data;
    setState(() {});
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
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black45))),
                  child: Row(
                    children: [
                      CircularProfileAvatar(
                        "",
                        backgroundColor: Color(0xffDCf0EF),
                        initialsText: Text(
                          "+",
                          textScaleFactor: 1,
                          style: TextStyle(fontSize: 21, color: Colors.white),
                        ),
                        //cacheImage: true,
                        borderWidth: 2,
                        elevation: 10,
                        radius: 30,
                        onTap: () {
                          uploadImage();
                        },
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
                      ),
                    ],
                  )),
              Image.asset(
                "assets/lstakerLogo.png",
                height: 50,
              )
            ],
          ),
          /* UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: barcolor,
              ),
              currentAccountPicture: CircularProfileAvatar(
                "",
                backgroundColor: Color(0xffDCf0EF),
                initialsText: Text(
                  "+",
                  textScaleFactor: 1,
                  style: TextStyle(
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w900,
                      fontSize: 21,
                      color: Colors.white),
                ),
                //cacheImage: true,
                borderWidth: 2,
                elevation: 10,
                radius: 50,
                onTap: () {
                  uploadImage();
                },
                child: imageUrl != ""
                    ? Image.network(
                        "https://empowermentfoodnetwork.com/office/uploads//images//${imageUrl.substring(15, (imageUrl.length))}",
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.camera_alt),
              ),
              accountName: Text("${username != null ? username : ""}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white)),
              accountEmail: Text("${useremail != null ? useremail : ""}",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white))),*/
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(15),
              children: [
                ListTile(
                  leading: Icon(
                    Icons.house,
                    color: mycolor,
                  ),
                  title: Text("TIPSFEED",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mycolor,
                        fontSize: 16,
                      )),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: Home(
                            username: "username",
                            pageIndex: 0,
                          )),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.bolt,
                    color: mycolor,
                  ),
                  title: Text("POINT HISTORY",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mycolor,
                        fontSize: 16,
                      )),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: PointHistory()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.message,
                    color: mycolor,
                  ),
                  title: RichText(
                    text: TextSpan(
                      style: GoogleFonts.nunito(
                          color: mycolor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "CHAT ROOM "),
                        TextSpan(text: "("),
                        TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                            text: "${/*appProvider.notifications!.length*/ 0}"),
                        TextSpan(text: ")")
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: Home(
                            username: "username",
                            pageIndex: 2,
                          )),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.notifications,
                    color: mycolor,
                  ),
                  title: RichText(
                    text: TextSpan(
                      style: GoogleFonts.nunito(
                          color: mycolor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "NOTIFICATION "),
                        TextSpan(text: "("),
                        TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                            text:
                                "${appProvider.notifications != null ? appProvider.notifications!.length : 0}"),
                        TextSpan(text: ")")
                      ],
                    ),
                  ),
                  onTap: () async {
                    /*await HttpService.post(Api.updateNotification, {
                      "username": username,
                    });*/
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: Notifications()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: mycolor,
                  ),
                  title: Text("PROFILE",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mycolor,
                        fontSize: 16,
                      )),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                      color: mycolor,
                    ),
                    onPressed: () {
                      profile = !profile;
                      setState(() {});
                    },
                  ),
                ),
                Visibility(
                    visible: profile,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text("MY PROFILE",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                    child: Home(
                                      username: "username",
                                      pageIndex: 3,
                                    )),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text("EDIT PROFILE",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                    child: EditProfile()),
                              );
                            },
                          ),
                          /*ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text("KYC update",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                    child: KYCUpdate()),
                              );
                            },
                          ),*/
                          /*ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text("View update",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                    child: KYCHistory()),
                              );
                            },
                          ),*/
                        ],
                      ),
                    )),
                ListTile(
                  leading: Icon(
                    Icons.bolt,
                    color: mycolor,
                  ),
                  title: Text("TRAINING CENTER",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mycolor,
                        fontSize: 16,
                      )),
                  onTap: () {
                    /*Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: Home(
                            username: "username",
                            pageIndex: 2,
                          )),
                    );*/
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.wallet,
                    color: mycolor,
                  ),
                  title: Text("INSTANT CRYPTO FUNDING",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mycolor,
                        fontSize: 16,
                      )),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: InstantCryptoTrading()),
                    );
                  },
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: Subscription()),
                    );
                  },
                  leading: Icon(
                    Icons.money,
                    color: mycolor,
                  ),
                  title: Text("SUBSCRIPTION",
                      style: TextStyle(
                          color: mycolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: Withdraw()),
                    );
                  },
                  leading: Icon(
                    Icons.credit_card,
                    color: mycolor,
                  ),
                  title: Text("WITHDRAWAL",
                      style: TextStyle(
                          color: mycolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
                ListTile(
                  leading: Icon(
                    Icons.bolt,
                    color: mycolor,
                  ),
                  title: Text("EARNING HISTORY",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mycolor,
                          fontSize: 16)),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: EarningHistory()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.store,
                    color: mycolor,
                  ),
                  title: Text("MERCHANT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mycolor,
                          fontSize: 16)),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                      color: mycolor,
                    ),
                    onPressed: () {
                      merchant = !merchant;
                      setState(() {});
                    },
                  ),
                ),
                Visibility(
                    visible: merchant,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text("ADD TRADES",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                    child: AddTrades()),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text("VIEW MY TRADES",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                    child: MyTrades()),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text("FUND MERCHANT ACCOUNT",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                    child: FundMerchant()),
                              );
                            },
                          ),
                        ],
                      ),
                    )),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: FundWallet()),
                    );
                  },
                  leading: Icon(
                    Icons.wallet,
                    color: mycolor,
                  ),
                  title: Text("FUND WALLET",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: mycolor)),
                ),
                ListTile(
                  leading: Icon(
                    Icons.wallet,
                    color: mycolor,
                  ),
                  title: Text("P2P FUND",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mycolor,
                          fontSize: 16)),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                      color: mycolor,
                    ),
                    onPressed: () {
                      p2p = !p2p;
                      setState(() {});
                    },
                  ),
                ),
                Visibility(
                    visible: p2p,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text("TRADE ROOM",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                    child: TradeRoom()),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text("TRADE HISTORY",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                    child: TradeHistory()),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text("VIEW MESSAGES",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                    child: ViewMessages()),
                              );
                            },
                          ),
                        ],
                      ),
                    )),
                ListTile(
                  leading: Icon(
                    Icons.public,
                    color: mycolor,
                  ),
                  title: Text("FAQ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mycolor,
                        fontSize: 16,
                      )),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: FAQ()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.newspaper,
                    color: mycolor,
                  ),
                  title: Text("LATEST NEWS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mycolor,
                          fontSize: 16)),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: LatestNews()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.web,
                    color: mycolor,
                  ),
                  title: Text("OTHER PAGES",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mycolor,
                          fontSize: 16)),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                      color: mycolor,
                    ),
                    onPressed: () {
                      extra = !extra;
                      setState(() {});
                    },
                  ),
                ),
                Visibility(
                    visible: extra,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text("CONTACT/SUBMIT REVIEW",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                    child: Support()),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text("PRIVACY AND POLICY",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                    child: PrivacyAndPolicy()),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_right),
                            title: Text("TERMS AND CONDITIONS",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                    child: TermsAndCondition()),
                              );
                            },
                          ),
                        ],
                      ),
                    )),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: mycolor,
                  ),
                  title: Text("LOGOUT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mycolor,
                          fontSize: 16)),
                  onTap: () {
                    appProvider.disp();
                    LocalStorage().clearPref();
                    //AppbackgroundService().stopBg();
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                          child: Login()),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
