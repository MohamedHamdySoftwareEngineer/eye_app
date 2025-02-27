import 'package:eye/core/widgets/custom_app_bar.dart';
import 'package:eye/core/widgets/custom_bottom_bar.dart';
import 'package:eye/features/home/presentation/views/widgets/starting_box.dart';
import 'package:eye/features/home/presentation/views/widgets/strongest_classifiers.dart';
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
        SizedBox(
          height: 30,
        ),
        StartingBox(),
        SizedBox(
          height: 60,
        ),
        Text(
          'الأقوى',
          style: Styles.strongestclassifiersText,
        ),
        StrongestClassifiers(),
        CustomBottomBar(),
      ],
    );
  }
}
