import 'package:flutter/material.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/utils/colors.dart';


class PostCard extends StatelessWidget {
  final User user; 
  PostCard({required this.user});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Container(
          margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
            width: 350,
            height: 150,
            decoration: BoxDecoration(
                color: primaryPinkDark,
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          child: CircleAvatar(
                              radius: 25,
                              backgroundColor: secondaryPinkLight,
                              backgroundImage: NetworkImage(user.profile_image
                                )),
                          style: ElevatedButton.styleFrom(
                            primary: secondaryPink800,
                            shape: CircleBorder(),
                          )),
                      Text(user.username, style: TextStyle(
                        color: textOnPrimaryBlack,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),)
                    ])
              ]),
            )),
      ),
    );
  }
}
