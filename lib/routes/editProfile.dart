//import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' show basename;
import 'dart:io' show Platform;
import 'package:image_picker/image_picker.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/models/user1.dart';
import 'package:flutterui/services/analytics.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:checkbox_formfield/checkbox_formfield.dart';

class EditProfile extends StatefulWidget {
  final User1? user;
  final Function updateName;
  final Function updateSurname;
  final Function updateUsername;
  final Function updateEmail;
  final Function updateMbti;
  final Function updateBio;
  final Function updatePrivate;

  EditProfile(
    this.user,
    this.updateName,
    this.updateSurname,
    this.updateUsername,
    this.updateEmail,
    this.updateBio,
    this.updateMbti,
    this.updatePrivate,
  );

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String mbtiValue = "";
  String name = "";
  String surname = "";
  String username = "";
  String email = "";
  String? bio = "";
  XFile? _image;
  bool isPrivate = false;
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
  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    try {
      await firebaseStorageRef.putFile(File(_image!.path));
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({'profileImage': await firebaseStorageRef.getDownloadURL()});
      print('Upload completed image');
      setState(() {
        _image = null;
      });
    } on FirebaseException catch (e) {
      print('ERROR: ${e.code} - ${e.message}');
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateImage() async {
    final ImagePicker _picker = ImagePicker();
    _image = await _picker.pickImage(source: ImageSource.gallery);
  }

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
    mbtiValue = widget.user!.MBTI;
    name = widget.user!.name;
    email = widget.user!.email;
    surname = widget.user!.surname;
    username = widget.user!.username;
    bio =  widget.user!.bio;
    isPrivate = widget.user!.isPrivate;
  }

  @override
  Widget build(BuildContext context) {
    AppAnalytics.logCustomEvent("Edit_Profile_Page", <String, dynamic>{});
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryPinkDark ,
        centerTitle: true,
        title: Text("Edit Profile"),
      ),
      body: Container(
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
                        child: ClipOval(
                          child: IconButton(
                            iconSize: 150,
                            onPressed: () async {
                              await updateImage();
                              await uploadImageToFirebase(context);
                            },
                            icon: Image.network(
                              widget.user!.profileImage,
                              fit: BoxFit.cover,
                              width: 90.0,
                              height: 90.0,
                            ),
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
                              bio = value;
                            },
                            controller: TextEditingController(
                              text: bio,
                            ),
                            onSaved: (value) {
                              widget.updateBio(value);
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
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            "Private",
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
                          child: CheckboxListTileFormField(
                            checkColor: Colors.white,
                            initialValue: isPrivate,
                            onChanged: (bool? value) {
                              setState(() {
                                isPrivate = value!;
                              });
                            },
                            onSaved: (value) {
                              widget.updatePrivate(value);
                            },
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
