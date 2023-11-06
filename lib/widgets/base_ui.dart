import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_betting_predictions/provider/app_provider.dart';
import 'package:social_betting_predictions/screens/notification_screen.dart';

import 'package:social_betting_predictions/widgets/menu.dart';
import 'package:upgrader/upgrader.dart';

class BaseUI extends StatefulWidget {
  Widget wid;
  BaseUI({Key? key, required this.wid}) : super(key: key);

  @override
  State<BaseUI> createState() => _BaseUIState();
}

class _BaseUIState extends State<BaseUI> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Menu(),
      backgroundColor: Colors.blueGrey[100],
      body: Container(
        color: Color(0xff231C79),
        child: Column(
          children: [
            Container(
              height: 90,
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                            child: Notifications()),
                      );
                    },
                    child: Stack(
                      children: [
                        Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                        Positioned(
                            top: -3,
                            right: 0,
                            child: Text(
                              "${appProvider.notifications != null ? appProvider.notifications!.length : 0}",
                              style: TextStyle(color: Colors.red),
                            ))
                      ],
                    ),
                  ),
                  Spacer(),
                  Image.asset(
                    "assets/lstakerLogo.png",
                    height: 50,
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
                  child: widget.wid),
            ),
          ],
        ),
      ),
    );
  }
}
