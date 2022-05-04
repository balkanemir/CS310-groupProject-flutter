import 'package:flutter/material.dart';
import 'package:flutterui/routes/login.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/routes/signup.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/shuffle',
       routes: {
         Login.routeName: (context) => Login(),
         SignUp.routeName: (context) => SignUp(),
         Shuffle.routeName: (context) => Shuffle(),
         }));
}
