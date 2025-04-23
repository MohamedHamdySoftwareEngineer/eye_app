// Enhanced ChoiceScreenBody
import 'package:eye/core/utils/styles.dart';
import 'package:eye/core/widgets/base_scaffold.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            // Header with decoration
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFF5EBE0),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB28B67).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'إختر المادة',
                      style: Styles.brownWithoutShadow18,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'قم بإختيار المادة التي ترغب في حل الأسئلة عليها أو قم بالنقر على عشوائي لتعيش تجربة الإختبار',
                    style: Styles.brownWithoutShadow11,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Subject options grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.6,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  OptionBox(
                    text: 'أحياء',
                    icon: Icons.biotech,
                    color: Colors.white,
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.rQuizScreen);
                    },
                  ),
                  OptionBox(
                    text: 'فيزياء',
                    icon: Icons.science,
                    color: Colors.white,
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.rQuizScreen);
                    },
                  ),
                  OptionBox(
                    text: 'كيمياء',
                    icon: Icons.science,
                    color: Colors.white,
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.rQuizScreen);
                    },
                  ),
                  OptionBox(
                    text: 'رياضيات',
                    icon: Icons.calculate,
                    color: Colors.white,
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.rQuizScreen);
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Random option button
            OptionBox(
              text: 'عشوائي',
              percOfWidth: 0.9,
              height: 65,
              icon: Icons.shuffle,
              color: const Color(0xFFB28B67).withOpacity(0.2),
              onTap: () {
                GoRouter.of(context).push(AppRouter.rQuizScreen);
              },
            ),
            
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}