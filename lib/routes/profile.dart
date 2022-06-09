import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/main.dart';
import 'package:flutterui/models/Follower.dart';
import 'package:flutterui/models/comment1.dart';
import 'package:flutterui/services/databaseRead.dart';
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
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: secondaryPinkLight,
                                    backgroundImage: NetworkImage(
                                      "${snapshot.data?.profileImage}",
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
                                future: readFollowingsOfUser(),
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
                                        Text("Following"),
                                      ],
                                    );
                                  }
                                }),
                            FutureBuilder<List<Follower?>>(
                                future: readFollowersOfUser(),
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
                                        Text("Followers"),
                                      ],
                                    );
                                  }
                                }),
                          ],
                        );
                      }
                    }),
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
                    return PostCardTemplate(
                      uid: snapshot.data![index]!.userID,
                      post: snapshot.data![index]!,
                    );
                  },
                  itemCount: snapshot.data!.length,
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Settings()));
          },
          backgroundColor: secondaryPink800,
          child: Icon(Icons.settings)),
    );
  }
}
