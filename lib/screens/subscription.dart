import 'package:flutter/material.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';
import 'package:social_betting_predictions/widgets/menu.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BaseUI(
        wid: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0,
                offset: Offset(2, 2),
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 8,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  )),
              Spacer(),
              Text(
                "Subscription",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer()
            ],
          ),
          Divider(
            color: Colors.black45,
            thickness: 1,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Hi Aderele, You current have 2,000 Bronze Subscription",
            style: TextStyle(),
          ),
          SizedBox(
            height: 30,
          ),
          Card(
            child: Container(
              width: 150,
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Image.asset("assets/bronze.png"),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "2,000 Active Bronze Subscription",
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Ready to extend your subscription?",
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Click Here",
            style: TextStyle(color: Colors.pink),
          ),
        ],
      ),
    ));
  }
}
