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
            // Simple yet pretty header
// Modern quiz app subject header with card-style design
Container(
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.indigo.withOpacity(0.1),
        blurRadius: 15,
        offset: const Offset(0, 5),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      // Colorful top banner
      Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6A6FC8), 
              Color(0xFF4E54C8)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20)
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.menu_book,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'إختر المادة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    
                  ),
                  
                ),
              ],
            ),
            // Quiz icon
            Icon(
              Icons.quiz_outlined,
              color: Colors.white.withOpacity(0.9),
              size: 24,
            ),
          ],
        ),
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
            
            
          ],
        ),
      ),
    );
  }
}