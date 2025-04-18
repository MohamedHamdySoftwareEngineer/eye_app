import 'package:eye/core/widgets/base_scaffold.dart';
import 'package:eye/features/home/presentation/views/widgets/starting_box.dart';
import 'package:eye/features/home/presentation/views/widgets/strongest_classifiers.dart';
import 'package:eye/features/home/presentation/views/widgets/welcome_text.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/styles.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      child: Column(
        children: [
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
        ],
      ),
    );
  }
}
