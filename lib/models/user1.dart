

import 'package:json_annotation/json_annotation.dart';
part 'user1.g.dart';
@JsonSerializable()
class User {
  String userID;
  String name;
  String surname;
  String username;
  String email;
  String profileImage;
  String MBTI;
  String? bio;
  int following;
  int followers;

  User({
    required this.profileImage,
    required this.userID,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.MBTI,
    required this.following,
    required this.followers,
    this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  
}