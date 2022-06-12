import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/models/user1.dart';
import 'package:flutterui/routes/profile.dart';
import 'package:flutterui/services/databaseWrite.dart';
import 'package:flutterui/utils/colors.dart';

import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class ShuffleCard extends StatefulWidget {
  final List<User1> Users;

  const ShuffleCard({Key? key, required this.Users}) : super(key: key);

  @override
  _ShuffleCardState createState() => _ShuffleCardState(Users);
}

class _ShuffleCardState extends State<ShuffleCard> {
  final List<User1> Users;
  User1? followUsers;
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  _ShuffleCardState(this.Users);
  

  @override
  
 

  void initState() {
    for (int i = 0; i < Users.length; i++) {
      _swipeItems.add(SwipeItem(
          content: User1(
              profileImage: Users[i].profileImage,
              userID: Users[i].userID,
              name: Users[i].name,
              surname: Users[i].surname,
              username: Users[i].username,
              email: Users[i].email,
              isPrivate: false,
              MBTI: Users[i].MBTI,
              following: Users[i].following,
              followers: Users[i].followers),
          likeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              backgroundColor: secondaryPinkLight,
              content: Text("Liked ${Users[i].username}",
                  style: TextStyle(color: textOnPrimaryBlack)),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              backgroundColor: primaryPinkLight,
              content: Text("Passed ${Users[i].username}",
                  style: TextStyle(color: textOnPrimaryBlack)),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              backgroundColor: primaryPink200,
              content: Text("Followed ${Users[i].username}",
                  style: TextStyle(color: textOnPrimaryBlack)),
              duration: Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                child: Stack(children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: primaryPink200,
                  radius: 200,
                  child: SwipeCards(
                    matchEngine: _matchEngine!,
                    itemBuilder: (BuildContext context, int index) {
                      followUsers = _swipeItems[index].content;
                      return CircleAvatar(
                       
                        radius: 200,
                        backgroundColor: primaryPinkLight,
                        backgroundImage: NetworkImage(
                            _swipeItems[index].content.profileImage),
                        child: Text(
                          '${_swipeItems[index].content.name} ${_swipeItems[index].content.MBTI}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    },
                    onStackFinished: () {
                      _scaffoldKey.currentState!.showSnackBar(SnackBar(
                        content: Text("Stack Finished"),
                        duration: Duration(milliseconds: 500),
                      ));
                    },
                    itemChanged: (SwipeItem item, int index) {
                      //print("item: ${item.content.username}, index: $index");
                    },
                    upSwipeAllowed: true,
                    fillSpace: true,
                  ),
                ),
              ),
            ])),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _matchEngine!.currentItem?.nope();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryPinkLight,
                      elevation: 5,
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back_ios_rounded,
                            color: secondaryPinkDark
                            ),
                        Text("Pass",
                            style: TextStyle(color: textOnPrimaryBlack))
                      ],
                    )),
                ElevatedButton( 
                    onPressed: () {
                      User1? myUser = followUsers;
                      print("followlayacagim userin idsi ${myUser!.userID}");
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        var currentUserId = auth.currentUser!.uid;
                        print("ben ${currentUserId}");
                        createFollower(
                          followed: followUsers!.userID,
                          followerID: "",
                          isEnabled: true,
                          user: currentUserId,
                      );
                      print("OLDU MU?");
                      _matchEngine!.currentItem?.superLike();

                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryPinkLight,
                      elevation: 5,
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.arrow_upward_rounded,
                            color: secondaryPinkDark),
                        Text("Follow",
                            style: TextStyle(color: textOnPrimaryBlack)),
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {
                      _matchEngine!.currentItem?.like();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryPinkLight,
                      elevation: 5,
                    ),
                    child: Row(
                      children :const [
                        Text("Like",
                            style: TextStyle(color: textOnPrimaryBlack)),
                        Icon(Icons.arrow_forward_ios_rounded,
                            color: secondaryPinkDark),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

/* */