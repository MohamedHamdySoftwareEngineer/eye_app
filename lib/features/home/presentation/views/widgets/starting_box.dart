import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/widgets/main_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';

class StartingBox extends StatelessWidget {
  const StartingBox({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(AppRouter.rLeaderboard);
      },
      child: const MainBox(
        text: 'يلا نحل',
        assetName: AssetsData.arrowIcon,
        numWidHig: 70,
        numRight: -7,
        numTop: -5,
      ),
    );
  }
}
