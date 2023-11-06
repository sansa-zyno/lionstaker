import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/widgets/TextWidgets/poppins_text.dart';
import 'package:social_betting_predictions/widgets/progressBtn/flutter_progress_button.dart';

Widget Button(
    {required String text,
    required bool animate,
    required BuildContext context,
    required VoidCallback callback}) {
  final w = MediaQuery.of(context).size.width / 100;
  final h = MediaQuery.of(context).size.height / 100;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: w * 20.731),
    child: Builder(
      builder: (context) {
        return ProgressButton(
            borderRadius: 30,
            color: buttoncolor,
            animate: animate,
            defaultWidget: PoppinsText(
              text: text,
              fontWeight: FontWeight.w900,
              clr: Colors.white,
            ),
            progressWidget: SpinKitThreeBounce(
              color: Colors.white,
              size: w * 5.0925,
            ),
            width: double.infinity,
            height: 5 * h,
            onPressed: callback);
      },
    ),
  );
}
