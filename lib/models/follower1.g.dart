part of 'follower1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Follower _$FollowerFromJson(Map<String, dynamic> json) => Follower(
      followed: json['userID'] as String,
      followerID: json['followerID'] as String,
      user: json['postID'] as String,
      isEnabled: json['commentID'] as bool,
    );

Map<String, dynamic> _$FollowerToJson(Follower instance) => <String, dynamic>{
      'followed': instance.followed,
      'followerID': instance.followerID,
      'user': instance.user,
      'isEnabled': instance.isEnabled,
    };
