import 'package:flutter/material.dart';

import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/models/User.dart';

class EditProfile extends StatefulWidget {
  final User user;

  EditProfile(this.user);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String dropdownValue = "";
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
  @override
  void initState() {
    dropdownValue = widget.user.MBTI_type;
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
                    thickness: 1,
                    color: Colors.cyan,
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
                        constraints: BoxConstraints.tight(const Size(250, 50)),
                        child: TextFormField(
                          onChanged: (String value) {
                            widget.user.name = value;
                          },
                          controller: TextEditingController(
                              text: "${widget.user.name}"),
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
                        constraints: BoxConstraints.tight(const Size(250, 50)),
                        child: TextFormField(
                          onChanged: (String value) {
                            widget.user.surname = value;
                          },
                          controller: TextEditingController(
                              text: "${widget.user.surname}"),
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
                        constraints: BoxConstraints.tight(const Size(250, 50)),
                        child: TextFormField(
                          onChanged: (String value) {
                            widget.user.username = value;
                          },
                          controller: TextEditingController(
                              text: "${widget.user.username}"),
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
                        constraints: BoxConstraints.tight(const Size(250, 50)),
                        child: TextFormField(
                          onChanged: (String value) {
                            widget.user.email = value;
                          },
                          controller: TextEditingController(
                              text: "${widget.user.email}"),
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
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                              widget.user.MBTI_type = newValue!;
                            });
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
