import 'package:eye/constants.dart';
import 'package:eye/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:eye/features/home/presentation/views/widgets/welcome_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/styles.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomAppBar(),
        WelcomeText(),
        StartingBox(),
      ],
    );
  }
}


class StartingBox extends StatelessWidget {
  const StartingBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 260,
      height: 60,
      decoration: BoxDecoration(
        color: secondColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text('يلا نحل',style: Styles.customtextStyle),
    );
  }
}
