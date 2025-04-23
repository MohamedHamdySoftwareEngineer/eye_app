import 'package:eye/constants.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      // left: back arrow
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 28),
          onPressed: () => GoRouter.of(context).pop(),
          padding: EdgeInsets.zero,
        ),
      ),
      // right: user profile icon
      actions: [
        Padding(
          padding: const EdgeInsets.only(right:  20),
          child: IconButton(
            icon: SvgPicture.asset(
              AssetsData.userIcon,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            
            onPressed: () {
              GoRouter.of(context).push(AppRouter.rUserProfile);
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
