import 'dart:convert';
//import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'follower1.g.dart';

@JsonSerializable()
class Follower {
  String followed;
  String user;
  bool isEnabled;
  String followerID;

  Follower({
    required this.followed,
    required this.user,
    required this.isEnabled,
    required this.followerID,
  });

  factory Follower.fromJson(Map<String, dynamic> json) =>
      _$FollowerFromJson(json);
  Map<String, dynamic> toJson() => _$FollowerToJson(this);
}
