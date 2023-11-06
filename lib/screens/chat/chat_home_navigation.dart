/*import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/screens/chat/chat_home.dart';
import 'package:social_betting_predictions/screens/home.dart';
import 'package:social_betting_predictions/screens/chat/messages_screen.dart';
import 'package:social_betting_predictions/screens/profile/profile_screen.dart';
import 'package:social_betting_predictions/provider/app_provider.dart';
import 'package:social_betting_predictions/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import 'package:double_back_to_close/double_back_to_close.dart';

class ChatHomeNavigation extends StatefulWidget {
  String username;
  ChatHomeNavigation({required this.username});
  @override
  State<ChatHomeNavigation> createState() => _ChatHomeNavigationState();
}

class _ChatHomeNavigationState extends State<ChatHomeNavigation> {
  late int pageIndex;
  late Widget _showPage;
  late ChatHome _chathome;
  late Messages _messages;
  late Home _home;
  late SettingScreen _settingScreen;
  late ProfileScreen _profileScreen;

  //navbar
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _chathome;
      case 1:
        return _messages;

      case 2:
        Navigator.pop(context);
        return _home;
      case 3:
        return _settingScreen;
      case 4:
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
    _chathome = ChatHome(username: widget.username);
    _messages = Messages(username: widget.username);
    _home = Home(
      username: widget.username,
      pageIndex: 0,
    );
    _settingScreen = SettingScreen();
    _profileScreen = ProfileScreen();
    pageIndex = 0;
    _showPage = _pageChooser(pageIndex);
    //bg();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: DoubleBack(
        message: "Press back again to close",
        child: Scaffold(
          body: UpgradeAlert(
              upgrader: Upgrader(
                dialogStyle: Platform.isIOS
                    ? UpgradeDialogStyle.cupertino
                    : UpgradeDialogStyle.material,
              ),
              child: _showPage),
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              elevation: 10,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat,
                    size: 25,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.group,
                    size: 25,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 25,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 25,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: appProvider.imageUrl != ""
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CachedNetworkImage(
                              height: 50,
                              width: 50,
                              imageUrl: "$appUrl/${appProvider.imageUrl}",
                              fit: BoxFit.fill,
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                        child: CircularProgressIndicator(
                                            value: progress.progress),
                                      )))
                      : CircleAvatar(
                          radius: 25,
                          child: Center(
                              child: Image.asset(
                            "assets/user.png",
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                          )),
                        ),
                  label: '',
                ),
              ],
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: pageIndex,
              selectedItemColor: Colors.purple,
              unselectedItemColor: Color(0xff4B0973),
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
}*/
