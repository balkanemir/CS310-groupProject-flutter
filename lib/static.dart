import 'package:flutter/cupertino.dart';
import '../utils/colors.dart';

List<Map<String, Object>> WALKTHROUGH_ITEMS = [
  {
    'image': 'images/w1.png',
    'button_text': 'Continue',
    'title': RichText(text: TextSpan(children: [
      TextSpan(text: 'You’re here to find the person who is a ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Gothic')),
      TextSpan(text: 'perfect match ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Gothic', color: secondaryPinkDark)),
      TextSpan(text: 'to your soul.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Gothic')),
    ]), textAlign: TextAlign.center),
  },
  {
    'image': 'images/w2.png',
    'button_text': 'Continue',
    'title': RichText(text: TextSpan(children: [
      TextSpan(text: 'Swipe right ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Gothic', color: secondaryPinkDark)),
      TextSpan(text: 'to like, ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Gothic')),
      TextSpan(text: 'swipe up ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Gothic', color: secondaryPinkDark)),
      TextSpan(text: 'to follow, ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Gothic')),
      TextSpan(text: 'swipe left ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Gothic', color: secondaryPinkDark)),
      TextSpan(text: 'to pass.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Gothic')),
    ]), textAlign: TextAlign.center)
  },
  {
    'image': 'images/w3.png',
    'button_text': 'Continue',
    'title': RichText(text: TextSpan(children: [
      TextSpan(text: 'When they also swipe right ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Gothic')),
      TextSpan(text: 'It\'s a match!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Gothic', color: secondaryPinkDark)),
    ]), textAlign: TextAlign.center),
  },
  {
    'image': 'images/w4.png',
    'button_text': 'Start Meeting New People',
    'title': RichText(text: TextSpan(children: [
      TextSpan(text: 'Only people ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Gothic')),
      TextSpan(text: 'you\'ve matched with or followed ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Gothic', color: secondaryPinkDark)),
      TextSpan(text: 'can text you.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Gothic')),
    ]), textAlign: TextAlign.center),
  }
];