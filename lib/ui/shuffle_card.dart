import 'package:flutter/material.dart';
import 'package:flutterui/utils/colors.dart';

class ShuffleCard extends StatelessWidget {

String profile_image;
  int index;
  String name;
  String surname;
  String MBTI_type;
  ShuffleCard({
    required this.profile_image,
    required this.index,
    required this.name,
    required this.surname,
    required this.MBTI_type,
  }) ;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(

      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Center(
            child: Container(
                  width: 300,
                  height: 500,
                  decoration: BoxDecoration(
                    color: primaryPink200,
                    border: Border.all(width: 2.0, color: Colors.black),
                    borderRadius: BorderRadius.circular(18.0),
                  )
                ),
          ),
              Container(
                margin: EdgeInsets.only(top: 450.0),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: secondaryPinkLight,
                  border: Border.all(width: 1.0)
                )
              )
        ],
      ),
    );
  }
}
