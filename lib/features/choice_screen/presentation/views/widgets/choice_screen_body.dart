import 'package:eye/core/utils/styles.dart';
import 'package:eye/core/widgets/base_widgets.dart';
import 'package:eye/core/widgets/second_box.dart';
import 'package:flutter/material.dart';

class ChoiceScreenBody extends StatelessWidget {
  const ChoiceScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseWidgets(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          children: [
            Text(
              'إختر المادة',
              style: Styles.brownWithoutShadow18,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'قم بإختيار المادة التي ترغب في حل الأسئلة عليها أو قم بالنقر على عشوائي لتعيش تجربة الإختبار',
              style: Styles.brownWithoutShadow11,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SecondBox(text: 'فيزياء'),
                SizedBox(
                  width: 10,
                ),
                SecondBox(text: 'كيمياء'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SecondBox(text: 'أحياء'),
                SizedBox(
                  width: 10,
                ),
                SecondBox(text: 'رياضيات'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: SecondBox(text: 'عشوائي'))
          ],
        ),
      ),
    );
  }
}
