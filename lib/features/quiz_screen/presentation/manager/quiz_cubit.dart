import 'package:eye/features/home/data/repositories/quiz_repository.dart';
import 'package:eye/features/quiz_screen/presentation/manager/quiz_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepository quizRepository;

  // : super(QuizInitial()) ensures your cubit starts in a known, valid state.
  QuizCubit({required this.quizRepository}) : super(QuizInitial());

  Future<void> loadQuiz(int lessonId) async {
    emit(QuizLoading());
    try {
      final questions = await quizRepository.fetchQuiz(lessonId);
      emit(QuizLoaded(questions));
    } catch (e) {
      emit(QuizError(e.toString()));
    }
  }
}
