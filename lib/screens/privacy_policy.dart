import 'package:flutter/material.dart';
import 'package:social_betting_predictions/widgets/base_ui.dart';

class PrivacyAndPolicy extends StatefulWidget {
  const PrivacyAndPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyAndPolicy> createState() => _PrivacyAndPolicyState();
}

class _PrivacyAndPolicyState extends State<PrivacyAndPolicy> {
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
                  "Privacy Policy",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer()
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
                "At Lionstaker, we are committed to protecting the privacy and security of our users. This Privacy Policy outlines how we collect, use, and safeguard the personal information you provide while using our mobile app. We encourage you to read this policy carefully to understand our practices regarding your data."),
            Text(
                "Information Collection and Use\n1.1. Personal Information:\nWe may collect personal information such as your name, email address, and contact details when you register or create an account with our mobile app. This information is necessary to provide you with access to our betting services and to communicate important updates or promotional offers."),
            Text(
                "1.2. Financial Information:\nIn order to facilitate transactions, we may collect and securely store financial information, such as credit card details or payment account information. We ensure that appropriate security measures are in place to protect this sensitive data."),
            Text(
                "1.3. Usage Information:\nWe may collect non-personal information about how you interact with our mobile app, including device information, IP address, browsing activities, and app usage patterns. This information is used to improve our services, personalize your experience, and analyze trends."),
            Text(
                "Data Security\n2.1. Data Protection:\nWe implement industry-standard security measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction. These measures include secure socket layer (SSL) encryption, regular security audits, and access controls."),
            Text(
                "2.2. Confidentiality:\nWe ensure that only authorized personnel have access to your personal information, and we strictly enforce confidentiality obligations upon our employees and service providers."),
            Text(
                "Information Sharing and Disclosure\n3.1. Third-Party Service Providers:\nWe may engage trusted third-party service providers to assist in delivering our services. These providers may have access to your personal information solely for the purpose of performing their functions on our behalf and are bound by confidentiality obligations."),
            Text(
                "3.2. Legal Requirements:\nWe may disclose your personal information if required to do so by law or in response to valid legal requests or court orders."),
            Text(
                "Cookies and Tracking Technologies\n4.1. Cookies:\nOur mobile app may use cookies and similar tracking technologies to enhance your browsing experience and collect usage information. You have the option to disable cookies through your device settings; however, this may affect the functionality and performance of our app."),
            Text(
                "Updates to the Privacy Policy\n5.1. Policy Changes:\nWe reserve the right to modify or update this Privacy Policy at any time. Any changes will be effective immediately upon posting the revised policy on our mobile app. We encourage you to review this policy periodically to stay informed about how we collect, use, and protect your information."),
            Text(
                "Contact Us\n6.1. If you have any questions or concerns regarding our Privacy Policy or the privacy practices of our mobile app, please contact us by filling our contact form here"),
            Text(
                "By using the Lionstaker app, you agree to the collection, use, and disclosure of your personal information as described in this Privacy Policy. We value your trust and are committed to ensuring that your privacy is protected.")
          ],
        ),
      ),
    ));
  }
}
