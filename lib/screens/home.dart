import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
//import 'package:social_betting_predictions/activate.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/provider/app_provider.dart';
import 'package:social_betting_predictions/screens/chat/chat_home.dart';
//import 'package:social_betting_predictions/apply_incentives.dart';
import 'package:social_betting_predictions/screens/dashboard.dart';
import 'package:social_betting_predictions/screens/notification_screen.dart';
//import 'package:social_betting_predictions/market/my_orders.dart';
import 'package:social_betting_predictions/screens/people_to_follow.dart';
import 'package:social_betting_predictions/screens/point_history.dart';
import 'package:social_betting_predictions/screens/profile/profile_screen.dart';
import 'package:social_betting_predictions/widgets/menu.dart';
import 'package:upgrader/upgrader.dart';

class Home extends StatefulWidget {
  String username;
  int pageIndex = 0;
  Home({Key? key, required this.username, required this.pageIndex})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int pageIndex;
  late Widget _showPage;
  late DashBoard _dashboard;
  late ChatHome _chat;
  late PeopleToFollow _peopleToFollow;
  late ProfileScreen _profileScreen;
  late AppProvider appProvider;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription? listener;

  //navbar
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _dashboard;

      case 1:
        return _peopleToFollow;

      case 2:
        return _chat;

      case 3:
        return _profileScreen;

      default:
        return new Container(
            child: new Center(
          child: new Text(
            'No Page found by page thrower',
            style: new TextStyle(fontSize: 30),
          ),
        ));
    }
  }

  /* bg() async {
    await Future.delayed(Duration(seconds: 30), () async {
      await AppbackgroundService().startBg();
    });
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dashboard = DashBoard(
      username: widget.username,
    );
    _chat = ChatHome(
      username: widget.username,
    );
    _peopleToFollow = PeopleToFollow(
      username: widget.username,
    );
    _profileScreen = ProfileScreen();

    pageIndex = widget.pageIndex;
    _showPage = _pageChooser(pageIndex);
    appProvider = Provider.of<AppProvider>(context, listen: false);
    listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          log('Data connection is available.');
          appProvider.getFeeds(widget.username);
          appProvider.RecentChatData(widget.username);
          appProvider.getImage(widget.username);
          break;
        case InternetConnectionStatus.disconnected:
          log('You are disconnected from the internet.');
          break;
      }
    });
    //bg();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    listener!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      //backgroundColor: Color(0xffCDD8F0),
      //backgroundColor: Color(0xff0e6dfd),
      drawer: Menu(),
      body: UpgradeAlert(
          upgrader: Upgrader(
            dialogStyle: Platform.isIOS
                ? UpgradeDialogStyle.cupertino
                : UpgradeDialogStyle.material,
          ),
          child: Container(
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
                      child: _showPage),
                ),
              ],
            ),
          )),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.shifting,
              elevation: 10,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.house,
                    size: 25,
                  ),
                  label: 'Feed',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.people,
                    size: 25,
                  ),
                  label: 'People',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Boxicons.bx_chat,
                    size: 25,
                  ),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle,
                    size: 25,
                  ),
                  label: 'Profile',
                ),
              ],
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: pageIndex,
              selectedItemColor: buttoncolor,
              unselectedItemColor: Colors.black87,
              onTap: (int tappedIndex) {
                setState(() {
                  pageIndex = tappedIndex;
                  _showPage = _pageChooser(pageIndex);
                });
              }),
        ),
      ),
    );
  }
}
