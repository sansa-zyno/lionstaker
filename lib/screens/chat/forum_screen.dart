import 'package:provider/provider.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/provider/app_provider.dart';
import 'package:social_betting_predictions/widgets/chat_bottombar.dart';
import 'package:social_betting_predictions/widgets/chat_messages.dart';
import 'package:flutter/material.dart';

class ForumScreen extends StatefulWidget {
  String username;
  ForumScreen({required this.username});
  //final OurUser recipient;
  //final String chatRoomid;
  //ForumScreen(this.recipient, this.chatRoomid);
  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  initState() {
    super.initState();
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getForumData();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width / 100;
    final h = MediaQuery.of(context).size.height / 100;
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //SizedBox(height: h * 13.7),
              appProvider.forumData != null
                  ? Expanded(
                      child: ChatMessages(
                          forum: true,
                          data: appProvider.forumData!,
                          username: widget.username))
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: CircularProgressIndicator(
                        color: buttoncolor,
                      )),
            ],
          ),
          /*ChatAppBar(
            icon: Icons.arrow_back,
          ),*/
          Align(
            alignment: Alignment.bottomCenter,
            child: ChatBottomBar(
              sender: widget.username,
              forum: true,
            ),
          ),
        ],
      ),
    );
  }
}
