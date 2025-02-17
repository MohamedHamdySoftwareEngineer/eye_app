import 'package:eye/constants.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartingBox extends StatelessWidget {
  const StartingBox({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none, 
        children: [
          Container(
            width: 260,
            height: 60,
            decoration: BoxDecoration(
              color: secondColor,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Text(
              'يلا نحل',
              style: Styles.customtextStyle,
            ),
          ),
          
          Positioned(
            right: -7, 
            top: -5,
            child: SvgPicture.asset(
              AssetsData.arrowIcon,
              width: 70,
              height: 70,
            ),
          ),
        ],
      ),
    );
  }
}

