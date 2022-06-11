import 'package:flutter/material.dart';
import 'dart:io';

class ZoomedImage extends StatelessWidget {
  final image;
  const ZoomedImage({this.image});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
      child: CircleAvatar(
          radius: 300,
          child: Image.file(
            File(image),
            fit: BoxFit.fill,
          ),
          backgroundColor: Colors.transparent),
    );
  }
}
