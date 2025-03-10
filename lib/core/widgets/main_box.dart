import 'package:eye/constants.dart';
import 'package:eye/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainBox extends StatelessWidget {
   const MainBox({
    super.key,
    required this.text,
     this.assetName = '',
    required this.numWidHig,
    required this.numRight,
    required this.numTop,
    this.width=260,this.height=60
  });
  final String text;
  final String assetName;
  final double numWidHig;
  final double numRight;
  final double numTop;
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
            color: secondColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                blurRadius: 7,
                color: shadowSecondColor,
                offset: Offset(0, 7),
                spreadRadius: -3,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: Styles.customtextStyle,
          ),
        ),
          Positioned(
          right: numRight,
          top: numTop,
          child: SvgPicture.asset(
            assetName,
            width: numWidHig,
            height: numWidHig,
          ),
        ),
      ],
    );
  }
}
