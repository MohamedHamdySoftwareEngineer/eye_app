import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/assets.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        // SvgPicture.asset(AssetsData.eyeSplash,fit: BoxFit.fill,),
        Image.asset(AssetsData.eyeSplashJPG),
      ],
    );
  }
}