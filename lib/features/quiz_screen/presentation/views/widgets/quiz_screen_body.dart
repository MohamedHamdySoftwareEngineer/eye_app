import 'package:eye/core/widgets/base_scaffold.dart';
import 'package:eye/core/widgets/option_box.dart';
import 'package:eye/features/quiz_screen/presentation/views/widgets/quiz_box.dart';
import 'package:flutter/material.dart';

class QuizScreenBody extends StatelessWidget {
  const QuizScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          quizDetails(),
          const SizedBox(
            height: 40,
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
      mainAxisSize: MainAxisSize.min,
      children: [
        QuizBox(
          text: 'صعب',
          percOfWidth: 0.28,
        ),
        SizedBox(
          width: 15,
        ),
        QuizBox(
          text: ': عدد نقاطك \n 100',
          percOfWidth: 0.28,
        ),
        SizedBox(
          width: 15,
        ),
        QuizBox(
          text: '60s',
          percOfWidth: 0.28,
        ),
      ],
    );
  }

  Widget answerOptions(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'wrong answer!',
                  ),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: const OptionBox(
              text: '5',
              percOfWidth: 0.7,
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
              percOfWidth: 0.7,
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
              percOfWidth: 0.7,
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
              percOfWidth: 0.7,
            ),
          ),
        ],
      ),
    );
  }
}
