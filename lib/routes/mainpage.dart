import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/routes/show_profiles.dart';
import 'package:path/path.dart';
import 'package:flutterui/routes/search.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/ui/mainpage_postcard.dart';
import 'package:flutterui/ui/post_card_template.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/routes/profile.dart';
import 'package:flutterui/routes/messages.dart';
import 'package:flutterui/routes/addpost.dart';
import 'package:flutterui/services/analytics.dart';
import 'package:flutterui/models/user1.dart';
import 'package:flutterui/models/post1.dart';
import 'package:flutterui/main.dart';
import 'package:flutterui/models/comment1.dart';
import 'package:flutterui/models/follower1.dart';
import 'package:multi_stream_builder/multi_stream_builder.dart';

import 'notificationPage.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/mainpage';

  MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Follower> follower = [
    Follower(followerID: "",followed: "", user: "", isEnabled: false),
  ];
  List<User1> user = [
    User1(
      userID: "",
      name: "",
      surname: "",
      username: "",
      email: "",
      profileImage: "",
      MBTI: "",
      bio: "",
      following: 0,
      followers: 0,
      isPrivate: false,
    )
  ];
  List<Post> post = [
    Post(
      userID: "",
      postID: "",
      date: DateTime(0, 0, 0),
      comments: [],
      postImage: "",
      postText: "",
      likes: 0,
    )
  ];
  List<Comment> comment = [
    Comment(
      userID: "",
      postID: "",
      commentID: "",
      commentText: "",
    )
  ];
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();
  final Stream<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection('posts').snapshots();
  final Stream<QuerySnapshot> comments =
      FirebaseFirestore.instance.collection('comments').snapshots();
  final Stream<QuerySnapshot> followers =
      FirebaseFirestore.instance.collection('followers').snapshots();

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
                        builder: (context) => NotificationPage())); //
              }
            },
            items: const [
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
                        child: FutureBuilder<User1?>(
                            future: readUser(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong.');
                              }
                              if (snapshot.hasData && snapshot.data == null) {
                                return Text("Document does not exist");
                              } else {
                                return CircleAvatar(
                                  radius: 30,
                                  backgroundColor: textOnSecondaryWhite,
                                  backgroundImage: NetworkImage(snapshot
                                          .data?.profileImage ??
                                      'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png'),
                                );
                              }
                            }),
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
                  ],
                )),
                decoration: const BoxDecoration(
                  color: textOnSecondaryWhite,
                ))),
        body: SizedBox(
          child: StreamBuilder<QuerySnapshot>(
            stream: users,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
              if (snapshot1.hasError) {
                return const Text('error');
              }
              if (!snapshot1.hasData) {
                return const Text('User data error');
              }
              final FirebaseAuth auth = FirebaseAuth.instance;
              var uid = auth.currentUser!.uid;

              final userData = snapshot1.requireData;
              print("uid is ${uid}");
              print("user data length: ${userData.size}");
              return StreamBuilder<QuerySnapshot>(
                  stream: posts,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot2) {
                    if (snapshot2.hasError) {
                      return const Text('Post error');
                    }
                    if (!snapshot2.hasData) {
                      return const Text('Post data error');
                    }
                    final postData = snapshot2.requireData;

                    return StreamBuilder<QuerySnapshot>(
                        stream: followers,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot3) {
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          var uid = auth.currentUser!.uid;
                          if (snapshot3.hasError) {
                            return const Text('Follower error');
                          }
                          if (!snapshot3.hasData) {
                            return const Text("Don't have any follower");
                          }

                          final followerData = snapshot3.requireData;
                          print(
                              "size of follower data is ${followerData.size}");
                          List<MainPostCardTemplate> postCards =
                              <MainPostCardTemplate>[];
                          for (int p = 0; p < postData.size; p++) {
                            print(
                                "processing post: ${postData.docs[p]['postText']}, with poster: ${postData.docs[p]['userID']}, this is: ${uid}, am I the poster? ${uid == postData.docs[p]['userID']}");

                            if (postData.docs[p]['userID'] == uid) {
                              print(
                                  "processing post 2: ${postData.docs[p]['postText']}, with poster: ${postData.docs[p]['userID']}, this is: ${uid}");

                              for (int u = 0; u < userData.size; u++) {
                                print(" user data is ${u}");

                                if (postData.docs[p]['userID'] ==
                                    userData.docs[u]["userID"]) {
                                  User1 myUser = User1(
                                      profileImage: userData.docs[u]
                                          ['profileImage'],
                                      userID:
                                          userData.docs[u]['userID'].toString(),
                                      name: userData.docs[u]['name'].toString(),
                                      surname: userData.docs[u]['surname']
                                          .toString(),
                                      username: userData.docs[u]['username']
                                          .toString(),
                                      email: "",
                                      MBTI: "",
                                      following: 0,
                                      followers: 0,
                                      isPrivate: false);
                                  Post myPost = Post(
                                      userID:
                                          postData.docs[p]['userID'].toString(),
                                      postID:
                                          postData.docs[p]['postID'].toString(),
                                      date: postData.docs[p]['date'].toDate(),
                                      comments: [],
                                      likes: postData.docs[p]['likes'],
                                      postText: postData.docs[p]['postText']
                                          .toString(),
                                      postImage: postData.docs[p]['postImage']
                                          .toString());

                                  print("create post card");
                                  postCards.add(MainPostCardTemplate(
                                      uid: uid,
                                      user: myUser,
                                      post: myPost,
                                      comment: comment[0]));
                                  break;
                                }
                              }
                              continue;
                            }

                            for (var f = 0; f < followerData.size; f++) {
                              print("size of post data is ${postData.size}");

                              if (postData.docs[p]['userID'] ==
                                      followerData.docs[f]['followed'] &&
                                  followerData.docs[f]['user'] == uid) {
                                for (int u = 0; u < userData.size; u++) {
                                  print(" user data is ${u}");
                                  if (postData.docs[p]['userID'] ==
                                      userData.docs[u]["userID"]) {
                                    User1 myUser = User1(
                                        profileImage: userData.docs[u]
                                            ['profileImage'],
                                        userID: userData.docs[u]['userID']
                                            .toString(),
                                        name:
                                            userData.docs[u]['name'].toString(),
                                        surname: userData.docs[u]['surname']
                                            .toString(),
                                        username: userData.docs[u]['username']
                                            .toString(),
                                        email: "",
                                        MBTI: "",
                                        following: 0,
                                        followers: 0,
                                        isPrivate: false);
                                    Post myPost = Post(
                                        userID: postData.docs[p]['userID']
                                            .toString(),
                                        postID: postData.docs[p]['postID']
                                            .toString(),
                                        date: postData.docs[p]['date'].toDate(),
                                        comments: [],
                                        likes: postData.docs[p]['likes'],
                                        postText: postData.docs[p]['postText']
                                            .toString(),
                                        postImage: postData.docs[p]['postImage']
                                            .toString());

                                    print("create post card");

                                    postCards.add(MainPostCardTemplate(
                                        uid: uid,
                                        user: myUser,
                                        post: myPost,
                                        comment: comment[0]));
                                    break;
                                  }
                                }
                                break;
                              }
                            }
                          }

                          return ListView.builder(
                              itemCount: postCards.length,
                              itemBuilder: (context, int index) {
                                print(
                                    "post: ${postCards[index].post.postText}");
                                return postCards[index];
                              });

             
                        });
                  
                  });

            },
          ), //user
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