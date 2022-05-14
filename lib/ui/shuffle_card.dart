import 'package:flutter/material.dart';
import 'package:flutterui/models/User.dart';
import 'package:flutterui/utils/colors.dart';


import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';






class ShuffleCard extends StatefulWidget {

  final User user;

  const ShuffleCard({Key? key, required this.user}) : super(key: key);

  @override
  _ShuffleCardState createState() => _ShuffleCardState(user);
}

class _ShuffleCardState extends State<ShuffleCard> {
  final User user;
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();


  _ShuffleCardState(this.user);

  @override
  void initState() {
    for (int i = 0; i <10; i++) {
      _swipeItems.add(SwipeItem(
          content: User(profile_image: user.profile_image, id: user.id, name: user.name, surname: user.surname, username: user.username, email: user.email, MBTI_type: user.MBTI_type ),
          likeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Liked ${user.username}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Nope ${user.username}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Superliked ${user.username}"),
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
                border: Border.all(width:1.0),
                image: DecorationImage(image: NetworkImage(_swipeItems[index].content.profile_image)),
              ),
                    
                    
                    child: Text(
                      _swipeItems[index].content.name,
                      style: TextStyle(fontSize: 10),
                    
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _matchEngine!.currentItem?.nope();
                  },
                  child: Text("Nope")),
              ElevatedButton(
                  onPressed: () {
                    _matchEngine!.currentItem?.superLike();
                  },
                  child: Text("Superlike")),
              ElevatedButton(
                  onPressed: () {
                    _matchEngine!.currentItem?.like();
                  },
                  child: Text("Like"))
            ],
          )
        ])));
  }
}