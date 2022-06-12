import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/main.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';
import 'package:flutterui/services/analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutterui/services/databaseRead.dart';
import 'package:flutterui/services/databaseWrite.dart';
import 'package:path/path.dart';

class AddPost extends StatefulWidget {
  static const String routeName = '/addPost';
  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  int _selectedIndex = 0;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  XFile? _video;
String? fileName;
String? videoFile;

  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    try {
      await firebaseStorageRef.putFile(File(_image!.path));
      print('Upload completed image');
      setState(() {
        _image = null;
      });
    } on FirebaseException catch (e) {
      print('ERROR: ${e.code} - ${e.message}');
    } catch (e) {
      print(e.toString());
    }
  }

   Future pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

    Future uploadVideoToFirebase(BuildContext context) async {
    String fileName = basename(_video!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    try {
      await firebaseStorageRef.putFile(File(_video!.path));
      print('Upload completed video');
      setState(() {
        _video = null;
      });
    } on FirebaseException catch (e) {
      print('ERROR: ${e.code} - ${e.message}');
    } catch (e) {
      print(e.toString());
    }
  }

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
      resizeToAvoidBottomInset: false,
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
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  var uid = auth.currentUser!.uid;
                  if (_image != null) {
                      uploadImageToFirebase(context);
                        fileName = basename(_image!.path);
                  }
    
                  if(_video != null) {
                    uploadVideoToFirebase(context);
                     videoFile = basename(_video!.path);
                  }
                  
                
                 
                  createPost(
                      userID: uid,
                      postID: "",
                      date: DateTime.now(),
                      comments: 0,
                      postVideo: videoFile,
                      postImage: fileName,
                      likes: 0,
                      postText: postText);
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 15, 0, 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: secondaryPinkLight,
                    backgroundImage: NetworkImage(
                        'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png'),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 280,
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
                IconButton(
                    onPressed: () {
                      pickImage();
                    },
                    icon: Icon(Icons.add_a_photo)),
                IconButton(
                    onPressed: () {
                      pickVideo();
                    },
                    icon: Icon(Icons.add_alarm_outlined)),
              ],
            ),
            Center(
              child: Container(
                  height: 500,
                  width: 300,
                  margin: EdgeInsets.only(top: 10),
                  child: Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: _image != null
                            ? Center(child: Image.file(File(_image!.path)))
                            : Center(child: Text('No photo uploaded'))),
                  )),
            ),
            if (_image != null)
              Container(
                height: 22,
                child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _image = null;
                      });
                    },
                    child: Text('Cancel', style: TextStyle(color: Colors.red))),
              ),
              if (_video != null)
              Container(
                height: 22,
                child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _video = null;
                      });
                    },
                    child: Text('Cancel', style: TextStyle(color: Colors.red))),
              ),


          ],
        ),
      ),
    );
  }
}
