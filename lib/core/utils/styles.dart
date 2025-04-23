import 'package:eye/core/utils/constants.dart';
import 'package:flutter/material.dart';

abstract class Styles {
  static const brownText18 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: myBrownColor,
    shadows: [
      Shadow(
        blurRadius: 8,
        color: shadowMainColor,
        offset: Offset(0, 4),
      )
    ],
  );

  static const brownWithoutShadow18 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: myBrownColor,
  );

  static const brownWithoutShadow11 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 11,
    fontWeight: FontWeight.w800,
    color: myBrownColor,
  );

  static const customtextStyle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const classifierTextStyle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w900,
  );

  static const renameTextStyle10 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 10,
    color: secondColor,
    fontWeight: FontWeight.w300,
  );

  static const signTextStyle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14,
    color: signColor,
    fontWeight: FontWeight.bold,
  );

  static const splashTextStyle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 18,
    color: mainColor,
    fontWeight: FontWeight.bold,
  );

  static const strongestclassifiersText = TextStyle(
    fontFamily: 'Cairo',
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
