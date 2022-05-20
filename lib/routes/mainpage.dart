import 'package:flutter/material.dart';
import 'package:flutterui/models/Post.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/routes/search.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/ui/post_card_template.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/routes/profile.dart';
import 'package:flutterui/routes/messages.dart';
import 'package:flutterui/routes/addpost.dart';


import 'notificationPage.dart';

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
        MBTI_type: 'ISTJ',
        following: 12,
        followers: 78),
    User(
        profile_image:
            'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
        id: 10000,
        name: 'Jeniffer',
        surname: 'Lawrance',
        username: 'Jeniffer123',
        email: 'Jan@example.com',
        MBTI_type: 'ESFP',
        following: 34,
        followers: 126),
    User(
        profile_image:
            'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
        id: 10000,
        name: 'Jeniffer',
        surname: 'Lawrance',
        username: 'Jeniffer123',
        email: 'Jan@example.com',
        MBTI_type: 'ESFP',
        following: 182,
        followers: 58),
    User(
        profile_image:
            'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
        id: 10000,
        name: 'Jeniffer',
        surname: 'Lawrance',
        username: 'Jeniffer123',
        email: 'Jan@example.com',
        MBTI_type: 'ESFP',
        following: 12,
        followers: 78),
    User(
        profile_image:
            'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
        id: 10000,
        name: 'Jeniffer',
        surname: 'Lawrance',
        username: 'Jeniffer123',
        email: 'Jan@example.com',
        MBTI_type: 'ESFP',
        following: 12,
        followers: 78),
    User(
        profile_image:
            'https://w7.pngwing.com/pngs/129/292/png-transparent-female-avatar-girl-face-woman-user-flat-classy-users-icon.png',
        id: 10000,
        name: 'Jeniffer',
        surname: 'Lawrance',
        username: 'Jeniffer123',
        email: 'Jan@example.com',
        MBTI_type: 'ESFP',
        following: 12,
        followers: 78),
  ];

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

  int _currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentindex,
            backgroundColor: textOnSecondaryWhite,
            selectedItemColor: secondaryPink800,
            unselectedItemColor: Colors.black12,
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
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shuffle), label: 'Shuffle'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: 'Notifications')
            ]),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
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
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: primaryPinkLight ,
                            backgroundImage: NetworkImage(
                                'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png')),
                        style: ElevatedButton.styleFrom(
                          primary: secondaryPink800,
                          shape: CircleBorder(),
                        )),
                    Text("soulmate",
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => MessagePage()));
                          },
                          child: Icon(Icons.message_sharp),
                          style: ElevatedButton.styleFrom(
                            primary: primaryPinkLight ,
                            shape: CircleBorder(),
                          )),
                    )
                  ],
                )),
                decoration: BoxDecoration(
                  color: textOnSecondaryWhite,
                   ))),
        body: SizedBox(
          height: screenSize(context).height,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return PostCardTemplate(user: Users[index], post: posts[index]);
            },
            itemCount: posts.length,
          ),
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
