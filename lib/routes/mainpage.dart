import 'package:flutter/material.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/routes/search.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/ui/post_card.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';
import 'package:flutterui/routes/profile.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/mainpage';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

  int _currentindex = 0;
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
              if (_currentindex == 0) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
              }
              if (_currentindex == 1) {
                //Search Navigator
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Search()));
              }
              if (_currentindex == 2) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Shuffle()));
              }
              if (_currentindex == 3) {
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: secondaryPinkLight,
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
                          onPressed: () {},
                          child: Icon(Icons.message_sharp),
                          style: ElevatedButton.styleFrom(
                            primary: secondaryPink800,
                            shape: CircleBorder(),
                          )),
                    )
                  ],
                )),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [primaryPink200, Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)))),
        body: SingleChildScrollView(
          child: Column(
            children: Users.map((user) {
              return PostCard(user: user);
            }).toList(),
          ),
        ));
  }
}
