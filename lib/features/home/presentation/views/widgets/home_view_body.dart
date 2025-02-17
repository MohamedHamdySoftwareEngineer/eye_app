import 'package:eye/constants.dart';
import 'package:eye/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:eye/features/home/presentation/views/widgets/starting_box.dart';
import 'package:eye/features/home/presentation/views/widgets/welcome_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/assets.dart';
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
