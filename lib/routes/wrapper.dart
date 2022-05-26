import 'package:flutter/material.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/routes/authenticate.dart';
import 'package:flutterui/routes/mainpage.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel?>(context);
    // return either mainpage or Authenticate widget

    if (user == null) {
      return Authenticate();
    }
    else {
      return MainPage();
    }
  }
}