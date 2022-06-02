import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/models/user1.dart';
import 'package:flutterui/models/post1.dart';
import 'package:flutterui/routes/comment.dart';
import 'package:flutterui/routes/profile.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:like_button/like_button.dart';
import '../models/comment1.dart';

class PostCardTemplate extends StatelessWidget {
  final String uid;
  final User1? user;
  final Post post;
  final Comment comment;
  PostCardTemplate({
    Key? key,
    required this.uid,
    required this.user,
    required this.post,
    required this.comment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),

      child: Card(
        
        color: textOnSecondaryWhite,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ListTile(
                leading: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: secondaryBackgroundWhite,
                    shape: const CircleBorder(),
                  ),
                  child: CircleAvatar(
                      radius: 30,
                      backgroundColor: primaryPinkLight,

                      backgroundImage: NetworkImage(user!.profileImage)),

                ),
                
                title: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                    ),

                    children: <TextSpan>[
                      TextSpan(
                        text: "${user?.name} ${user?.surname}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: " @${user?.username}",
                      )
                    ],
                  ),
                ),
                subtitle: post.postText != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(post.postText!),
                         const  SizedBox(
                            height: 15,
                          ),
                        ],
                      )
                    : null,
              ),
            ),
            if (post.postImage != null && post.postImage!="") ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    post.postImage!,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ],
            Container(
              color: textOnSecondaryWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  TextButton.icon(
                    onPressed: () {
                        Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CommentPage()));
                    },
                    icon: const Icon(
                      Icons.comment, 
                      size: 15, 
                      color: Colors.grey),
                    label: Text("${comment.commentText}", 
                              style: const TextStyle(
                              color: textOnPrimaryBlack,
                              fontSize: 10,
                            )
                            ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const LikeButton(
                              size: 15,
                            ),
                            Text("${post.likes}", 
                            style: const TextStyle(
                              color: textOnPrimaryBlack,
                              fontSize: 10,
                            )),
                    ],
                  ),
                  /*
                  SizedBox(
                    width: 175,
                  ),
                  IconButton(
                    onPressed: () {},
                    splashRadius: 20,
                    icon: Icon(Icons.delete, size: 20, color: Colors.grey),
                  ),*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
