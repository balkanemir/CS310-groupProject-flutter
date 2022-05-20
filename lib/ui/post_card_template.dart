import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/routes/comment.dart';
import 'package:flutterui/routes/profile.dart';
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
        color: textOnSecondaryWhite,
        child: Column(
          children: [
            ListTile(
              leading: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                style: ElevatedButton.styleFrom(
                  primary: secondaryPinkDark,
                  shape: CircleBorder(),
                ),
                child: CircleAvatar(
                    radius: 30,
                    backgroundColor: primaryPinkLight,
                    backgroundImage: NetworkImage(user.profile_image)),
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
              color: textOnSecondaryWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 10),
                  TextButton.icon(
                    onPressed: () {
                        Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CommentPage()));
                    },
                    icon: Icon(Icons.comment, size: 20, color: Colors.grey),
                    label: Text("${post.comment}", style: TextStyle(
                              color: textOnPrimaryBlack
                            )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LikeButton(
                              size: 20,
                            ),
                            Text("${post.like}", style: TextStyle(
                              color: textOnPrimaryBlack
                            )),
                    ],
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
