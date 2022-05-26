import 'package:flutter/material.dart';
import 'package:flutterui/routes/login.dart';
import 'package:flutterui/routes/signup.dart';



class Authenticate extends StatefulWidget {

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override

  bool showLogin = true;

  Widget build(BuildContext context) {
    return Container(
      child: SignUp()); // Should go to welcome page that does not exist now.
  }
}