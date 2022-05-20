import 'package:flutterui/models/User.dart';

class Message {
  String sender;
  String time;
  String message;
  bool isLiked;
  bool unread;

  Message(
      {
        required this.sender,
        required this.time,
        required this.message,
        required this.isLiked,
        required this.unread,});
}