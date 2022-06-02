import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/routes/search.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/ui/post_card_template.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/routes/profile.dart';
import 'package:flutterui/routes/messages.dart';
import 'package:flutterui/routes/addpost.dart';
import 'package:flutterui/services/analytics.dart';
import 'package:flutterui/models/user1.dart';
import 'package:flutterui/models/post1.dart';
import 'package:flutterui/models/comment1.dart';
import 'package:multi_stream_builder/multi_stream_builder.dart';

import 'notificationPage.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/mainpage';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<User> user = [
    User(
      userID: "melisa",
      name: "Melisa",
      surname: "",
      username: "xxxx",
      email: "",
      profileImage: "",
      MBTI: "",
      following: 3,
      followers: 4,

    )
  ];
    List<Post> post = [
    Post(
      userID: "melisa",
      postID: "dsd",
      date: DateTime(2020,10,10),
      comments: 4,
      postImage: "",
      postText: "",
      likes: 0,
    )
  ];
  List<Comment> comment = [
    Comment(
      userID: "melisa",
      postID: "dsd",
      commentID: "xxx",
      commentText: "ttt",
    )
  ];

  List<UserModel> Users = [
    UserModel(
        profile_image:
            'https://w7.pngwing.com/pngs/193/660/png-transparent-computer-icons-woman-avatar-avatar-girl-thumbnail.png',
        id: '10000',
        name: 'Jane',
        surname: 'Doe',
        username: 'JaneDoe',
        email: 'JaneDoe@example.com',
        MBTI_type: 'ISTJ',
        following: 12,
        followers: 78),
    UserModel(
        profile_image:
            'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
        id: '10000',
        name: 'Jeniffer',
        surname: 'Lawrance',
        username: 'Jeniffer123',
        email: 'Jan@example.com',
        MBTI_type: 'ESFP',
        following: 34,
        followers: 126),
    UserModel(
        profile_image:
            'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
        id: '10000',
        name: 'Jeniffer',
        surname: 'Lawrance',
        username: 'Jeniffer123',
        email: 'Jan@example.com',
        MBTI_type: 'ESFP',
        following: 182,
        followers: 58),
    UserModel(
        profile_image:
            'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
        id: '10000',
        name: 'Jeniffer',
        surname: 'Lawrance',
        username: 'Jeniffer123',
        email: 'Jan@example.com',
        MBTI_type: 'ESFP',
        following: 12,
        followers: 78),
    UserModel(
        profile_image:
            'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
        id: '10000',
        name: 'Jeniffer',
        surname: 'Lawrance',
        username: 'Jeniffer123',
        email: 'Jan@example.com',
        MBTI_type: 'ESFP',
        following: 12,
        followers: 78),
    UserModel(
        profile_image:
            'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
        id: '10000',
        name: 'Jeniffer',
        surname: 'Lawrance',
        username: 'Jeniffer123',
        email: 'Jan@example.com',
        MBTI_type: 'ESFP',
        following: 12,
        followers: 78),
  ];
  final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection('users').snapshots();
  final Stream<QuerySnapshot> posts = FirebaseFirestore.instance.collection('posts').snapshots();
  final Stream<QuerySnapshot> comments = FirebaseFirestore.instance.collection('comments').snapshots();
  
  int _currentindex = 0;
  @override
  Widget build(BuildContext context) {
    AppAnalytics.logCustomEvent("Main_Page", <String, dynamic>{});
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentindex,
            backgroundColor: textOnSecondaryWhite,
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Search()));
              }
              if (_currentindex == 2) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Shuffle()));
              }
              if (_currentindex == 3) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationPage()));
              }
            },
            items:const  [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shuffle), label: 'Shuffle'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: 'Notifications')
            ]),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: Container(
                height: 150,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                        child:const CircleAvatar(
                            radius: 30,
                            backgroundColor: textOnSecondaryWhite,
                            backgroundImage: NetworkImage(
                                'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png')),
                        style: ElevatedButton.styleFrom(
                          primary: secondaryPink800,
                          shape: CircleBorder(),
                        )),
                       const Text("soulmate",
                        style: TextStyle(
                          fontFamily: "DancingScript",
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: secondaryPink800,
                        )),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MessagePage()));
                          },
                          child: Icon(Icons.message_sharp),
                          style: ElevatedButton.styleFrom(
                            primary: primaryPinkLight,
                            shape: CircleBorder(),
                          )),
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            throw Exception();
                          },

                          child: Icon(Icons.error),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: CircleBorder(),
                          )),
                    )
                  ],
                )),
                decoration: const BoxDecoration(
                  color: textOnSecondaryWhite,
                ))),
        body: SizedBox(
          height: screenSize(context).height,
          child: MultiStreamBuilder(
            streams: [users, posts, comments],
            builder: (BuildContext context, snapshots) {
                final userData = snapshots[0].requireData;
                final postData = snapshots[1].requireData;
                final commentData = snapshots[2].requireData;
                return ListView.builder(
                          itemCount: postData.size,
                          itemBuilder: (context, index) {
                            return PostCardTemplate(user: userData.data, post: postData.data, comment: commentData.data);
                          }
                        );
            }
            )
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPost()));
              // go to add_post
            },
            backgroundColor: secondaryPink800,
            child: Icon(Icons.add)));
  }
}

/*

   StreamBuilder<QuerySnapshot>( 
            stream:users,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
              return StreamBuilder<QuerySnapshot> (
                stream: posts,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                  return StreamBuilder<QuerySnapshot> ( 
                      stream: comments,
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot3) {
                        final userData = snapshot1.requireData;
                        final postData = snapshot2.requireData;
                        final commentData = snapshot3.requireData;

                        return ListView.builder(
                          itemCount: postData.size,
                          itemBuilder: (context, index) {
                            return userData.docs[index]['name'];

                          }
                        );
                      }
                  );

                }
              );
            },


          )
*/