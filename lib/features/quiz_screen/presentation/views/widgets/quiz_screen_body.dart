import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eye/features/quiz_screen/presentation/manager/quiz_cubit.dart';
import 'package:eye/features/quiz_screen/presentation/manager/quiz_state.dart';
import '../../../../../core/utils/constants.dart';

class QuizScreenBody extends StatefulWidget {
  const QuizScreenBody({super.key});
  @override
  QuizScreenBodyState createState() => QuizScreenBodyState();
}

class QuizScreenBodyState extends State<QuizScreenBody> {
  int selectedChoiceId = -1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        if (state is QuizLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QuizError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is QuizLoaded) {
          final questions = state.questions;
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: backgroundColor,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.03),

                      // Quiz header (you can keep static or derive from state)
                      _buildQuizHeader(),

                      ...questions.map((q) {
                        // For each question render card + options
                        return Column(
                          children: [
                            SizedBox(height: size.height * 0.04),
                            _buildQuestionCard(q),
                            SizedBox(height: size.height * 0.03),
                            _buildAnswerOptions(q),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildQuizHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: backgroundBoxesColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: mainColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildQuizDetailItem(
                icon: Icons.timer_outlined,
                label: '60s',
                iconColor: progressIndeicatorColor),
            Container(height: 40, width: 1, color: mainColor.withOpacity(0.2)),
            _buildQuizDetailItem(
                icon: Icons.star_outline, label: '100 نقطة', iconColor: mainColor),
            Container(height: 40, width: 1, color: mainColor.withOpacity(0.2)),
            _buildQuizDetailItem(
                icon: Icons.fitness_center_outlined,
                label: 'صعب',
                iconColor: secondTextColor),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizDetailItem({
    required IconData icon,
    required String label,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(
                  color: mainTextColor, fontWeight: FontWeight.w600, fontSize: 15))
        ],
      ),
    );
  }

  Widget _buildQuestionCard(q) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: backgroundBoxesColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: mainColor.withOpacity(0.1),
              blurRadius: 25,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: mainColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('السؤال ${q.questionID}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600, color: mainColor)),
            ),
            const SizedBox(height: 20),
            Text(q.questionText,
                style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: mainTextColor,
                    height: 1.5),
                textAlign: TextAlign.right),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(q) {
    return Column(
      children: q.choices.map<Widget>((choice) {
        final isSelected = selectedChoiceId == choice.choiceID;
        final rawValue = 65 + q.choices.indexOf(choice);
final optionLetter = String.fromCharCode(rawValue.toInt());
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedChoiceId = choice.choiceID;
                  isLoading = true;
                });
                Future.delayed(const Duration(milliseconds: 800), () {
                  if (!mounted) return;
                  setState(() => isLoading = false);
                  final isCorrect = choice.isRightAnswer;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(isCorrect ? Icons.check_circle : Icons.cancel,
                              color: Colors.white),
                          const SizedBox(width: 12),
                          Text(isCorrect ? 'إجابة صحيحة!' : 'إجابة خاطئة!',
                              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    backgroundColor:
                        isCorrect ? correctAnswerColor : wrongAnswerColor,
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  ));
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isSelected
                      ? mainColor.withOpacity(0.1)
                      : backgroundBoxesColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: isSelected
                          ? mainColor
                          : mainColor.withOpacity(0.2),
                      width: isSelected ? 2 : 1),
                  boxShadow: [
                    BoxShadow(
                        color: mainColor.withOpacity(isSelected ? 0.15 : 0.05),
                        blurRadius: isSelected ? 15 : 10,
                        offset: const Offset(0, 4)),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                          color: isSelected
                              ? mainColor
                              : mainColor.withOpacity(0.1),
                          shape: BoxShape.circle),
                      child: isSelected && isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white)),
                            )
                          : Center(
                              child: isSelected
                                  ? const Icon(Icons.check, color: Colors.white)
                                  : Text(optionLetter,
                                      style: const TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                            ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(choice.choiceText,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  isSelected ? FontWeight.bold : FontWeight.w500,
                              color: mainTextColor,
                              height: 1.4),
                          textAlign: TextAlign.right),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
