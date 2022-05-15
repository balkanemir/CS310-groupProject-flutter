import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/models/Post.dart';
import 'package:like_button/like_button.dart';

class PostCardTemplate extends StatelessWidget {
  final User user;
  final Post post;
  PostCardTemplate({required this.user, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 10,
        color: Colors.grey[100],
        shadowColor: Colors.grey[500],
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: secondaryPinkLight,
                backgroundImage: NetworkImage(
                    'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png'),
              ),
              title: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "${user.name} ${user.surname}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: " (${user.username})",
                    )
                  ],
                ),
              ),
              subtitle: post.text != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(post.text!),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    )
                  : null,
            ),
            if (post.image != null) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    post.image!,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ],
            Container(
              color: Colors.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.comment, size: 20, color: Colors.grey),
                    label: Text("${post.comment}"),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border,
                        size: 20, color: Colors.grey),
                    label: Text("${post.like}"),
                  ),
                  SizedBox(
                    width: 175,
                  ),
                  IconButton(
                    onPressed: () {},
                    splashRadius: 20,
                    icon: Icon(Icons.delete, size: 20, color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
