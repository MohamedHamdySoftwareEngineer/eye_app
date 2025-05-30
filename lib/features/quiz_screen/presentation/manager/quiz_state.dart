import 'package:equatable/equatable.dart';
import 'package:eye/features/home/data/models/quiz_model.dart';
import 'package:eye/features/quiz_screen/presentation/views/widgets/quiz_screen_body.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<QuizModel> questions;
  const QuizLoaded(this.questions);
  @override
  List<Object?> get props => [questions];
}

class QuizError extends QuizState {
  final String message;
  const QuizError(this.message);
  @override
  List<Object?> get props => [message];
}
