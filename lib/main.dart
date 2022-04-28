import 'package:flutter/material.dart';
import 'package:flutterui/routes/login.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/login',
       routes: {
         Login.routeName: (context) => Login()
         }));
}
