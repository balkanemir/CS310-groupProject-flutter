import 'package:flutter/material.dart';
import 'package:flutterui/models/follower1.dart';
import 'package:flutterui/models/post1.dart';
import 'package:flutterui/models/comment1.dart';
import 'package:flutterui/models/user1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<Post?>> readPostOfUser() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var uid = auth.currentUser!.uid;

  List<Post> posts = [];
  Post post = Post(
    userID: "",
    postID: "",
    date: DateTime.utc(0),
    comments: [],
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
      post.comments = List<String>.from(doc["comments"]);
      post.postImage = doc["postImage"];
      post.postText = doc["postText"];
      post.likes = doc["likes"];
      posts.add(post);
    });
  });
  return posts;
}

Future<List<Post?>> readPostOfUserProfile(String myId) async {
  List<Post> posts = [];
  Post post = Post(
    userID: "",
    postID: "",
    date: DateTime.utc(0),
    comments: [],
    postImage: "",
    postText: "",
    likes: 0,
  );
  await FirebaseFirestore.instance
      .collection('posts')
      .where("userID", isEqualTo: myId)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      post.userID = doc["userID"];
      post.postID = doc["postID"];
      post.date = doc["date"].toDate();
      post.comments = List<String>.from(doc["comments"]);
      post.postImage = doc["postImage"];
      post.postText = doc["postText"];
      post.likes = doc["likes"];
      posts.add(post);
    });
  });
  return posts;
}

Future<List<Follower?>> readFollowersOfUser(String uid) async {
  List<Follower> followers = [];
  Follower follower = Follower(
    followerID: "",
    user: "",
    followed: "",
    isEnabled: false,
  );
  await FirebaseFirestore.instance
      .collection('followers')
      .where("followed", isEqualTo: uid)
      .where("isEnabled", isEqualTo: true)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      follower.followerID = doc["followerID"];
      follower.followed = doc["followed"];
      follower.user = doc["user"];
      follower.isEnabled = doc["isEnabled"];
      followers.add(follower);
    });
  });
  return followers;
}

Future<List<Follower?>> readFollowingsOfUser(String uid) async {
  List<Follower> followers = [];
  Follower follower = Follower(
    followerID: "",
    user: "",
    followed: "",
    isEnabled: false,
  );
  await FirebaseFirestore.instance
      .collection('followers')
      .where("user", isEqualTo: uid)
      .where("isEnabled", isEqualTo: true)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      follower.followerID = doc["followerID"];
      follower.followed = doc["followed"];
      follower.user = doc["user"];
      follower.isEnabled = doc["isEnabled"];
      followers.add(follower);
    });
  });
  return followers;
}

Future<List<Follower?>> readRequests(String uid) async {
  List<Follower> followers = [];
  Follower follower = Follower(
    followerID: "",
    user: "",
    followed: "",
    isEnabled: false,
  );
  await FirebaseFirestore.instance
      .collection('followers')
      .where("followed", isEqualTo: uid)
      .where("isEnabled", isEqualTo: false)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      follower.followerID = doc["followerID"];
      follower.followed = doc["followed"];
      follower.user = doc["user"];
      follower.isEnabled = doc["isEnabled"];
      followers.add(follower);
    });
  });
  return followers;
}

Future<Comment?> getCommentWithId(String commentId) async {
  Comment comment = Comment(
    commentID: "",
    postID: "",
    userID: "",
    commentText: "",
  );
  await FirebaseFirestore.instance
      .collection("comments")
      .where("commentID", isEqualTo: commentId)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      comment.commentID = doc["commentID"];
      comment.postID = doc["postID"];
      comment.userID = doc["userID"];
      comment.commentText = doc["commentText"];
    });
  });
  return comment;
}

Future<User1?> readUserWithId(String uid) async {
  User1 user = User1(
      MBTI: "",
      profileImage: "",
      followers: 0,
      following: 0,
      userID: "",
      name: "",
      surname: "",
      email: "",
      username: "",
      isPrivate: false);
  await FirebaseFirestore.instance
      .collection('users')
      .where("userID", isEqualTo: uid)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      user.profileImage = doc["profileImage"];
      user.userID = doc["userID"];
      user.username = doc["username"];
      user.name = doc["name"];
      user.surname = doc["surname"];
      user.MBTI = doc["MBTI"];
      user.followers = doc["followers"];
      user.following = doc["following"];
      user.email = doc["email"];
      user.isPrivate = doc["isPrivate"];
    });
  });
  return user;
}
