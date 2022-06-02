import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/main.dart';
import 'package:flutterui/routes/login.dart';
import 'package:flutterui/routes/mainpage.dart';
import 'package:flutterui/services/auth.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutterui/services/analytics.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/signup';

  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String pass = "";
  String name = "";
  String surname = "";
  String MBTI = "";
  final AuthService _auth = AuthService();

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'ISTJ',
      'label': 'ISTJ',
    },
    {
      'value': 'ISFJ',
      'label': 'ISFJ',
    },
    {
      'value': 'INFJ',
      'label': 'INFJ',
    },
    {
      'value': 'ISTP',
      'label': 'ISTP',
    },
    {
      'value': 'ISFP',
      'label': 'ISFP',
    },
    {
      'value': 'INFP',
      'label': 'INFP',
    },
    {
      'value': 'INTP',
      'label': 'INTP',
    },
    {
      'value': 'ESTP',
      'label': 'ESTP',
    },
    {
      'value': 'ESFP',
      'label': 'ESFP',
    },
    {
      'value': 'ENFP',
      'label': 'ENFP',
    },
    {
      'value': 'ENTP',
      'label': 'ENTP',
    },
    {
      'value': 'ESTJ',
      'label': 'ESTJ',
    },
    {
      'value': 'ESFJ',
      'label': 'ESFJ',
    },
    {
      'value': 'ENFJ',
      'label': 'ENFJ',
    },
    {
      'value': 'ENTJ',
      'label': 'ENTJ',
    },
  ];


  Widget build(BuildContext context) {
    AppAnalytics.logCustomEvent("Sign_Up_Page", <String, dynamic>{});
    return Scaffold(
        backgroundColor: secondaryBackgroundWhite,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            child: Container(
                height: 150,
                child: Center(
                    child: Text("soulmate",
                        style: TextStyle(
                          fontFamily: "DancingScript",
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: secondaryPink800,
                        ))),
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
                      child: Text("Sign Up",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 100,
                        height: 50,
                        child: TextFormField(
                            onChanged: (value) {
                              setState(() => name = value);
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              label: Container(
                                  width: 100,
                                  child: Row(children: [
                                    const SizedBox(width: 4),
                                    const Text('Name')
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
                                  return "Cannot leave name empty";
                                }
                              }
                            },
                            onSaved: (value) {
                              name = value ?? "";
                            })),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 100,
                        height: 50,
                        child: TextFormField(
                            onChanged: (value) {
                              setState(() => surname = value);
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              label: Container(
                                  width: 100,
                                  child: Row(children: [
                                    const SizedBox(width: 4),
                                    const Text('Surname')
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
                                  return "Cannot leave surname empty";
                                }
                              }
                            },
                            onSaved: (value) {
                              surname = value ?? "";
                            })),
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
                        margin: EdgeInsets.only(top: 10),
                        width: 100,
                        height: 50,
                        child: TextFormField(
                            onChanged: (value) {
                              setState(() => pass = value);
                            },
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
                            })),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 100,
                        height: 50,
                        child: SelectFormField(
                          onChanged: (value) {
                            setState(() => MBTI = value);
                          },
                          type:
                              SelectFormFieldType.dropdown, // or can be dialog
                          initialValue: 'circle',
                          labelText: 'MBTI Type',
                          items: _items,
                          onSaved: (val) => print(val),
                          decoration: InputDecoration(
                            label: Container(
                                width: 150,
                                child: Row(children: [
                                  const Icon(Icons.arrow_drop_down),
                                  const SizedBox(width: 4),
                                  const Text('MBTI Type')
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
                                return "Cannot leave MBTI type empty";
                              }
                            }
                          },
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: InkWell(
                          child: Center(
                              child: Text('Learn Your MBTI Type!',
                                  style: TextStyle(
                                    color: secondaryPink800,
                                  ))),
                          // ignore: deprecated_member_use
                          onTap: () => launch(
                              'https://my-personality-test.com/?gclid=CjwKCAjwgr6TBhAGEiwA3aVuIdpZmKCjr1My_uaRkfGGzspoHPNdSJR8csXwy4H-2wR7KQgiWSFARRoCM_8QAvD_BwE')),
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, pass);
                            createUser(id: result.id, email: email, profile_image: 'https://banner2.cleanpng.com/20180722/gfc/kisspng-user-profile-2018-in-sight-user-conference-expo-5b554c0968c377.0307553315323166814291.jpg', followers: 0, following: 0, bio: '', name: name, username: '', surname: surname, MBTI_type: MBTI);
                            
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()));
                          }
                          ;
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
                    SizedBox(height: 15.0),
                    Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Center(child: Text("Do you have an account?"))),
                    SizedBox(height: 5.0),
                    Container(
                      margin: EdgeInsets.only(bottom: 50.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: secondaryPink800,
                          ),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Center(
                                  child: Text("Login",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: textOnSecondaryWhite,
                                      ))))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
