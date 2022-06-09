import 'dart:ffi';

class Follower {
  String followed;
  String user;
  bool isEnabled;
  //post ID ekle

  Follower({
    required this.followed,
    required this.user,
    required this.isEnabled,
  });
}
