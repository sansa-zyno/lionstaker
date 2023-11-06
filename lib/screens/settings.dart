/*import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/screens/login.dart';
import 'package:social_betting_predictions/screens/profile/change_password.dart';
import 'package:social_betting_predictions/screens/profile/edit_profile_setup.dart';
import 'package:social_betting_predictions/provider/app_provider.dart';
import 'package:social_betting_predictions/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _switch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: appBarHeight,
          flexibleSpace: SafeArea(
            child: Container(
              height: appBarHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: barcolor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Settings",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
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
                height: 25,
              ),
              Card(
                elevation: 0.4,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.41,
                  child: Column(
                    children: [
                      Container(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => EditProfile()));
                          },
                          leading: Icon(
                            Icons.person,
                          ),
                          title: Text(
                            "Edit Profile",
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: mycolor,
                              )),
                        ),
                      ),
                      Container(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => ChangePassword()));
                          },
                          leading: Icon(
                            Icons.settings,
                          ),
                          title: Text(
                            "Change Password",
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: mycolor,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: mycolor)),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => Login())));
                                LocalStorage().clearPref();
                              },
                              child: Text(
                                "Log out",
                              ))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}*/
