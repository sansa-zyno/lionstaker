import 'package:provider/provider.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/screens/chat/forum_screen.dart';
import 'package:social_betting_predictions/screens/chat/messages_screen.dart';
import 'package:social_betting_predictions/provider/app_provider.dart';
import 'package:flutter/material.dart';

class ChatHome extends StatefulWidget {
  String username;
  ChatHome({Key? key, required this.username}) : super(key: key);

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            leading: Container(),
            toolbarHeight: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              height: appBarHeight,
              width: double.infinity,
              /*decoration: BoxDecoration(
                color: Color(0xff4B0973),
                border: Border.all(
                  color: Color(0xff4B0973),
                  width: 1,
                ),
              ),*/
              child: TabBar(
                //indicatorColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelColor: mycolor,
                indicatorColor: mycolor,
                tabs: [
                  Tab(
                    child: Row(children: [
                      Text("Recent chats", style: TextStyle(fontSize: 16)),
                      SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 10,
                        child: appProvider.recentChatData != null
                            ? Text(
                                "${appProvider.recentChatData!.length}",
                                style: TextStyle(color: Color(0xff4B0973)),
                              )
                            : Container(),
                      )
                    ]),
                  ),
                  Tab(
                    child: Row(children: [
                      Text("Forum", style: TextStyle(fontSize: 16))
                    ]),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(children: [
            Messages(username: widget.username),
            ForumScreen(username: widget.username)
          ]),
        ));
  }
}
