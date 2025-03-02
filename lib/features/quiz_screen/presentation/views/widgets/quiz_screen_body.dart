import 'package:eye/core/widgets/base_widgets.dart';
import 'package:eye/core/widgets/option_box.dart';
import 'package:eye/features/quiz_screen/presentation/views/widgets/quiz_box.dart';
import 'package:flutter/material.dart';

class QuizScreenBody extends StatelessWidget {
  const QuizScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidgets(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          quizDetails(),
          const SizedBox(
            height: 20,
          ),
          theQuestion(),
          const SizedBox(
            height: 20,
          ),
          answerOptions(context),
        ],
      ),
    ));
  }

  QuizBox theQuestion() {
    return const QuizBox(
      text: 'ما هو حاصل جمع 3 + 4 ؟',
      radius: 10,
      percOfWidth: 0.85,
      minHeight: 70,
      maxHeight: 100,
    );
  }

  Row quizDetails() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        QuizBox(
          text: 'صعب',
          maxHeight: 60,
        ),
        SizedBox(
          width: 10,
        ),
        QuizBox(
          text: ': عدد نقاطك \n 100',
          maxHeight: 60,
        ),
        SizedBox(
          width: 10,
        ),
        QuizBox(
          text: '60s',
          maxHeight: 60,
        ),
      ],
    );
  }

  Widget answerOptions(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      runAlignment: WrapAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
               const SnackBar(
                content: Text('wrong answer!',),
                duration: Duration(seconds: 1),
                
              ),
            );
          },
          child: const OptionBox(
            text: '5',
            percOfWidth: 1,
          ),
        ),
        InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('wrong answer!'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          child: const OptionBox(
            text: '6',
            percOfWidth: 1,
          ),
        ),
        InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('right answer!'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          child: const OptionBox(
            text: '7',
            percOfWidth: 1,
          ),
        ),
        InkWell(
          onTap: () {
           ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('wrong answer!'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          child: const OptionBox(
            text: '8',
            percOfWidth: 1,
          ),
        ),
      ],
    );
  }
}
