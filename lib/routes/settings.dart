import 'package:flutter/material.dart';
import 'package:flutterui/routes/login.dart';
import 'package:flutterui/routes/welcome.dart';
import 'package:flutterui/services/auth.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';
import 'package:flutterui/services/analytics.dart';

class Setting extends StatelessWidget {
  static const String routeName = '/settings';
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    AppAnalytics.logCustomEvent("Settings_Page", <String, dynamic>{});
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => Welcome()),
                    ModalRoute.withName('/'));
                },
                child: Text('Sign out', style: TextStyle(color: Colors.red)),
                style: ElevatedButton.styleFrom(primary: Colors.white60)),
          )
        ]));
  }
}
