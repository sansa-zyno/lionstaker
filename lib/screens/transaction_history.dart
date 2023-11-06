import 'package:provider/provider.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:social_betting_predictions/screens/funding/funding_history.dart';
import 'package:social_betting_predictions/screens/withdrawal_history.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';
import 'package:social_betting_predictions/widgets/menu.dart';

class TransactionHistory extends StatefulWidget {
  String username;
  TransactionHistory({Key? key, required this.username}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return DefaultTabController(
        length: 2,
        child: BaseUI(
            wid: Column(
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
                  "Transaction History",
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
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15, left: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Account Name: "),
                            SizedBox(
                              width: 8,
                            ),
                            Text("Aderele Omotayo")
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Edit Details",
                              style: TextStyle(color: Colors.pink),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.edit,
                              color: Colors.pink,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text("Account Number: "),
                        SizedBox(
                          width: 8,
                        ),
                        Text("231 XXX XXXX")
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text("Bank: "),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Access Bank")
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Wallet Balance"),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "NGN900",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text("Bronze Subscription: "),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Access NGN2,000")
                      ],
                    ),
                  ]),
            ),
            TabBar(
              //indicatorColor: Colors.black,
              unselectedLabelColor: Colors.grey,

              labelColor: mycolor,
              indicatorColor: mycolor,
              tabs: [
                Tab(
                  child: Row(children: [
                    Text("Withdrawal History", style: TextStyle(fontSize: 16)),
                  ]),
                ),
                Tab(
                  child: Row(children: [
                    Text("Funding History", style: TextStyle(fontSize: 16))
                  ]),
                ),
              ],
            ),
            Expanded(
              child:
                  TabBarView(children: [WithdrawalHistory(), FundingHistory()]),
            ),
          ],
        )));
  }
}
