import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/main.dart';
import 'package:flutterui/services/databaseRead.dart';
import 'package:like_button/like_button.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/models/user1.dart';
import 'package:flutterui/models/post1.dart';
import 'package:flutterui/routes/comment.dart';
import 'package:flutterui/routes/profile.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:like_button/like_button.dart';
import '../models/comment1.dart';
import '../routes/updatepost.dart';

class FirebaseStoreDataBase {
  String? downloadUrl;

  Future getData(String? postImage) async {
    try {
      downloadUrl = await FirebaseStorage.instance
          .ref()
          .child('uploads/$postImage')
          .getDownloadURL();
      print("Download url is ${downloadUrl}");
      return downloadUrl;
    } catch (e) {
      print("Error is in image $e");
    }
  }
}

class PostCardTemplate extends StatelessWidget {
  final String uid;
  final Post post;
  PostCardTemplate({
    Key? key,
    required this.uid,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
      child: Card(
        color: textOnSecondaryWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          children: [
            FutureBuilder<User1?>(
              future: readUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong.');
                }
                if (snapshot.hasData && snapshot.data == null) {
                  return Text("Document does not exist");
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ListTile(
                      leading: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: secondaryBackgroundWhite,
                          shape: const CircleBorder(),
                        ),
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: primaryPinkLight,
                            backgroundImage:
                                NetworkImage("${snapshot.data?.profileImage}")),
                      ),
                      title: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  "${snapshot.data?.name} ${snapshot.data?.surname}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: " @${snapshot.data?.username}",
                            )
                          ],
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              deletePost(context: context, id: post.postID);
                            },
                            splashRadius: 20,
                            icon: Icon(Icons.delete,
                                size: 20, color: Colors.grey),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdatePost(
                                          postID: post.postID,
                                          postText: post.postText)));
                            },
                            splashRadius: 20,
                            icon:
                                Icon(Icons.edit, size: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                      subtitle: post.postText != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(post.postText!),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            )
                          : null,
                    ),
                  );
                }
              },
            ),
            if (post.postImage != null && post.postImage != "") ...[
              FutureBuilder(
                future: FirebaseStoreDataBase().getData(post.postImage),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("image error");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    print(snapshot.data.toString());
                    print("snapshot connected for postImage");

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(snapshot.data.toString()),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ], /*
            Container(
              color: textOnSecondaryWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  FutureBuilder<Comment?>(
                      future: getCommentWithId(post.comments[0]),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return Text('Something went wrong.');
                        }
                        if (snapshot.hasData && snapshot.data == null) {
                          return Text("Document does not exist");
                        } else {
                          return TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommentPage()));
                            },
                            icon: const Icon(Icons.comment,
                                size: 15, color: Colors.grey),
                            label: Text(
                              "${snapshot.data?.commentText}",
                              style: const TextStyle(
                                color: textOnPrimaryBlack,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const LikeButton(
                        size: 15,
                      ),
                      Text("${post.likes}",
                          style: const TextStyle(
                            color: textOnPrimaryBlack,
                            fontSize: 10,
                          )),
                    ],
                  ),
                  
                  SizedBox(
                    width: 175,
                  ),
                  IconButton(
                    onPressed: () {},
                    splashRadius: 20,
                    icon: Icon(Icons.delete, size: 20, color: Colors.grey),
                  ),
                ],
              ),
            )*/
          ],
        ),
      ),
    );
  }

  static Future<void> deletePost({context, required String id}) async {
    DocumentReference document =
        FirebaseFirestore.instance.collection('posts').doc(id);
    await document.delete().whenComplete(() => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile()))
        });
  }
}
