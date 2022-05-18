import 'package:flutter/material.dart';

class Comment {
  int commentId;
  String userImage;
  String uName;
  String uSurname;
  String username;
  String comment;

  Comment(
      {
        required this.commentId,
        required this.userImage,
        required this.uName,
        required this.uSurname,
        required this.username,
        required this.comment});
}