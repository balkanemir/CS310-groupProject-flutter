import 'package:flutter/material.dart';
import 'package:flutterui/routes/login.dart';
import 'package:flutterui/services/auth.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';

class Settings extends StatelessWidget {
  static const String routeName = '/settings';
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70.0,
          backgroundColor: secondaryPinkLight,
          title: Text('Settings',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: Column(children: [
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text('Sign out', style: TextStyle(color: Colors.red)),
                style: ElevatedButton.styleFrom(primary: Colors.white60)),
          )
        ]));
  }
}
