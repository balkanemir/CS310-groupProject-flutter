import 'package:flutter/material.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:like_button/like_button.dart';

class PostCard extends StatelessWidget {
  final User user;
  PostCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
            width: screenSize(context).width,
            height: screenHeight(context, dividedBy: 5),
            decoration: BoxDecoration(
                border: Border.all(width: 1.0),
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            child: CircleAvatar(
                                radius: 20,
                                backgroundColor: secondaryPinkLight,
                                backgroundImage:
                                    NetworkImage(user.profile_image)),
                            style: ElevatedButton.styleFrom(
                              primary: secondaryPink800,
                              shape: CircleBorder(),
                            )),
                        Text(
                          user.username,
                          style: TextStyle(
                            color: textOnPrimaryBlack,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        LikeButton(
                          size: 20,
                        ),
                      ],
                    )
                  ]),
            )),
      ),
    );
  }
}
