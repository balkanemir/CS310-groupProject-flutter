import 'package:flutter/material.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';

import 'package:flutter/material.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';
import 'package:flutterui/models/Comment.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:like_button/like_button.dart';

class CommentPage extends StatefulWidget {
  static const String routeName = '/comment';
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> Comments = [
    Comment(
      commentId: 100,
      userImage: 'https://picsum.photos/seed/picsum/200/300',
      uName: 'Püren',
      uSurname: 'Tap',
      username: 'ptap',
      comment: 'Looks great!',
    ),
    Comment(
      commentId: 150,
      userImage: 'https://picsum.photos/200/300?grayscale',
      uName: 'Kalender',
      uSurname: 'Gülbudak',
      username: 'kalender',
      comment: 'Amazing!',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: textOnSecondaryWhite,
        appBar: AppBar(
          toolbarHeight: 70.0,
          backgroundColor: secondaryPinkLight,
          title: Text(
              'Comments',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              )
          ),

        ),
        body: Column (
            children: <Widget> [
              Container(
                padding: Dimension.regularPadding,
                child: Container(
                    decoration: BoxDecoration(
                      color: textOnSecondaryWhite,
                    ),
                    child: Column(

                      children: <Widget>[

                        Container(
                          height: 200.0,
                          width: screenSize(context).width,
                          decoration: BoxDecoration(
                            color: primaryPinkLight,
                            borderRadius: Dimension.circularRadius,
                          ),

                          padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                          child: Row(
                              children: <Widget> [
                                CircleAvatar(radius: 35.0, backgroundImage: NetworkImage('https://picsum.photos/200/300')),
                                SizedBox(width: 10.0),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget> [
                                      Text("Melisa Yilmaz"),
                                      Container(
                                        child: AutoSizeText(
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae ipsum sem. Suspendisse blandit ultrices massa, quis lacinia urna imperdiet.'),
                                      ),




                                    ]
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    LikeButton(
                                      size: 20,
                                    ),
                                  ],
                                )
                              ]
                          ),
                        ),
                      ],
                    )
                ),
              ),
              Expanded(
                  child: Container(
                      child: Container(
                          decoration: BoxDecoration(
                            color: textOnSecondaryWhite,
                          ),
                          child: ClipRRect(
                              child: ListView.builder(
                                padding: EdgeInsets.all(10.0),
                                itemCount: Comments.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final Comment comment = Comments[index];
                                  return Container(
                                    margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    decoration: BoxDecoration(
                                      color: primaryPinkLight,
                                      borderRadius: Dimension.circularRadius,

                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget> [
                                          Row (
                                              children: <Widget> [
                                                CircleAvatar(radius: 35.0, backgroundImage: NetworkImage("https://picsum.photos/200/300?grayscale") ),
                                                SizedBox(width: 10.0),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget> [
                                                    Text(
                                                        comment.uName + " " + comment.uSurname,
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15.0,
                                                          fontWeight: FontWeight.normal,
                                                        )
                                                    ),
                                                    SizedBox(height: 5.0),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width*0.45,
                                                      child: AutoSizeText(
                                                          comment.comment,
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15.0,
                                                            fontWeight: FontWeight.normal,
                                                          )
                                                      ),
                                                    ),


                                                  ],

                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    LikeButton(
                                                      size: 20,
                                                    ),
                                                  ],
                                                )
                                              ]
                                          )
                                        ],
                                      ),
                                    ),
                                  );

                                },
                              )
                          )

                      )
                  )

              )

            ]
        )
    );
  }
}