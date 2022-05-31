//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';
import 'package:flutterui/models/Message.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/services/analytics.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<UserModel> Users = [
    UserModel(
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
    UserModel(
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
    UserModel(
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
    UserModel(
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
    UserModel(
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
    UserModel(
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

  List<Message> messages = [
    Message(
        sender: "Melisa",
        time: "12.03.2022",
        message: "Hello, how are u?",
        isLiked: false,
        unread: true),
    Message(
        sender: "Jack",
        time: "15.05.2022",
        message: "Hi!",
        isLiked: false,
        unread: true),
    Message(
        sender: "Anna",
        time: "23.09.2022",
        message: "Hello, how are u?",
        isLiked: false,
        unread: true),
  ];

  int selectedIndex = 0;
  final List<String> categories = ['Messages', 'Online', 'Groups', 'Requests'];
  @override
  Widget build(BuildContext context) {
    AppAnalytics.logCustomEvent("Messages_Page", <String, dynamic>{});
    return Scaffold(
      backgroundColor: secondaryPink800,
      appBar: AppBar(
        backgroundColor: secondaryPink800,
        toolbarHeight: 100.0,
        title: Text('Chat',
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            )),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Container(
              height: 90.0,
              color: secondaryPink800,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 30.0),
                      child: Text(categories[index],
                          style: TextStyle(
                            color: index == selectedIndex
                                ? Colors.white
                                : Colors.white60,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          )),
                    ),
                  );
                },
              )),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: textOnSecondaryWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Favorite Contacts',
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: Icon(
                                  Icons.more_horiz,
                                ),
                                iconSize: 30.0,
                                color: Colors.blueGrey,
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                        Container(
                            height: 120.0,
                            color: textOnSecondaryWhite,
                            child: ListView.builder(
                                padding: EdgeInsets.only(left: 10.0),
                                scrollDirection: Axis.horizontal,
                                itemCount: Users.length,
                                itemBuilder:
                                    (BuildContext favContext, int favIndex) {
                                  return Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 35.0,
                                          backgroundImage: NetworkImage(
                                              'https://picsum.photos/200/300'),
                                        ),
                                        SizedBox(height: 6.0),
                                        Text(Users[favIndex].name),
                                      ],
                                    ),
                                  );
                                }))
                      ],
                    ),
                    Expanded(
                      child: Container(
                          height: 300.0,
                          decoration: BoxDecoration(
                            color: textOnSecondaryWhite,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            child: ListView.builder(
                                itemCount: messages.length,
                                itemBuilder:
                                    (BuildContext chatContext, int chatIndex) {
                                  final Message chat = messages[chatIndex];
                                  return Container(
                                    margin: EdgeInsets.only(
                                        top: 5.0,
                                        bottom: 5.0,
                                        right: 20.0,
                                        left: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 35.0,
                                              backgroundImage: NetworkImage(
                                                  'https://picsum.photos/200/300'),
                                            ),
                                            SizedBox(width: 10.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(chat.sender,
                                                    style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(height: 7.0),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  child: Text(
                                                    chat.message,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(children: <Widget>[
                                          Text(chat.time),
                                          Text("NEW"),
                                        ])
                                      ],
                                    ),
                                  );
                                }),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
