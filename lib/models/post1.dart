import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'post1.g.dart';
@JsonSerializable()
class Post {
  String userID;
  String postID;
  DateTime date;
  int comments;
  String? postImage;
  String? postText;
  int likes;

  Post({
    required this.userID,
    required this.postID,
    required this.date,
    required this.comments,
    this.postImage,
    this.postText,
    required this.likes,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

}