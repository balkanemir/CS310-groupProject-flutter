import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/routes/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colors.dart';


class WalkthroughItem extends StatefulWidget {

  final description;
  final index;
  final totalItem;
  final controller;
  final Map<String, dynamic>? item;

  const WalkthroughItem({Key? key, this.controller, this.description, this.index, this.totalItem, this.item}) : super(key: key);

  @override
  _WalkthroughItemState createState() => _WalkthroughItemState();
}

class _WalkthroughItemState extends State<WalkthroughItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryPink200,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.index == 0 ? [

                Container(
                    alignment: Alignment.center,
                    child: Image.asset(widget.item!['image'] ?? '', width: 150, alignment: Alignment.center,)
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 80),
                  child: widget.item!['title'] ?? Text("", textAlign: TextAlign.center),
                ),
              ] : [

                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Image.asset(widget.item!['image'] ?? '', width: 150,)
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 80),
                  child: widget.item!['title'] ?? Text("", textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              onTap: () async {
                if ((widget.index+1) == widget.totalItem) {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool(('showHome'), true);

                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                } else {
                  await widget.controller.animateToPage(widget.index + 1, curve: Curves.easeIn,duration: Duration(milliseconds: 200),);
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 52,
                margin: EdgeInsets.only(top: 30, bottom: 60, left: 30, right: 30),
                padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 5),
                decoration: BoxDecoration(
                  color: secondaryBackgroundWhite,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      color: primaryPinkLight,
                      blurRadius: 40,
                      spreadRadius: 10,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Text(
                  widget.item!['button_text'] ?? 'Continue',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textOnPrimaryBlack,
                      fontSize: 16
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}