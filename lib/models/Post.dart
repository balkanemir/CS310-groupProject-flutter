class Post {
  int postID;
  String? image;
  String? text;
  DateTime date;
  int like;
  int comment;

  Post(this.postID, this.date, this.like, this.comment,
      {this.image, this.text});
}
