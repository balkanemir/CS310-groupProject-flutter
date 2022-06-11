import 'dart:convert';
import 'comment1.dart';

import 'package:json_annotation/json_annotation.dart';

part 'post1.g.dart';

@JsonSerializable()
class Post {
  String userID;
  String postID;
  DateTime date;
  List<String> comments;
  String? postImage;
   String? postVideo;
  String? postText;
  int likes;

  Post({
    required this.userID,
    required this.postID,
    required this.date,
    required this.comments,
    this.postImage,
    this.postVideo,
    this.postText,
    required this.likes,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

