
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post1.dart';

Future createPost({required String userID, required String postID, required DateTime date, required int comments, String postImage = "", String postText="", required int likes}) async {
  final docPost = FirebaseFirestore.instance.collection('posts').doc();
  
  final post = Post(
    userID: "1",
    postID: docPost.id,
    date: DateTime(2021,10,10),
    comments: 3,
    postImage: "",
    postText: "",
    likes: 4,
  );

  final json = post.toJson();
  await docPost.set(json);


  Map<String, dynamic> toJson() => {
    'userID': userID,
    'postID': postID,
    'date': date,
    'comments': comments,
    'postImage': "",
    'postText': "",
    'likes': 4,
  };
}