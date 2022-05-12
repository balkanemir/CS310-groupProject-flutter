import 'package:flutter/material.dart';
import 'package:flutterui/utils/colors.dart';


import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

 class Content {
    final String text;
    final Color color;

    Content({required this.text, required this.color});
  }




class ShuffleCard extends StatefulWidget {
  ShuffleCard({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ShuffleCardState createState() => _ShuffleCardState();
}

class _ShuffleCardState extends State<ShuffleCard> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange",
    "Grey",
    "Purple",
    "Pink"
  ];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.grey,
    Colors.purple,
    Colors.pink
  ];

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Superliked ${_names[i]}"),
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
                color: _swipeItems[index].content.color,
              ),
                    alignment: Alignment.center,
                    
                    child: Text(
                      _swipeItems[index].content.text,
                      style: TextStyle(fontSize: 100),
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
                  print("item: ${item.content.text}, index: $index");
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