import 'package:flutter/material.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
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
      child: SingleChildScrollView(
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
                  "Terms and Conditions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer()
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
                "By using our Lionstaker mobile app, you agree to the following terms and conditions:"),
            Text(
                "Eligibility:\nYou must be of legal age in your jurisdiction to use our app. It is your responsibility to ensure compliance with local laws."),
            Text(
                "Account Usage:\nYou are responsible for maintaining the confidentiality of your account information and for all activities conducted under your account."),
            Text(
                "Betting Services:\nOur app provides access to football betting services. By using our betting services, you agree to adhere to our rules and regulations."),
            Text(
                "Deposits and Withdrawals:\nFinancial transactions related to betting activities are subject to our Payment Policy."),
            Text(
                "Responsible Gambling:\nWe promote responsible gambling practices. Set limits for yourself and seek help if you believe you have a gambling problem."),
            Text(
                "Intellectual Property:\nAll intellectual property rights related to our app belong to us or our licensors. Unauthorized use is prohibited."),
            Text(
                "Disclaimer and Limitation of Liability:\nWe provide our app on an \"as is\" basis and shall not be liable for any damages arising from its use."),
            Text(
                "Termination:\nWe reserve the right to terminate or suspend your access to our app at any time."),
            Text(
                "Changes to Terms and Conditions:\nWe may modify or update these terms and conditions at our discretion. Continued use of our app constitutes acceptance of any changes."),
            Text(
                "Please note that this is a summary of our terms and conditions. For the complete terms, please refer to the detailed version provided within the app.")
          ],
        ),
      ),
    ));
  }
}
