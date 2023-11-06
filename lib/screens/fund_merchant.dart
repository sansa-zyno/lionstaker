import 'package:flutter/material.dart';
import 'package:social_betting_predictions/widgets/TextWidgets/rounded_textfield.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';
import 'package:social_betting_predictions/widgets/menu.dart';
import 'package:social_betting_predictions/widgets/progressBtn/progess_btn.dart';

class FundMerchant extends StatefulWidget {
  const FundMerchant({Key? key}) : super(key: key);

  @override
  State<FundMerchant> createState() => _FundMerchantState();
}

class _FundMerchantState extends State<FundMerchant> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController amountController = TextEditingController();
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
                "Fund Merchant",
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
          Text(
            "Hi Aderele, Your wallet balance is #900",
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
                  Image.asset("assets/wallet.png"),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "#900 Wallet Balance",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: RoundedTextField(
                    hint: "Amount to fund merchant",
                    type: TextInputType.number,
                    obsecureText: false,
                    icon: Icon(
                      Icons.badge,
                      color: Color(0xff00AEFF),
                    ),
                    iconColor: Colors.cyan,
                    label: "",
                    controller: amountController,
                    onChange: (text) {},
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Button(
              text: "Fund Merchant",
              animate: true,
              context: context,
              callback: () {})
        ],
      ),
    ));
  }
}
