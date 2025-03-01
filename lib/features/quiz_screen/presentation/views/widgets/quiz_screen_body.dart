import 'package:eye/core/widgets/base_widgets.dart';
import 'package:eye/features/quiz_screen/presentation/views/widgets/quiz_box.dart';
import 'package:flutter/material.dart';

class QuizScreenBody extends StatelessWidget {
  const QuizScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  BaseWidgets(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
            children: [
              quizDetails(),
              const SizedBox(height: 30,),
              const QuizBox(text: 'السؤال',radius: 10,percOfWidth: 0.85,),
            ],
            ),
      )
    );
  }

  Row quizDetails() {
    return const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                QuizBox(text: 'صعب',),
                SizedBox(width: 10,),
                QuizBox(text: ': عدد نقاطك \n 100'),
                SizedBox(width: 10,),
                QuizBox(text: '60s',),
              ],
            );
  }
}