import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/main.dart';
import 'package:flutterui/models/comment1.dart';

import 'package:flutterui/models/user1.dart';
import 'package:flutterui/models/post1.dart';
import 'package:flutterui/routes/settings.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/ui/post_card_template.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/routes/mainpage.dart';
import 'package:flutterui/routes/editProfile.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/services/analytics.dart';

class Profile extends StatefulWidget {
  static const String routeName = '/profile';
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //final String uid;
  User1? users;
  Post? post;
  Comment? comments;

  // User?Model user? = User?Model(
  //     profile_image:
  //         'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png',
  //     id: '10000',
  //     name: 'Metehan',
  //     surname: 'Koç',
  //     user?name: 'kocmetehan',
  //     email: 'kocmetehan@example.com',
  //     MBTI_type: 'ISTJ',
  //     following: 12,
  //     followers: 78);
  int _currentindex = -1;

  _ProfileState();

  void _updateName(String name) {
    setState(() {
      users?.name = name;
    });
  }

  void _updateSurname(String surname) {
    setState(() {
      users?.surname = surname;
    });
  }

  void _updateUsername(String username) {
    setState(() {
      users?.username = username;
    });
  }

  void _updateEmail(String email) {
    setState(() {
      users?.email = email;
    });
  }

  void _updateMbti(String mbti) {
    setState(() {
      users?.MBTI = mbti;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppAnalytics.logCustomEvent("Profile_Page", <String, dynamic>{});
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: primaryPink200,
          selectedItemColor: secondaryPink800,
          unselectedItemColor: secondaryPink800,
          selectedFontSize: 18.0,
          unselectedFontSize: 18.0,
          onTap: (value) {
            setState(() => _currentindex = value);
            if (_currentindex == 0) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            }
            if (_currentindex == 1) {
              //Search Navigator
            }
            if (_currentindex == 2) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Shuffle()));
            }
            if (_currentindex == 3) {
              // Add Navigator
            }
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shuffle), label: 'Shuffle'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notifications')
          ]),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(170.0),
        child: Container(
          height: 200,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 8.0, left: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: secondaryPinkLight,
                            backgroundImage: NetworkImage(
                              users!.profileImage,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${users?.name} ${users?.surname} (${users?.username})",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "12",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Posts"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          users!.following.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Following"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          users!.followers.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Followers"),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(
                          users,
                          _updateName,
                          _updateSurname,
                          _updateUsername,
                          _updateEmail,
                          _updateMbti,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    primary: secondaryPink800,
                    elevation: 5,
                  ),
                  child: Text(
                    "Edit Profile",
                  ),
                ),
              ],
            ),
          )),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryPink200, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      /*
      body: FutureBuilder<User1?>(
          future: readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong.');
            } else {
              if (snapshot.hasData) {
                users = snapshot.data;
                final FirebaseAuth auth = FirebaseAuth.instance;
                var uid = auth.currentUser!.uid;
                return users == null
                    ? Center(child: Text('No User?'))
                    : PostCardTemplate(uid: uid, user: users, post: post, comment: comment);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }
          }),
      */

      // SizedBox(
      //   height: screenSize(context).height,
      //   child: ListView.builder(
      //     itemBuilder: (ctx, index) {
      //       return PostCardTemplate(
      //         user?: user?,
      //         post: posts[index],
      //       );
      //     },
      //     itemCount: posts.length,
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (context) => Settings()));
      //     },
      //     backgroundColor: secondaryPink800,
      //     child: Icon(Icons.settings)),
    );
  }
}
