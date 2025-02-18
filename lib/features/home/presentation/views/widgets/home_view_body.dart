import 'package:eye/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:eye/features/home/presentation/views/widgets/starting_box.dart';
import 'package:eye/features/home/presentation/views/widgets/welcome_text.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/styles.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomAppBar(),
        WelcomeText(),
        SizedBox(
          height: 40,
        ),
        StartingBox(),
        SizedBox(
          height: 50,
        ),
        StrongestClassifiers(),
      ],
    );
  }
}

class StrongestClassifiers extends StatelessWidget {
  const StrongestClassifiers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'الأقوى',
          style: Styles.customtextStyle.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 25,
          shadows: [
            const Shadow(
              blurRadius: 7,
              color: shadowMainColor,
              offset: Offset(-1, 5),
            )
          ]),
        ),
      ],
    );
  }
}
