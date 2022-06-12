import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/routes/profile.dart';
import 'package:flutterui/models/follower1.dart';
import 'package:flutterui/models/user1.dart';
import 'package:flutterui/routes/search.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/routes/welcome.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';
import 'package:flutterui/services/databaseRead.dart';
import 'package:flutterui/services/analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'mainpage.dart';

class NotificationPage extends StatefulWidget {
  static const String routeName = '/notificationPage';

  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _currentindex = 3;

  @override
  Widget build(BuildContext context) {
    Future<void> _approveRequest(String id) async {
      print(id);
      await FirebaseFirestore.instance
          .collection('followers')
          .doc(id)
          .update({'isEnabled': true});
    }

    Future<void> _deleteRequest(String id) async {
      await FirebaseFirestore.instance.collection('followers').doc(id).delete();
    }

    AppAnalytics.logCustomEvent("Notification_Page", <String, dynamic>{});
    return Scaffold(
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            }
            if (_currentindex == 1) {
              //Search Navigator
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
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shuffle), label: 'Shuffle'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notifications')
          ]),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Container(
              height: 200,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Welcome()));
                      },
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: primaryPinkLight,
                          backgroundImage: NetworkImage(
                              'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png')),
                      style: ElevatedButton.styleFrom(
                        primary: secondaryPink800,
                        shape: CircleBorder(),
                      )),
                  Text("SOULMATE",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          // go to messages
                        },
                        child: Icon(Icons.message_sharp),
                        style: ElevatedButton.styleFrom(
                          primary: primaryPinkLight,
                          shape: CircleBorder(),
                        )),
                  )
                ],
              )),
              decoration: BoxDecoration(
                color: textOnSecondaryWhite,
              ))),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: FutureBuilder<List<Follower?>>(
            future: readRequests(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Something went wrong.');
              }
              if (snapshot.hasData && snapshot.data == null) {
                return Text("Document does not exist");
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (ctx, index) {
                      return FutureBuilder<User1?>(
                          future: readUserWithId(snapshot.data![index]!.user),
                          builder: (context, snapshot1) {
                            if (snapshot1.hasError) {
                              print(snapshot1.error);
                              return Text('Something went wrong.');
                            }
                            if (snapshot1.hasData && snapshot1.data == null) {
                              return Text("Document does not exist");
                            } else {
                              return Card(
                                color: Colors.pink.shade100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                snapshot1.data!.profileImage),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "@${snapshot1.data?.username} wants to follow you.",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.check),
                                            onPressed: () {
                                              _approveRequest(snapshot
                                                  .data![index]!.followerID);
                                              setState(() {});
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: () {
                                              _deleteRequest(snapshot
                                                  .data![index]!.followerID);
                                              setState(() {});
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          });
                    });
              }
              ;
            }),
      ),
    );
  }
}
