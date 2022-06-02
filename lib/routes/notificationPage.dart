import 'package:flutter/material.dart';
import 'package:flutterui/routes/profile.dart';
import 'package:flutterui/routes/search.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/routes/welcome.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';
import 'package:flutterui/services/analytics.dart';

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
    AppAnalytics.logCustomEvent("Notification_Page", <String, dynamic>{});
    return Scaffold(
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
                                  builder: (context) => Welcome()));
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
                          onPressed: () {
                            // go to messages
                          },
                          child: Icon(Icons.message_sharp),
                          style: ElevatedButton.styleFrom(
                            primary: secondaryPinkLight,
                            shape: CircleBorder(),
                          )),
                    )
                  ],
                )),
                decoration: BoxDecoration(
                  color: textOnSecondaryWhite,
                ))),
        body: listView());
  }

  Widget listView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return listViewItem(index);
        },
        separatorBuilder: (context, index) {
          return Divider(height: 0);
        },
        itemCount: 15);
  }

  Widget listViewItem(int index) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            prefixIcon(),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [message(index), timeAndDate(index)]),
              ),
            ),
          ],
        ));
  }

  Widget prefixIcon() {
    return Container(
        height: 50,
        width: 50,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primaryPink200,
        ),
        child: Icon(
          Icons.notifications,
          size: 25,
          color: secondaryPink800,
        ));
  }

  Widget message(int index) {
    double textSize = 14;
    return Container(
        child: RichText(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                text: 'Message',
                style: TextStyle(
                    fontSize: textSize,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: 'Notification Description',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ))
                ])));
  }

  Widget timeAndDate(int index) {
    return Container(
        margin: EdgeInsets.only(
          top: 5,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('18.05.2022', style: TextStyle(fontSize: 10)),
          Text('21:05', style: TextStyle(fontSize: 10))
        ]));
  }
}
