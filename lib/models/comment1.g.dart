part of 'comment1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      userID: json['userID'] as String,
      postID: json['postID'] as String,
      commentID: json['commentID'] as String,
      commentText: json['commentText'] as String,

    );


Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'userID': instance.userID,
      'postID': instance.postID,
      'commentID': instance.commentID,
      'commentText': instance.commentText,
    };