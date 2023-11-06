/*import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/screens/profile/edit_profile_setup.dart';
import 'package:social_betting_predictions/widgets/TextWidgets/poppins_text.dart';
import 'package:social_betting_predictions/widgets/progressBtn/progess_btn.dart';

class About extends StatelessWidget {
  About();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: PoppinsText(
                text: "Bio",
                clr: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ReadMoreText(
              "I am a Developer",
              trimLines: 2,
              style: TextStyle(color: Colors.black),
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontFamily: "poppins",
                  letterSpacing: 1),
              lessStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "poppins",
                  letterSpacing: 1),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 0,
            color: mycolor,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: PoppinsText(
                text: "Member Since",
                clr: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: PoppinsText(
                text: "10/11/2022",
                clr: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: PoppinsText(
                text: "Last Active",
                clr: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: PoppinsText(
                text: "10/11/2022",
                clr: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20),
          Divider(
            thickness: 0,
            color: mycolor,
          ),
          SizedBox(height: 30),
          Button(
              text: "Edit Profile",
              animate: false,
              context: context,
              callback: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => EditProfile()));
              }),
        ],
      ),
    );
  }
}*/
