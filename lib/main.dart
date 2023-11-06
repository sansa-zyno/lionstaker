import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_betting_predictions/constants/app.dart';
import 'package:social_betting_predictions/controller/on_boarding_provider.dart';
import 'package:social_betting_predictions/screens/home.dart';
import 'package:social_betting_predictions/screens/login.dart';
import 'package:social_betting_predictions/screens/onboarding.dart';
import 'package:social_betting_predictions/provider/app_provider.dart';
import 'package:social_betting_predictions/services/local_storage.dart';

void callback(String id, DownloadTaskStatus status, int progress) {
  log(id);
  log(status.toString());
  log(progress.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false, ignoreSsl: true);
  FlutterStatusbarcolor.setStatusBarColor(
    Colors.transparent,
  );
  await FlutterDownloader.registerCallback(callback);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String? username;
  bool? onboaded;
  bool loading = false;

  getUserData() async {
    loading = true;
    setState(() {});
    username = await LocalStorage().getString("username");
    try {
      onboaded = await LocalStorage().getBool("onboarded");
    } catch (e) {
      onboaded = false;
    }
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: ChangeNotifierProvider<OnboardingProvider>(
        create: (context) => OnboardingProvider(),
        child: GetMaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: GoogleFonts.nunitoTextTheme()),
          debugShowCheckedModeBanner: false,
          home: loading
              ? SafeArea(
                  child: Scaffold(
                      body: Center(
                          child: SpinKitFadingCircle(
                    color: buttoncolor,
                  ))),
                )
              : username != null
                  ? Home(
                      username: username!,
                      pageIndex: 0,
                    )
                  : onboaded == true
                      ? Login()
                      : OnBoarding(),
        ),
      ),
    );
  }
}
