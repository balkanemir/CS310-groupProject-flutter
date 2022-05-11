import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/routes/login.dart';
import 'package:flutterui/routes/mainpage.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/routes/signup.dart';
import 'firebase_options.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      initialRoute: '/mainpage',
      routes: {
        Login.routeName: (context) => Login(),
        SignUp.routeName: (context) => SignUp(),
        Shuffle.routeName: (context) => Shuffle(),
        MainPage.routeName: (context) => MainPage(),
        }));
}
