import 'package:eye/constants.dart';
import 'package:eye/core/utils/styles.dart';
import 'package:flutter/material.dart';

class SecondBox extends StatelessWidget {
  const SecondBox(
      {super.key, required this.text, this.width = 140, this.height = 60});
  final String text;

  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: borderColor)),
          alignment: Alignment.center,
          child: Text(
            text,
            style: Styles.brownWithoutShadow11,
          ),
        ),
      ],
    );
  }
}
