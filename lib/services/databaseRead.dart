import 'package:flutter/material.dart';
import 'package:flutterui/models/Follower.dart';
import 'package:flutterui/models/post1.dart';
import 'package:flutterui/models/post1.dart';
import 'package:flutterui/models/user1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<Post?>> readPostOfUser() async {
  final FirebaseAuth auth = await FirebaseAuth.instance;
  var uid = await auth.currentUser!.uid;
  List<Post> posts = [];
  Post post = Post(
    userID: "",
    postID: "",
    date: DateTime.utc(0),
    comments: 0,
    postImage: "",
    postText: "",
    likes: 0,
  );
  await FirebaseFirestore.instance
      .collection('posts')
      .where("userID", isEqualTo: uid)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      post.userID = doc["userID"];
      post.postID = doc["postID"];
      post.date = doc["date"].toDate();
      post.comments = doc["comments"];
      post.postImage = doc["postImage"];
      post.postText = doc["postText"];
      post.likes = doc["likes"];
      posts.add(post);
    });
  });
  return posts;
}

Future<List<Follower?>> readFollowersOfUser() async {
  final FirebaseAuth auth = await FirebaseAuth.instance;
  var uid = await auth.currentUser!.uid;
  List<Follower> followers = [];
  Follower follower = Follower(
    user: "",
    followed: "",
    isEnabled: false,
  );
  await FirebaseFirestore.instance
      .collection('followers')
      .where("followed", isEqualTo: uid)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      follower.followed = doc["followed"];
      follower.user = doc["user"];
      follower.isEnabled = doc["isEnabled"];
      followers.add(follower);
    });
  });
  return followers;
}

Future<List<Follower?>> readFollowingsOfUser() async {
  final FirebaseAuth auth = await FirebaseAuth.instance;
  var uid = await auth.currentUser!.uid;
  List<Follower> followers = [];
  Follower follower = Follower(
    user: "",
    followed: "",
    isEnabled: false,
  );
  await FirebaseFirestore.instance
      .collection('followers')
      .where("user", isEqualTo: uid)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      follower.followed = doc["followed"];
      follower.user = doc["user"];
      follower.isEnabled = doc["isEnabled"];
      followers.add(follower);
    });
  });
  return followers;
}
