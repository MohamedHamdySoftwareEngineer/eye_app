import 'package:eye/constants.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/widgets/base_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/styles.dart';

class SettingsScreenBody extends StatelessWidget {
  const SettingsScreenBody({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return  BaseWidgets(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Center(child: Text('الإعدادات',style: Styles.brownWithoutShadow18,)),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(AssetsData.invertedTriangle, width: 15,height: 15,),
                const SizedBox(width: 5,),
                Text('إعدادات الملف الشخصي',style: Styles.brownWithoutShadow11.copyWith(fontSize: 14),),
              ],
            ),
            const SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: screenHeight * 0.40,
              
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ],
        ),
      )
      );
  }
}