import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/models/User.dart';
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
      Follower(
        followed: "", 
        user: "", 
        isEnabled: false),
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
                        child: const CircleAvatar(
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
                  ],
                )),
                decoration: const BoxDecoration(
                  color: textOnSecondaryWhite,
                ))),
        body: SizedBox(
            
           child: StreamBuilder<QuerySnapshot>(
             stream: users,
             builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) 
              {    if(snapshot1.hasError) {
                            return const Text('error');
                    }
                  if(!snapshot1.hasData) 
                  {
                    return const Text('User data error');
                  }
                   final FirebaseAuth auth = FirebaseAuth.instance;
                   var uid = auth.currentUser!.uid;

                   final userData = snapshot1.requireData;
                   print("uid is ${uid}");
                   print("user data length: ${userData.size}" );
                  return StreamBuilder<QuerySnapshot>(
                    stream: posts,
                    builder:
                   (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                        if(snapshot2.hasError) {
                            return const Text('Post error');
                        }
                         if(!snapshot2.hasData) 
                        {
                         return const Text('Post data error');
                        }
                        final postData = snapshot2.requireData;
                        
                        return  StreamBuilder<QuerySnapshot>(
                          stream: followers,
                           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot3) {
                            
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            var uid = auth.currentUser!.uid;
                             if(snapshot3.hasError) {
                               return const Text('Follower error');
                           }
                             if(!snapshot3.hasData) 
                           {
                               return const Text("Don't have any follower");
                           }

                           final followerData = snapshot3.requireData;
                            print("size of follower data is ${followerData.size}" );
                            List<MainPostCardTemplate> postCards = <MainPostCardTemplate>[];
                            for(int p = 0; p < postData.size ; p++) {

                                print("processing post: ${postData.docs[p]['postText']}, with poster: ${postData.docs[p]['userID']}, this is: ${uid}, am I the poster? ${uid == postData.docs[p]['userID']}" );

                                if (postData.docs[p]['userID'] == uid) 
                                {
                                  print("processing post 2: ${postData.docs[p]['postText']}, with poster: ${postData.docs[p]['userID']}, this is: ${uid}" );

                                  for(int u = 0; u < userData.size; u++) 
                                  {
                                    print(" user data is ${u}" );

                                    if(postData.docs[p]['userID'] == userData.docs[u]["userID"]) 
                                    {
                                      User1 myUser = User1(profileImage: "", userID: userData.docs[u]['userID'].toString(), name: userData.docs[u]['name'].toString(), surname: userData.docs[u]['surname'].toString(), username: "", email: "", MBTI: "", following: 0, followers: 0, isPrivate: false);
                                      Post myPost = Post(userID: postData.docs[p]['userID'].toString(), postID: postData.docs[p]['postID'].toString(), date: postData.docs[p]['date'].toDate(), comments: [], likes: postData.docs[p]['likes'], postText: postData.docs[p]['postText'].toString(), postImage:"" /*postData.docs[p]['postImage'].toString()*/);
                                      
                                      print("create post card");
                                      postCards.add(MainPostCardTemplate(uid: uid, user: myUser, post: myPost, comment: comment[0]));
                                      break;
                                    }
                                  }
                                  continue;
                                }

                                for (var f = 0; f < followerData.size ; f++) {
                                  print("size of post data is ${postData.size}" );

                                  if(postData.docs[p]['userID'] == followerData.docs[f]['followed'] &&  followerData.docs[f]['user'] == uid) {                                       
                                      
                                      for(int u = 0; u < userData.size; u++) 
                                      {
                                        print(" user data is ${u}" );
                                        if(postData.docs[p]['userID'] == userData.docs[u]["userID"]) {

                                          User1 myUser = User1(profileImage: "", userID: userData.docs[u]['userID'].toString(), name: userData.docs[u]['name'].toString(), surname: userData.docs[u]['surname'].toString(), username: "", email: "", MBTI: "", following: 0, followers: 0, isPrivate: false);
                                          Post myPost = Post(userID: postData.docs[p]['userID'].toString(), postID: postData.docs[p]['postID'].toString(), date: postData.docs[p]['date'].toDate(), comments: [], likes: postData.docs[p]['likes'], postText: postData.docs[p]['postText'].toString(), postImage: ""/*postData.docs[p]['postImage'].toString()*/);

                                          print("create post card");

                                          postCards.add(MainPostCardTemplate(uid: uid, user: myUser, post: myPost, comment: comment[0]));
                                          break;
                                        }
                                      }

                                      break;
                                    }
                                }
                           
              
                           }

                            return ListView.builder(
                              itemCount: postCards.length,
                              itemBuilder: (context, int index) 
                              {
                                print("post: ${postCards[index].post.postText}");
                                return postCards[index];
                              }
                            );
           
                           
return const Center(child: CircularProgressIndicator());

                          }
                        );
                        /*  
                  return ListView.builder(
                     itemCount: userData.size,
                     itemBuilder: (context, index) {
                       
                              user[0].userID = userData.docs[index]['userID'].toString();
                              user[0].name = userData.docs[index]['name'].toString();
                              user[0].surname = userData.docs[index]['surname'].toString();
                              user[0].email = userData.docs[index]['email'].toString();
                              user[0].profileImage = userData.docs[index]['profileImage'].toString();
                              user[0].MBTI = userData.docs[index]['MBTI'].toString();
                              user[0].bio = userData.docs[index]['bio'];
                              //user[0].following =userData.docs[index]['following'];
                             // user[0].followers = userData.docs[index]['followers'];
                              post[0].userID =
                                     postData.docs[index]['userID'].toString();
                                 post[0].postID =
                                     postData.docs[index]['postID'].toString();
                                 post[0].date =
                                     postData.docs[index]['date'].toDate();
                                // post[0].comments =
                                  //   postData.docs[index]['comments'];
                                 post[0].postImage = postData.docs[index]
                                         ['postImage']
                                     .toString();
                                 post[0].postText =
                                     postData.docs[index]['postText'].toString();
                                 post[0].likes = postData.docs[index]['likes'];

                             
                                return MainPostCardTemplate(
                                     uid: uid,
                                     user: user[0],
                                     post: post[0],
                                     comment: comment[0]);
                     }
                  );*/
                   });

                  /*
                  final userData = snapshot1.requireData;
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  var uid = auth.currentUser!.uid;
                  return ListView.builder(
                     itemCount: userData.size,
                     itemBuilder: (context, index) {
                              user[0].userID = userData.docs[index]['userID'].toString();
                              user[0].name = userData.docs[index]['name'].toString();
                              user[0].surname = userData.docs[index]['surname'].toString();
                              user[0].email = userData.docs[index]['email'].toString();
                              user[0].profileImage = userData.docs[index]['profileImage'].toString();
                              user[0].MBTI = userData.docs[index]['MBTI'].toString();
                              user[0].bio = userData.docs[index]['bio'];
                              //user[0].following =userData.docs[index]['following'];
                             // user[0].followers = userData.docs[index]['followers'];

                             
                                return PostCardTemplate(
                                     uid: uid,
                                     user: user[0],
                                     post: post[0],
                                     comment: comment[0]);
                     }
                  ); */
                  /*
                  return StreamBuilder<QuerySnapshot>(
                   stream: posts,
                   builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot2) 
                        {
                          if(snapshot2.hasError) {
                            return MaterialApp(title: ' Post error');
                          }
                          if(!snapshot2.hasData) 
                          {
                            return MaterialApp(title: ' Post Data error');
                          }
                          return StreamBuilder<QuerySnapshot>(
                           stream: comments,
                           builder: (BuildContext context,
                               AsyncSnapshot<QuerySnapshot> snapshot3) {

                                if(snapshot3.hasError) {
                                    return MaterialApp(title: ' Comment error');
                        
                                }
                              final userData = snapshot1.requireData;
                              final postData = snapshot2.requireData;
                              final commentData = snapshot3.requireData;
                            
                              return ListView.builder(
                                 itemCount: postData.size,
                                 itemBuilder: (context, index) {
                                 user[0].userID =
                                     userData.docs[index]['userID'].toString();
                                   user[0].name =
                                     userData.docs[index]['name'].toString();
                                user[0].surname =
                                    userData.docs[index]['surname'].toString();
                                 user[0].email =
                                     userData.docs[index]['email'].toString();
                                 user[0].profileImage = userData.docs[index]
                                       ['profileImage']
                                     .toString();
                                 user[0].MBTI =
                                    userData.docs[index]['MBTI'].toString();
                         user[0].bio = userData.docs[index]['bio'];
                                 user[0].following =
                                     userData.docs[index]['following'];
                                 user[0].followers =
                                     userData.docs[index]['followers'];

                                 post[0].userID =
                                     postData.docs[index]['userID'].toString();
                                 post[0].postID =
                                     postData.docs[index]['postID'].toString();
                                 post[0].date =
                                     postData.docs[index]['date'].toDate();
                                 post[0].comments =
                                     postData.docs[index]['comments'];
                                 post[0].postImage = postData.docs[index]
                                         ['postImage']
                                     .toString();
                                 post[0].postText =
                                     postData.docs[index]['postText'].toString();
                                 post[0].likes = postData.docs[index]['likes'];

                                if(snapshot3.hasData) {
                                        comment[0].userID = commentData.docs[index]
                                         ['userID']
                                     .toString();
                                 comment[0].postID = commentData.docs[index]
                                          ['postID']
                                     .toString();
                                 comment[0].commentID = commentData.docs[index]
                                         ['commentID']
                                     .toString();
                                 comment[0].commentText = commentData.docs[index]
                                         ['commentText']
                                     .toString();

                                }
                                

                                 return PostCardTemplate(
                                     uid: post[0].userID,
                                     user: user[0],
                                     post: post[0],
                                     comment: comment[0]);
                               });
                             
                         
                         }
                        
                         );//comment

                      
                    
                          
                           
                   }
               
                   );*/
                },

          
          ),//user
          
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