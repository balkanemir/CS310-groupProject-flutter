part of 'post1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      userID: json['userID'] as String,
      postID: json['postID'] as String,
      date: json['date'] as DateTime,
      comments: json['comments'] as List<String>,
      postImage: json['postImage'] as String,
      postText: json['postText'] as String,
      likes: json['likes'] as int,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'userID': instance.userID,
      'postID': instance.postID,
      'date': instance.date,
      'comments': instance.comments,
      'postImage': instance.postImage,
      'postText': instance.postText,
      'likes': instance.likes,
    };
