import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/routes/login.dart';
import 'package:flutterui/routes/mainpage.dart';
import 'package:flutterui/routes/search.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/routes/signup.dart';
import 'package:flutterui/routes/profile.dart';
import 'package:flutterui/routes/editProfile.dart';
import 'package:flutterui/routes/walkthrough.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String initRoute = showHome ? '/mainpage' : '/walkthrough';

  runApp(MaterialApp(initialRoute: initRoute, routes: {

    Login.routeName: (context) => Login(),
    SignUp.routeName: (context) => SignUp(),
    WalkthroughScreen.routeName: (context) => const WalkthroughScreen(),
    Shuffle.routeName: (context) => Shuffle(),
    MainPage.routeName: (context) => MainPage(),
    Profile.routeName: (context) => Profile(),
    Search.routeName: (context) => Search(),
  }));
}
