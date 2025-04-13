import 'package:eye/core/utils/styles.dart';
import 'package:eye/core/widgets/base_scaffold.dart';
import 'package:eye/core/widgets/next_box.dart';
import 'package:eye/core/widgets/option_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';

class ChoiceScreenBody extends StatelessWidget {
  const ChoiceScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          children: [
            const Text(
              'إختر المادة',
              style: Styles.brownWithoutShadow18,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'قم بإختيار المادة التي ترغب في حل الأسئلة عليها أو قم بالنقر على عشوائي لتعيش تجربة الإختبار',
              style: Styles.brownWithoutShadow11,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              runAlignment: WrapAlignment.spaceBetween,
              children: [
                // OptionBox(text: 'فيزياء'),
                OptionBox(text: 'أحياء',
                onTap: (){
                    GoRouter.of(context).push(AppRouter.rQuizScreen);
                },),
                // OptionBox(text: 'كيمياء'),
                // OptionBox(text: 'رياضيات'),
                // OptionBox(text: 'عشوائي'),
              ],
            ),
            // SizedBox(
            //   height: 5,
            // ),
            // NextBox(
            //   screenRoute: AppRouter.rQuizScreen,
            // ),
          ],
        ),
      ),
    );
  }
}
