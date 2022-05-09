import 'package:flutter/material.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/ui/post_card.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/mainpage';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

    List<User> Users = [
    User(
        profile_image: 'https://w7.pngwing.com/pngs/193/660/png-transparent-computer-icons-woman-avatar-avatar-girl-thumbnail.png',
        id: 10000,
        name: 'Jane',
        surname: 'Doe',
        username: 'JaneDoe',
        email: 'JaneDoe@example.com',
        MBTI_type: 'ISTJ'),
    User(
        profile_image: 'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
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
          selectedItemColor: textOnPrimaryBlack,
          unselectedItemColor: secondaryPink800,
          selectedFontSize: 18.0,
          unselectedFontSize: 18.0,
          onTap: (value) {
            // add what you want to do after tapped
            setState(() => _currentindex = value);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shuffle), label: 'Shuffle'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add')
          ]),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: Container(
              height: 200,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                        onPressed: () {},
                        child: CircleAvatar(radius: 40, backgroundColor: secondaryPinkLight, backgroundImage: NetworkImage('https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png')),
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
            body: Column(
              children: Users.map((user){
                return PostCard(
                  user: user
                );
              }).toList(),
            )
    );
  }
}
