import 'package:eye/core/utils/assets.dart';
import 'package:eye/features/home/presentation/views/widgets/classifier_item.dart';
import 'package:flutter/material.dart';

class StrongestClassifiers extends StatelessWidget {
  const StrongestClassifiers({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          const Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [  
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClassifierItem(
                      xAxiz: 2,
                      yAxiz: 0,
                      imagePath: AssetsData.classifierPhotoPNG,
                      name: 'محمد',
                      points: 3128,
                    ),
                    SizedBox(height: 60),
                    ClassifierItem(
                      xAxiz: 0.2,
                      yAxiz: 0,
                      imagePath: AssetsData.classifierPhotoPNG,
                      name: 'محمد',
                      points: 2100,
                    ),
                    SizedBox(height: 60),
                    ClassifierItem(
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
              child: Image.asset(AssetsData.trophyImage),
            ),
          ),
        ],
      ),
    );
  }
}
