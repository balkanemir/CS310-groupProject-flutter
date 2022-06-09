//import 'dart:ffi';
import 'dart:io' show Platform;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/models/user1.dart';
import 'package:flutterui/routes/signup.dart';
import 'package:flutterui/services/auth.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/routes/mainpage.dart';
import 'package:flutterui/utils/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterui/services/analytics.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();

  static const String routeName = '/login';
}

class _LoginState extends State<Login> {
  @override
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String pass = "";
  String error = "";
  bool _passwordVisible = false;

  final AuthService _auth = AuthService();

  Future<void> _showDialog(String title, String message) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (isAndroid) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          } else {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
        });
  }

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Widget build(BuildContext context) {
    AppAnalytics.logCustomEvent("Login_Page", <String, dynamic>{});
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            child: Container(
                height: 200,
                child: Center(
                  child: Text("soulmate",
                      style: TextStyle(
                        fontFamily: "DancingScript",
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: secondaryPink800,
                      )),
                ),
                decoration: BoxDecoration(
                  color: textOnSecondaryWhite,
                ))),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text("Login",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 100,
                        height: 50,
                        child: TextFormField(
                            onChanged: (value) {
                              setState(() => email = value);
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              label: Container(
                                  width: 100,
                                  child: Row(children: [
                                    const Icon(Icons.email),
                                    const SizedBox(width: 4),
                                    const Text('Email')
                                  ])),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: secondaryPink800,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: textOnPrimaryBlack,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return "Cannot leave e-mail empty";
                                }
                                if (!EmailValidator.validate(value)) {
                                  return "Please enter a valid e-mail address";
                                }
                              }
                            },
                            onSaved: (value) {
                              email = value ?? "";
                            })),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: 100,
                      height: 50,
                      child: TextFormField(
                          onChanged: (value) {
                            setState(() => pass = value);
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            label: Container(
                                width: 150,
                                child: Row(children: [
                                  const Icon(Icons.password),
                                  const SizedBox(width: 4),
                                  const Text('Password')
                                ])),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: secondaryPink800,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(10.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: textOnPrimaryBlack,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          validator: (value) {
                            if (value != null) {
                              if (value.isEmpty) {
                                return "Cannot leave password empty";
                              }
                              if (value.length < 6) {
                                return "Password is too short";
                              }
                            }
                          },
                          onSaved: (value) {
                            pass = value ?? "";
                          }),
                    ),
                    SizedBox(height: 12),
                    Center(
                      child: Text(error,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () async {
                          dynamic result = await _auth
                              .loginWithEmailAndPassword(email, pass);
                          print(result);
                          if (!(result is User1)) {
                            setState(() => error = result);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: secondaryPink800,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: textOnSecondaryWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child:
                            Center(child: Text("You don't have an account?"))),
                    SizedBox(height: 5.0),
                    Container(
                      margin: EdgeInsets.only(bottom: 25.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: secondaryPink800,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: textOnSecondaryWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () async {
                          dynamic user = await _auth.signInWithGoogle();
                          if (user != null) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/mainpage", (route) => false);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: secondaryPink800,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Image.network(
                                //   'http://pngimg.com/uploads/google/google_PNG19635.png',
                                //   height: 20,
                                //   width: 20,
                                // ),
                                Text(
                                  "Sign Up with Google",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: textOnSecondaryWhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
