import 'package:flutter/material.dart';
import 'package:flutterui/ui/shuffle_card.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';


class Shuffle extends StatefulWidget {
  
  static const String routeName = '/shuffle';
  @override
  _ShuffleState createState() => _ShuffleState();
}

class _ShuffleState extends State<Shuffle> {

  
  int _currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentindex,
            backgroundColor: primaryPink200,
            selectedItemColor: textOnSecondaryWhite,
            unselectedItemColor: secondaryPink800,
            selectedFontSize: 18.0,
            unselectedFontSize: 18.0,
            onTap: (value) {
              // add what you want to do after tapped
              setState(() => _currentindex = value);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shuffle), label: 'Shuffle'),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add')
            ]),
            body: ShuffleCard()
    );
  }
}