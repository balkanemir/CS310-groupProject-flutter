import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/models/user1.dart';
import 'package:flutterui/routes/login.dart';
import 'package:flutterui/routes/mainpage.dart';
import 'package:flutterui/routes/search.dart';
import 'package:flutterui/ui/shuffle_card.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';
import 'package:flutterui/services/analytics.dart';

import 'notificationPage.dart';

class Shuffle extends StatefulWidget {
  static const String routeName = '/shuffle';

  const Shuffle({Key? key}) : super(key: key);
  @override
  _ShuffleState createState() => _ShuffleState();
}

class _ShuffleState extends State<Shuffle> {
    final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection('users').snapshots();
  List<User1>  Users = [];
  /*
  List<User1> Users = [
    User1(
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
    User1(
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
    User1(
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
    User1(
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
    User1(
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
    User1(
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
*/
  int _currentindex = 2;


  @override
  Widget build(BuildContext context) {
    AppAnalytics.logCustomEvent("Shuffle_Page", <String, dynamic>{});
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
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shuffle), label: 'Shuffle'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notifications')
          ]),
      body: SizedBox(
            
           child: StreamBuilder<QuerySnapshot>(
             stream: users,
             builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> userSnapshot) 
              {    
                if(userSnapshot.hasError) {
                            return const Text('error');
                    }
                  if(!userSnapshot.hasData) 
                  {
                    return const Text('User data error');
                  }
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  var uid = auth.currentUser!.uid;

                   final userData = userSnapshot.requireData;
                   List<User1> addUsers = <User1>[];
                   for(int i = 0; i < userData.size; i++) 
                   {
                    if(userData.docs[i]['userID'] != uid) {
                      addUsers.add(User1( 
                        userID: userData.docs[i]['userID'],
                        surname: userData.docs[i]['surname'],
                        name: userData.docs[i]['name'],
                        username: userData.docs[i]['surname'],
                        email: userData.docs[i]['email'],
                        isPrivate: userData.docs[i]['isPrivate'],
                        followers: userData.docs[i]['followers'],
                        following: userData.docs[i]['following'],
                        MBTI: userData.docs[i]['MBTI'],
                        profileImage: userData.docs[i]['profileImage'],


                      ));
                      
                     
                    }
                 
                   }
                      return ShuffleCard(Users: addUsers);


              }
       )
     )
    );
  }
}
