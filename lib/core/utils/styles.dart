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

  static const classifierTextStyle =
      TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w900);
  static const bottomTextStyle =
      TextStyle(fontSize: 10, color: secondColor, fontWeight: FontWeight.w300);

  static const strongestclassifiersText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w900,
    shadows: [
      Shadow(
        blurRadius: 4,
        color: shadowMainColor,
        offset: Offset(-1, 3),
      )
    ],
  );
}
