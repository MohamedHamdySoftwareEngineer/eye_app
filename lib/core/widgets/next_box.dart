import 'package:eye/core/utils/app_router.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/widgets/main_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NextBox extends StatelessWidget {
  const NextBox({
    super.key, required this.screenRoute,
  });
  final String screenRoute;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 240,
      child: InkWell(
        onTap: () {
          GoRouter.of(context).push(screenRoute);
        },
        child: const MainBox(
          text: 'التالي',
          assetName: AssetsData.arrowIconInternal,
          numWidHig: 16,
          numRight: 5,
          numTop: 7,
          width: 100,
          height: 30,
        ),
      ),
    );
  }
}
