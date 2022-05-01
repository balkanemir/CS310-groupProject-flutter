import 'package:flutter/material.dart';
import 'package:flutterui/routes/signup.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();

  static const String routeName = '/login';
}

class _LoginState extends State<Login> {
  @override
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String pass = "";

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            child: Container(
                height: 200,
                child: Center(
                    child: Text("SOULMATE",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [primaryPink200, Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)))),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text("LOGIN", style: TextStyle(fontSize: 28)),
                  ),
                  Container(
                      width: 100,
                      height: 50,
                      child: TextFormField(
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
                                  color: primaryPink200,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryPink200,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          validator: (value) {
                            if (value != null) {
                              if (value.isEmpty) {
                                return "Cannot leave e-mail empty";
                              }
                              // if(!EmailValidator.validate(value)) {
                              //   return "Please enter a valid e-mail address";
                              // }
                            }
                          },
                          onSaved: (value) {
                            email = value ?? "";
                          })),
                  Container(
                      width: 100,
                      height: 50,
                      child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            label: Container(
                                width: 150,
                                child: Row(children: [
                                  const Icon(Icons.password),
                                  const SizedBox(width: 4),
                                  const Text('Password')
                                ])),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryPink200,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryPink200,
                                  width: 2.0,
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
                          })),
                  Container(
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print("Email: $email");
                            _formKey.currentState!.save();
                            print("Email: $email");
                            // getUsers();
                          } else {
                            //_showDialog("Form Error", "Your form is invalid");
                          }
                          ;
                        },
                        style: ElevatedButton.styleFrom(
                          primary: secondaryPink800,
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Center(
                                child: Text("Login",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: textOnSecondaryWhite,
                                    ))))),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 40.0),
                      child: Center(child: Text("You don't have an account?"))),
                  Container(
                    margin: EdgeInsets.only(bottom: 100.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: secondaryPinkDark,
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Center(
                                child: Text("Sign Up",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: textOnSecondaryWhite,
                                    ))))),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
