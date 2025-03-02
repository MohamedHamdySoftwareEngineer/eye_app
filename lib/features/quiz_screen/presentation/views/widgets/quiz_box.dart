import 'package:eye/constants.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/styles.dart';

class QuizBox extends StatelessWidget {
  const QuizBox({
    super.key,
    required this.text,
    this.radius = 30,
    this.percOfWidth = 0.25,
    this.minHeight = 50,
    this.maxHeight = 70,
    this.paddingNumber = 12,
  });

  final String text;
  final double radius;
  final double percOfWidth;
  final double minHeight;
  final double maxHeight;
  final double paddingNumber;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * percOfWidth,
      constraints: BoxConstraints(
        minHeight: minHeight,
        maxHeight: maxHeight,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: mainColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            color: shadowMainColor,
            offset: Offset(0, 6),
            spreadRadius: -3,
          ),
        ],
      ),
      padding:  EdgeInsets.all(paddingNumber),
      child: Text(
        text,
        style: Styles.brownWithoutShadow11,
        textAlign: TextAlign.center,
      ),
    );
  }
}