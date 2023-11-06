import 'package:flutter/material.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/screens/funding/fund_with_bank.dart';
import 'package:social_betting_predictions/screens/funding/fund_with_netteller.dart';
import 'package:social_betting_predictions/screens/funding/fund_with_skrill.dart';
import 'package:social_betting_predictions/screens/transaction_history.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';

class FundWallet extends StatelessWidget {
  FundWallet({Key? key}) : super(key: key);

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
                "Fund Wallet",
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
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => FundWithBank()));
                },
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: buttoncolor),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Image.asset("assets/bank.png"),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Fund with Bank ")
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => FundWithSkrill()));
                },
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: buttoncolor),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Image.asset("assets/skrill.png"),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Fund with Skrill ")
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => FundWithNetteller()));
                },
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: buttoncolor),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Image.asset("assets/netletter.png"),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Fund with Netteller ")
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => TransactionHistory(
                                username: "",
                              )));
                },
                child: Container(
                    width: 100,
                    child: Text("View Funding History",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: buttoncolor))),
              ),
              SizedBox(
                width: 30,
              )
            ],
          )
        ],
      ),
    ));
  }
}
