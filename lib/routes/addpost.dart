import 'package:flutter/material.dart';
import 'package:flutterui/main.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';
import 'package:flutterui/services/analytics.dart';

import '../services/databaseWrite.dart';

class AddPost extends StatefulWidget {
  static const String routeName = '/addPost';
  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String postText = "";

  @override
  Widget build(BuildContext context) {
    AppAnalytics.logCustomEvent("Add_Post_Page", <String, dynamic>{});
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink[100],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gif_box),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        leading: GestureDetector(
          onTap: () {},
          child: IconButton(
            icon: Icon(Icons.cancel_sharp),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text("New Post"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {},
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  Navigator.pop(context);
                  createPost(userID: "", postID: "", date: DateTime.now(), comments: 2, likes: 2, postText: postText);
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: secondaryPinkLight,
                      backgroundImage: NetworkImage(
                          'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png'),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      maxLength: 150,
                      maxLines: 8, //or null
                      decoration: InputDecoration.collapsed(
                          hintText: "Enter your text here"),
                      onChanged: (text) {
                        postText = text;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
