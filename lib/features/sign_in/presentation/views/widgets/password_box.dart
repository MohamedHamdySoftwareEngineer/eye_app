import 'package:eye/constants.dart';
import 'package:eye/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/assets.dart';

class PasswordBox extends StatelessWidget {
  const PasswordBox({super.key,required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      width: 260,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text:  TextSpan(
                text: text,
                style: Styles.signTextStyle,
                children: const [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Color(0xffE43B3B),
                    ),
                  ),
                ]),
          ),

          SvgPicture.asset(AssetsData.passwordEye,width: 20,height: 20,),
        ],
      ),
    );
  }
}
