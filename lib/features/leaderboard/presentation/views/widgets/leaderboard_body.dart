import 'package:eye/constants.dart';
import 'package:eye/core/widgets/base_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/main_box.dart';
import '../../../../home/presentation/views/widgets/classifier_item.dart';

class LeaderboardBody extends StatelessWidget {
  const LeaderboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidgets(
      child: Expanded(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;
            // Define a row height for each classifier row.
            final rowHeight = screenHeight * 0.076;
            // Define spacing between rows.
            final spacing = screenHeight * 0.02;

            return Stack(
              children: [
                // Trophy image positioned on the right.
                Positioned(
                  right: screenWidth * 0.01,
                  top: screenHeight * 0.15,
                  child: Transform.rotate(
                    angle: math.pi / 10,
                    child: SizedBox(
                      width: screenWidth * 0.36,
                      height: screenHeight * 0.46,
                      child: Image.asset(
                        AssetsData.trophyImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                // Build the 10 rows with spacing.
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(10, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: spacing),
                      child: SizedBox(
                        height: rowHeight,
                        child: Stack(
                          children: [
                            // Centered classifier item.
                            Transform.scale(
                              scale: 0.55,
                              child: const ClassifierItem(
                                imagePath: AssetsData.classifierPhotoPNG,
                                name: 'محمد',
                                points: 3000,
                              ),
                            ),
                            // Order number placed immediately to the left of the classifier item.
                            Positioned(
                              left: screenWidth * 0.25,
                              child: Center(
                                child: Text("${index + 1}",
                                    style: Styles.brownText18
                                        .copyWith(color: mainColor)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Positioned(
                  bottom: 10,
                  left: 240,
                  
                  child: InkWell(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.rChoiceScreen);
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
