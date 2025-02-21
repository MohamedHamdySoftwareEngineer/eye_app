import 'package:eye/core/utils/assets.dart';
import 'package:eye/features/home/presentation/views/widgets/classifier_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StrongestClassifiers extends StatelessWidget {
  const StrongestClassifiers({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        
        double screenHeight = constraints.maxHeight;
        return Row(
          children: [
             Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const ClassifierItem(
                        xAxiz: 2,
                        yAxiz: 0,
                        imagePath: AssetsData.classifierPhotoPNG,
                        name: 'محمد',
                        points: 3128,
                      ),
                      SizedBox(height: screenHeight * 0.15),
                      const ClassifierItem(
                        xAxiz: 0.2,
                        yAxiz: 0,
                        imagePath: AssetsData.classifierPhotoPNG,
                        name: 'محمد',
                        points: 2100,
                      ),
                      SizedBox(height: screenHeight * 0.15),
                      const ClassifierItem(
                        xAxiz: 3,
                        yAxiz: -0.9,
                        imagePath: AssetsData.classifierPhotoPNG,
                        name: 'محمد',
                        points: 2100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: screenHeight * 0.50,
                child: Image.asset(AssetsData.trophyImage),
              ),
            ),
          ],
        );
      }),
    );
  }
}
