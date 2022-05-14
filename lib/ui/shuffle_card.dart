import 'package:flutter/material.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/utils/colors.dart';

import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class ShuffleCard extends StatefulWidget {
  final List<User> Users;

  const ShuffleCard({Key? key, required this.Users}) : super(key: key);

  @override
  _ShuffleCardState createState() => _ShuffleCardState(Users);
}

class _ShuffleCardState extends State<ShuffleCard> {
  final List<User> Users;
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  _ShuffleCardState(this.Users);

  @override
  void initState() {
    for (int i = 0; i < Users.length; i++) {

      _swipeItems.add(SwipeItem(
          content: User(
              profile_image: Users[i].profile_image,
              id: Users[i].id,
              name: Users[i].name,
              surname: Users[i].surname,
              username: Users[i].username,
              email: Users[i].email,
              MBTI_type: Users[i].MBTI_type),
          likeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Liked ${Users[i].username}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Passed ${Users[i].username}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Followed ${Users[i].username}"),
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                child: Stack(children: [
              Center(
                child: Container(
                  width: 300,
                  height: 500,
                  child: SwipeCards(
                    matchEngine: _matchEngine!,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 1.0),
                          image: DecorationImage(
                              image: NetworkImage(
                                  _swipeItems[index].content.profile_image),
                              fit: BoxFit.cover),
                        ),
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
                        primary: secondaryPink800,
                        elevation: 5,
                      ),
                      child: Text("Pass")),
                  ElevatedButton(
                      onPressed: () {
                        _matchEngine!.currentItem?.superLike();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: secondaryPink800,
                        elevation: 5,
                      ),
                      child: Text("Follow")),
                  ElevatedButton(
                      onPressed: () {
                        _matchEngine!.currentItem?.like();
                      },
                       style: ElevatedButton.styleFrom(
                        primary: secondaryPink800,
                        elevation: 5,
                      ),
                      child: Text("Like"))
                ],
              )],
        ),);
  }
}
