class User {
  String profile_image;
  int id;
  String name;
  String surname;
  String username;
  String email;
  String MBTI_type;
  int following;
  int followers;

  User({
    required this.profile_image,
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.MBTI_type,
    required this.following,
    required this.followers,
  });
}
