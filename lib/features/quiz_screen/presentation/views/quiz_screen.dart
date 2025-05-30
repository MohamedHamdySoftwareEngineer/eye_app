import 'package:eye/features/quiz_screen/presentation/views/widgets/quiz_screen_body.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: QuizScreenBody(),
    );
  }
}
