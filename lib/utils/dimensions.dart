import 'package:flutter/material.dart';

class Dimension {
  static const double parentMargin = 16.0;
  static const double regularMargin = 10.0;

  static const double circularMargin = 30;

  static get regularParentPadding => const EdgeInsets.all(parentMargin);
  static get regularPadding => const EdgeInsets.all(regularMargin);

  static get circularRadius => BorderRadius.circular(circularMargin);

}