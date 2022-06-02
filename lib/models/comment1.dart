import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'comment1.g.dart';

@JsonSerializable()
class Comment {
  String userID;
  String postID;
  String commentID;
  String commentText;

  Comment({
    required this.userID,
    required this.postID,
    required this.commentID,
    required this.commentText,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);

}