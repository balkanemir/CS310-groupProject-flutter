import 'package:flutter/material.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/routes/login.dart';
import 'package:flutterui/routes/mainpage.dart';
import 'package:flutterui/ui/shuffle_card.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';


class Shuffle extends StatefulWidget {
  
  static const String routeName = '/shuffle';
  @override
  _ShuffleState createState() => _ShuffleState();
}

class _ShuffleState extends State<Shuffle> {

  
List<User> Users = [
  User(
      profile_image:
          'https://w7.pngwing.com/pngs/193/660/png-transparent-computer-icons-woman-avatar-avatar-girl-thumbnail.png',
      id: 10000,
      name: 'Jane',
      surname: 'Doe',
      username: 'JaneDoe',
      email: 'JaneDoe@example.com',
      MBTI_type: 'ISTJ'),
  User(
      profile_image:
          'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
      id: 10000,
      name: 'Jeniffer',
      surname: 'Lawrance',
      username: 'Jeniffer123',
      email: 'Jan@example.com',
      MBTI_type: 'ESFP'),
  User(
      profile_image:
          'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
      id: 10000,
      name: 'Jeniffer',
      surname: 'Lawrance',
      username: 'Jeniffer123',
      email: 'Jan@example.com',
      MBTI_type: 'ESFP'),
  User(
      profile_image:
          'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
      id: 10000,
      name: 'Jeniffer',
      surname: 'Lawrance',
      username: 'Jeniffer123',
      email: 'Jan@example.com',
      MBTI_type: 'ESFP'),
  User(
      profile_image:
          'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
      id: 10000,
      name: 'Jeniffer',
      surname: 'Lawrance',
      username: 'Jeniffer123',
      email: 'Jan@example.com',
      MBTI_type: 'ESFP'),
  User(
      profile_image:
          'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
      id: 10000,
      name: 'Jeniffer',
      surname: 'Lawrance',
      username: 'Jeniffer123',
      email: 'Jan@example.com',
      MBTI_type: 'ESFP'),
];

  
  int _currentindex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentindex,
            backgroundColor: primaryPink200,
            selectedItemColor: textOnSecondaryWhite,
            unselectedItemColor: secondaryPink800,
            selectedFontSize: 18.0,
            unselectedFontSize: 18.0,
            onTap: (value) {
              setState(() => _currentindex = value);
              if(_currentindex == 0) {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>MainPage()));
              }
              if(_currentindex == 1) {
                //Search Navigator
              }
              if(_currentindex == 2) {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>Shuffle()));
              }
              if(_currentindex == 3) {
                // Add Navigator
              }
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shuffle), label: 'Shuffle'),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add')
            ]),
            body: Stack(children: Users.map((user) {
              return ShuffleCard(user: user);
            }).toList()),
    );
  }
}