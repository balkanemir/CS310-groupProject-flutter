import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/main.dart';
import 'package:flutterui/models/Follower.dart';
import 'package:flutterui/models/comment1.dart';
import 'package:flutterui/routes/notificationPage.dart';
import 'package:flutterui/routes/search.dart';
import 'package:flutterui/routes/zoomedImage.dart';
import 'package:flutterui/services/databaseRead.dart';
import 'package:flutterui/models/user1.dart';
import 'package:flutterui/models/post1.dart';
import 'package:flutterui/routes/settings.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/ui/post_card_template.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/routes/mainpage.dart';
import 'package:flutterui/routes/editProfile.dart';
import 'package:flutterui/routes/followerList.dart';
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
  List<Comment> comment = [
    Comment(
      userID: "",
      postID: "",
      commentID: "",
      commentText: "",
    )
  ];
  int _currentindex = -1;

  _ProfileState();
  void _updateName(String name) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'name': name});
  }

  void _updateSurname(String surname) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'surname': surname});
  }

  void _updateUsername(String username) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'username': username});
  }

  void _updateEmail(String email) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'email': email});
  }

  void _updateMbti(String mbti) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'MBTI': mbti});
  }

  void _updatePrivate(bool private) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'isPrivate': private});
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var uid = auth.currentUser!.uid;
    AppAnalytics.logCustomEvent("Profile_Page", <String, dynamic>{});
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: textOnSecondaryWhite,
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search()));
            }
            if (_currentindex == 2) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Shuffle()));
            }
            if (_currentindex == 3) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shuffle), label: 'Shuffle'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notifications')
          ]),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(230.0),
        child: Container(
          height: 230,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 19.0, right: 8.0, left: 8.0),
            child: Column(
              children: [
                FutureBuilder<User1?>(
                    future: readUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong.');
                      }
                      if (snapshot.hasData && snapshot.data == null) {
                        return Text("Document does not exist");
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        splashFactory: NoSplash.splashFactory),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ZoomedImage(
                                              image:
                                                  "${snapshot.data?.profileImage}"),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: secondaryPinkLight,
                                      backgroundImage: NetworkImage(
                                        snapshot.data!.profileImage,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "${snapshot.data?.name} ${snapshot.data?.surname} (${snapshot.data?.username})",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            FutureBuilder<List<Post?>>(
                                future: readPostOfUser(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    print(snapshot.error);
                                    return Text('Something went wrong.');
                                  }
                                  if (snapshot.hasData &&
                                      snapshot.data == null) {
                                    return Text("Document does not exist");
                                  } else {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${snapshot.data?.length}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("Posts"),
                                      ],
                                    );
                                  }
                                }),
                            FutureBuilder<List<Follower?>>(
                                future: readFollowingsOfUser(uid),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    print(snapshot.error);
                                    return Text('Something went wrong.');
                                  }
                                  if (snapshot.hasData &&
                                      snapshot.data == null) {
                                    return Text("Document does not exist");
                                  } else {
                                    return TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FollowerList(
                                              followers: snapshot.data,
                                              title: "Followings",
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${snapshot.data?.length}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text("Following"),
                                        ],
                                      ),
                                    );
                                  }
                                }),
                            FutureBuilder<List<Follower?>>(
                                future: readFollowersOfUser(uid),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    print(snapshot.error);
                                    return Text('Something went wrong.');
                                  }
                                  if (snapshot.hasData &&
                                      snapshot.data == null) {
                                    return Text("Document does not exist");
                                  } else {
                                    return TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FollowerList(
                                              followers: snapshot.data,
                                              title: "Followers",
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${snapshot.data?.length}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text("Followers"),
                                        ],
                                      ),
                                    );
                                  }
                                }),
                          ],
                        );
                      }
                    }),
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: FutureBuilder<User1?>(
                        future: readUser(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong.');
                          }
                          if (snapshot.hasData && snapshot.data == null) {
                            return Text("Document does not exist");
                          } else {
                            return ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                      snapshot.data,
                                      _updateName,
                                      _updateSurname,
                                      _updateUsername,
                                      _updateEmail,
                                      _updateMbti,
                                      _updatePrivate,
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
                            );
                          }
                        })),
              ],
            ),
          )),
        ),
      ),
      body: FutureBuilder<List<Post?>>(
          future: readPostOfUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Something went wrong.');
            }
            if (snapshot.hasData && snapshot.data == null) {
              return Text("Document does not exist");
            } else {
              return SizedBox(
                height: screenSize(context).height,
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    Post? post = snapshot.data?[index];
                    String? uid = snapshot.data?[index]?.userID;
                    if (post != null && uid != null) {
                      return PostCardTemplate(
                        uid: uid,
                        post: post,
                      );
                    } else {
                      return Text("");
                    }
                  },
                  itemCount: snapshot.data?.length,
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Setting()));
          },
          backgroundColor: secondaryPink800,
          child: Icon(Icons.settings)),
    );
  }
}
