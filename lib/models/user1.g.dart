// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


User _$UserFromJson(Map<String, dynamic> json) => User(
      userID: json['userID'] as int,
      name: json['name'] as String,
      surname: json['surname'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      MBTI: json['MBTI'] as String,
      profileImage: json['profileImage'] as String,
      bio: json['bio'] as String,
      following: json['following'] as int,
      followers: json['followers'] as int,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userID': instance.userID,
      'name': instance.name,
      'surname': instance.surname,
      'username': instance.username,
      'email': instance.email,
      'MBTI': instance.MBTI,
      'profileImage': instance.profileImage,
      'bio': instance.bio,
      'following': instance.following,
      'followers': instance.followers,
    };