import 'package:eye/constants.dart';
import 'package:flutter/material.dart';

abstract class Styles {
  static const myWelcomeText18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: textColor,
    shadows: [
      Shadow(
        blurRadius: 8,
        color: shadowMainColor,
        offset: Offset(0, 4),
      )
    ],
  );

  static const customtextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
}
