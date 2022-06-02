import 'package:flutter/material.dart';
import 'package:flutterui/main.dart';

import 'package:flutterui/models/User.dart';
import 'package:flutterui/models/user1.dart';
import 'package:flutterui/routes/settings.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/ui/post_card_template.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/routes/mainpage.dart';
import 'package:flutterui/models/Post.dart';
import 'package:flutterui/routes/editProfile.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/services/analytics.dart';

class Profile extends StatefulWidget {
  static const String routeName = '/profile';
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState(uid);
}

class _ProfileState extends State<Profile> {
  final String uid;
  User? user;
  List<Post> posts = [
    Post(
      1000,
      DateTime.utc(1989, 7, 20),
      10,
      5,
      text:
          '\"I have often laughed at the weaklings who thought themselves good because they had no claws. \" Nietzsche',
    ),
    Post(
      1001,
      DateTime.utc(2001, 11, 10),
      20,
      7,
      image:
          "https://pz0fpvezntt4.merlincdn.net/Skins/shared/images/yazar/desktop/Friedrich%20Nietzsche_2.png",
    ),
    Post(
      1002,
      DateTime.utc(2007, 4, 11),
      2,
      0,
      text:
          '\"You will never reach your destination if you stop and throw stones at every dog that barks\" Churchill',
      image:
          "https://upload.wikimedia.org/wikipedia/commons/b/bc/Sir_Winston_Churchill_-_19086236948.jpg",
    ),
    Post(
      1003,
      DateTime.utc(2011, 1, 12),
      30,
      10,
      text: '\"It is double pleasure to deceive the deceiver. \" Machiavelli',
    ),
    Post(
      1004,
      DateTime.utc(2021, 7, 20),
      5,
      2,
      image:
          "https://upload.wikimedia.org/wikipedia/commons/e/e2/Portrait_of_Niccol%C3%B2_Machiavelli_by_Santi_di_Tito.jpg",
    ),
    Post(
      1005,
      DateTime.utc(1914, 5, 11),
      125,
      15,
      text:
          '\"Government is necessary, not because man is naturally bad... but because man is by nature more individualistic than social\" Nietzsche',
      image:
          "https://upload.wikimedia.org/wikipedia/commons/d/d6/Thomas_Hobbes_by_John_Michael_Wright_%282%29.jpg",
    ),
  ];
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

  _ProfileState(this.uid);

  void _updateName(String name) {
    setState(() {
      user?.name = name;
    });
  }

  void _updateSurname(String surname) {
    setState(() {
      user?.surname = surname;
    });
  }

  void _updateUsername(String username) {
    setState(() {
      user?.username = username;
    });
  }

  void _updateEmail(String email) {
    setState(() {
      user?.email = email;
    });
  }

  void _updateMbti(String mbti) {
    setState(() {
      user?.MBTI = mbti;
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainPage()));
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
                              user!.profileImage,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${user?.name} ${user?.surname} (${user?.username})",
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
                          user!.following.toString(),
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
                          user!.followers.toString(),
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
                          user,
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
      body: FutureBuilder<User?>(
          future: readUser(uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong.');
            } else {
              if (snapshot.hasData) {
                user = snapshot.data;
                return user == null
                    ? Center(child: Text('No User?'))
                    : PostCardTemplate( user: user, post: posts[0]);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }
          }),

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
