import 'package:flutter/material.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/routes/profile.dart';
import 'package:flutterui/utils/colors.dart';

import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class ShuffleCard extends StatefulWidget {
  final List<UserModel> Users;

  const ShuffleCard({Key? key, required this.Users}) : super(key: key);

  @override
  _ShuffleCardState createState() => _ShuffleCardState(Users);
}

class _ShuffleCardState extends State<ShuffleCard> {
  final List<UserModel> Users;
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  _ShuffleCardState(this.Users);

  @override
  void initState() {
    for (int i = 0; i < Users.length; i++) {
      _swipeItems.add(SwipeItem(
          content: UserModel(
              profile_image: Users[i].profile_image,
              id: Users[i].id,
              name: Users[i].name,
              surname: Users[i].surname,
              username: Users[i].username,
              email: Users[i].email,
              MBTI_type: Users[i].MBTI_type,
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [primaryPinkLight, secondaryPinkLight],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
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
                      return CircleAvatar(
                        radius: 200,
                        backgroundColor: primaryPinkLight,
                        backgroundImage: NetworkImage(
                            _swipeItems[index].content.profile_image),
                        child: Text(
                          '${_swipeItems[index].content.name} ${_swipeItems[index].content.MBTI_type}',
                          style: TextStyle(fontSize: 20),
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
                      print("item: ${item.content.username}, index: $index");
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
                      children: [
                        Icon(Icons.arrow_back_ios_rounded,
                            color: textOnPrimaryBlack),
                        Text("Pass",
                            style: TextStyle(color: textOnPrimaryBlack))
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {
                      _matchEngine!.currentItem?.superLike();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryPink200,
                      elevation: 5,
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.arrow_upward_rounded,
                            color: textOnPrimaryBlack),
                        Text("Follow",
                            style: TextStyle(color: textOnPrimaryBlack)),
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {
                      _matchEngine!.currentItem?.like();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: secondaryPinkLight,
                      elevation: 5,
                    ),
                    child: Row(
                      children: [
                        Text("Like",
                            style: TextStyle(color: textOnPrimaryBlack)),
                        Icon(Icons.arrow_forward_ios_rounded,
                            color: textOnPrimaryBlack),
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
