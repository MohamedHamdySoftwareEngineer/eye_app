import 'package:eye/constants.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.08,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: shadowMainColor,
              offset: Offset(0, 6),
              spreadRadius: -3,
            ),
          ],
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
          const SizedBox(
            width: 10,
          ),
          bottomIcons(),
        ]),
      ),
    );
  }

  Expanded bottomIcons() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '@Aye team',
                style: Styles.bottomTextStyle,
              )),
          const SizedBox(
            width: 20,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AssetsData.bottomIcon,
                  fit: BoxFit.contain,
                ),
                const Flexible(
                  child: Text(
                    "Telegram group",
                    style: Styles.bottomTextStyle,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
