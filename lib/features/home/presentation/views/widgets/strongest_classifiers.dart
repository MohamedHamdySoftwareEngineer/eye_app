import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/utils/styles.dart';
import 'package:eye/features/home/presentation/views/widgets/classifier_item.dart';
import 'package:flutter/material.dart';

class StrongestClassifiers extends StatelessWidget {
  const StrongestClassifiers({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child:  Column(
        children: [
          Text(
            'الأقوى',
            style: Styles.strongestclassifiersText,
          ),
          SizedBox(
            height: 30,
          ),
          ClassifierItem(xAxiz: -0.3, yAxiz: 0,imagePath:  AssetsData.classifierPhotoPNG,name: 'محمد',points: 3128,),
          SizedBox(
            height: 30,
          ),
          ClassifierItem(xAxiz: -0.7, yAxiz: 0,imagePath:  AssetsData.classifierPhotoPNG,name: 'محمد',points: 2100,),
          SizedBox(
            height: 30,
          ),
          ClassifierItem(xAxiz: 0, yAxiz: -0.9, imagePath:  AssetsData.classifierPhotoPNG,name: 'محمد',points: 2100,),      
        ],
      ),
    );
  }
}
