import 'package:eye/features/quiz_screen/presentation/views/widgets/quiz_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/quiz_cubit.dart';

class QuizScreen extends StatefulWidget {
  final int lessonId;
  const QuizScreen({super.key, required this.lessonId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizCubit>(
      create: (_) {
        final cubit = QuizCubit(quizRepository: RepositoryProvider.of(context));
        // You can load the quiz here if you have a lessonId available
        cubit.loadQuiz(widget.lessonId);
        return cubit;
      },
      child: const Scaffold(
        body: QuizScreenBody(),
      ),
    );
  }
}
