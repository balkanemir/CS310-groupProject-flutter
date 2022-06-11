import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post1.dart';
import '../models/follower1.dart';


Future createFollower({
  required String followed,
  required String user,
  required bool isEnabled,
}) async {
  final docFollower = FirebaseFirestore.instance.collection('followers').doc();

  final follower = Follower(
    followed: followed,
    user: user,
    isEnabled: isEnabled,
  );

  final json = follower.toJson();
  await docFollower.set(json);

  Map<String, dynamic> toJson() => {
    'followed': followed,
    'user': user,
    'isEnabled': isEnabled,
      };
}


Future createPost(
    {String userID = "",
    required String postID,
    required DateTime date,
    required int comments,
    String postImage = "",
    String postVideo = "",
    String postText = "",
    required int likes}) async {
  final docPost = FirebaseFirestore.instance.collection('posts').doc();

  final post = Post(
    userID: userID,
    postID: docPost.id,
    date: date,
    comments: [],
    postImage: postImage,
    postVideo: postVideo,
    postText: postText,
    likes: likes,
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
