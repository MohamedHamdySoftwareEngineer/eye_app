import 'package:eye/constants.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_router.dart';

class CustomAppBar extends StatelessWidget  {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Padding(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
            
            firstIcon(context),
            // middleIcons(),
            lastIcon(context),
          ]),
        ),
      ),
    );

    
  }

  Widget lastIcon(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 3),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          GoRouter.of(context).push(AppRouter.rUserProfile);
        },
        icon: SvgPicture.asset(
          width: 70,      
          AssetsData.userIcon,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Expanded middleIcons() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            width: 40,
            AssetsData.homeIcon,
            fit: BoxFit.contain,
          ),
          SvgPicture.asset(
            width: 40,
            AssetsData.trophyIcon,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

   Widget firstIcon(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 3),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          GoRouter.of(context).push(AppRouter.rUserProfile);
        },
        icon: const Icon(Icons.settings_rounded,size: 30,),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
