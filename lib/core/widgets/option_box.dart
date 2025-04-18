import 'package:eye/constants.dart';
import 'package:eye/core/utils/styles.dart';
import 'package:flutter/material.dart';

class OptionBox extends StatelessWidget {
  const OptionBox(
      {super.key, required this.text, this.height = 60, this.percOfWidth = 1, this.onTap, });
  final String text;
  final double percOfWidth;
  final double height;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * percOfWidth;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: screenWidth,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor)),
        alignment: Alignment.center,
        child: Text(
          text,
          style: Styles.brownWithoutShadow18,
        ),
      ),
    );
  }
}
