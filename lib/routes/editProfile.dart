//import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:io' show Platform;

import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/models/User.dart';

class EditProfile extends StatefulWidget {
  final User user;
  final Function updateName;
  final Function updateSurname;
  final Function updateUsername;
  final Function updateEmail;
  final Function updateMbti;

  EditProfile(this.user, this.updateName, this.updateSurname,
      this.updateUsername, this.updateEmail, this.updateMbti);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String mbtiValue = "";
  String name = "";
  String surname = "";
  String username = "";
  String email = "";
  final _formKey = GlobalKey<FormState>();

  List<String> mbtiTypes = [
    "INTJ",
    "INTP",
    "ENTJ",
    "ENTP",
    "INFJ",
    "INFP",
    "ENFJ",
    "ENFP",
    "ISTJ",
    "ISFJ",
    "ESTJ",
    "ESFJ",
    "ISTP",
    "ISFP",
    "ESTP",
    "ESFP"
  ];

  Future<void> _showDialog(String title, String message) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (isAndroid) {
            return AlertDialog(
              title: Text(
                title,
                style: TextStyle(color: Colors.red),
              ),
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
            return CupertinoAlertDialog(
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

  @override
  void initState() {
    mbtiValue = widget.user.MBTI_type;
    name = widget.user.name;
    email = widget.user.email;
    surname = widget.user.surname;
    username = widget.user.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text("Edit Profile"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryPink200, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: secondaryPinkLight,
                          backgroundImage: NetworkImage(
                            widget.user.profile_image,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      endIndent: 15,
                      thickness: 1,
                      color: Color.fromRGBO(113, 26, 117, 1),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Name",
                            style: TextStyle(
                              color: Color.fromRGBO(87, 10, 87, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints.tight(const Size(250, 50)),
                          child: TextFormField(
                            style: TextStyle(color: Colors.deepPurple),
                            onChanged: (String value) {
                              name = value;
                            },
                            controller: TextEditingController(text: name),
                            onSaved: (value) {
                              widget.updateName(value);
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Surname",
                            style: TextStyle(
                              color: Color.fromRGBO(87, 10, 87, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints.tight(
                            const Size(250, 50),
                          ),
                          child: TextFormField(
                            style: TextStyle(color: Colors.deepPurple),
                            onChanged: (String value) {
                              surname = value;
                            },
                            controller: TextEditingController(text: surname),
                            onSaved: (value) {
                              widget.updateSurname(value);
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Username",
                            style: TextStyle(
                              color: Color.fromRGBO(87, 10, 87, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints.tight(const Size(250, 50)),
                          child: TextFormField(
                            style: TextStyle(color: Colors.deepPurple),
                            onChanged: (String value) {
                              username = value;
                            },
                            controller: TextEditingController(
                              text: username,
                            ),
                            onSaved: (value) {
                              widget.updateUsername(value);
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Email",
                            style: TextStyle(
                              color: Color.fromRGBO(87, 10, 87, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints.tight(const Size(250, 50)),
                          child: TextFormField(
                            style: TextStyle(color: Colors.deepPurple),
                            onChanged: (String value) {
                              email = value;
                            },
                            controller: TextEditingController(
                              text: email,
                            ),
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Cannot leave e-mail empty';
                                }
                                if (!EmailValidator.validate(value)) {
                                  return 'Please enter a valid e-mail address';
                                }
                              }
                            },
                            onSaved: (value) {
                              widget.updateEmail(value);
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "MBTI Type",
                            style: TextStyle(
                              color: Color.fromRGBO(87, 10, 87, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: DropdownButtonFormField<String>(
                            value: mbtiValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            onChanged: (String? value) {
                              mbtiValue = value!;
                            },
                            onSaved: (value) {
                              widget.updateMbti(value);
                            },
                            items: mbtiTypes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print('Email: $email');
                              _formKey.currentState!.save();
                              print('Email: $email');
                            } else {
                              _showDialog('Form Error', 'Your form is invalid');
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            primary: Color.fromRGBO(247, 61, 147, 0.8),
                            backgroundColor: Color.fromRGBO(22, 0, 59, 0.2),
                          ),
                          child: Text("Submit Changes"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
