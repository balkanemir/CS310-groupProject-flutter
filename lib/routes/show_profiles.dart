import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterui/services/databaseWrite.dart';
import 'package:flutterui/ui/mainpage_postcard.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/main.dart';
import 'package:flutterui/models/follower1.dart';
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

class ShowProfile extends StatefulWidget {
  final User1? user;
 
  const ShowProfile({ Key? key, required this.user}) : super(key: key);
  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
   final Stream<QuerySnapshot> posts = FirebaseFirestore.instance.collection('posts').snapshots();
   final Stream<QuerySnapshot> databaseFollower = FirebaseFirestore.instance.collection('followers').snapshots();
  
  //final String uid;
  User1? users;
  Post? post;
  Follower? follower;
  List<Comment> comment = [
    Comment(
      userID: "",
      postID: "",
      commentID: "",
      commentText: "",
    )
  ];
  int _currentindex = -1;

  _ShowProfileState();
 


  void _updateImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'profileImage': image!.path});
  }

  @override
  Widget build(BuildContext context) {
  
    User1 myUser = widget.user!;
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
          items: const  [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shuffle), label: 'Shuffle'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notifications')
          ]),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(230.0),
        child: Container(
          height: 230,
          child: Center(
            child: Padding(
            padding: const EdgeInsets.only(top: 19.0, right: 8.0, left: 8.0),
            child: Column(
              children: [
                   Row (
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
                                                  "${myUser.profileImage}"),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: primaryPinkLight,
                                      backgroundImage: FileImage(
                                        File(myUser.profileImage),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "${myUser.name} ${myUser.surname} (${myUser.username})",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                           ),
                           FutureBuilder<List<Post?>>(
                                future: readPostOfUserProfile(myUser.userID),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
            
                                    return const Text('Something went wrong.');
                                  }
                                  if (snapshot.hasData &&
                                      snapshot.data == null) {
                                    return const Text("Document does not exist");
                                  } else {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${snapshot.data?.length}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text("Posts"),
                                      ],
                                    );
                                  }
                                }),
                            FutureBuilder<List<Follower?>>(
                                future: readFollowingsOfUser(myUser.userID),
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
                                future: readFollowersOfUser(myUser.userID),
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
              ],),
                Padding(
                  padding: EdgeInsets.only(top: 10) ,
                  child: Column(
                  children: [
                      myUser.bio != null ? RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "${myUser.bio}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ) 
                            
                            ],
                                ),) : RichText(text: TextSpan(text: "")) ],
                )),
                
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                          child: ElevatedButton(
                             onPressed: () {
                             Navigator.pop(context);
                             final FirebaseAuth auth = FirebaseAuth.instance;
                             var currentUserId = auth.currentUser!.uid;
                             createFollower(
                                followed: currentUserId,
                                followerID: "",
                                isEnabled: false,
                                user: myUser.userID,
                           );
                               },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                primary: secondaryPink800,
                                elevation: 5,
                              ),
                              child: const Text(
                                "Follow",
                              ),
                            )
                        )),
                       
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                          child: ElevatedButton(
                             onPressed: () {
                             Navigator.pop(context);
                                StreamBuilder<QuerySnapshot>(
                                  stream: databaseFollower,
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> followerSnapshot) {
                                    final FirebaseAuth auth = FirebaseAuth.instance;
                                    var currentUserId = auth.currentUser!.uid; 
                                    final followerData = followerSnapshot.data;
                                    for(int i = 0; i < followerData!.size; i++) 
                                    {
                                      if(followerData.docs[i]['followed'] == currentUserId && followerData.docs[i]['user'] == myUser.userID) {
                                        deleteFollower(context: context,myUser: myUser, followerID:  followerData.docs[i]['followed'].toString());
                                      }
                                    }
                                    return const  Text("");

                                   });
                               },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                primary: secondaryPink800,
                                elevation: 5,
                              ),
                              child: const Text(
                                "Unfollow",
                              ),
                            )
                        )),
              ],
            ),
          )),
          
         
        ),
      ),
    
      body:          
     FutureBuilder<List<Post?>>(
          future: readPostOfUserProfile(myUser.userID),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
  
              return const Text('Something went wrong.');
            }
            if (snapshot.hasData && snapshot.data == null) {
              return const Text("Document does not exist");
            } 
            else {
              return SizedBox(
                height: screenSize(context).height,
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
          
 
        
                    Post? post = snapshot.data?[index];
                    String? uid = myUser.userID;
                    if (post != null && uid != null) {
                      return MainPostCardTemplate(
                        user: myUser,
                        uid: myUser.userID,
                        post: post,
                        comment: comment[0],
                      );
                    } else {
                      return Text("");
                    }
                  },
           
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
  
 
  static Future<void> deleteFollower({context,required  User1 myUser, required String followerID}) async {
    DocumentReference document =
        FirebaseFirestore.instance.collection('followers').doc(followerID);
    await document.delete().whenComplete(() => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ShowProfile(user: myUser)))
        });
  }
}

