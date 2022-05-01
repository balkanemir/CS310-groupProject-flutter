import 'package:flutter/material.dart';
import 'package:flutterui/routes/login.dart';
import 'package:flutterui/routes/signup.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/signup',
       routes: {
         Login.routeName: (context) => Login(),
         SignUp.routeName: (context) => SignUp()
         }));
}
