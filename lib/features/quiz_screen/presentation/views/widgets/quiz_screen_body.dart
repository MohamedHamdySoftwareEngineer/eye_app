import 'package:flutter/material.dart';
import 'package:eye/core/widgets/base_scaffold.dart';
import '../../../../../core/utils/constants.dart';

// 1. Data Models
class QuestionModel {
  final int questionID;
  final String questionText;
  final bool isMCQ;
  final List<Choice> choices;

  QuestionModel({
    required this.questionID,
    required this.questionText,
    required this.isMCQ,
    required this.choices,
  });
}

class Choice {
  final int choiceID;
  final int questionID;
  final String choiceText;
  final int rank;

  Choice({
    required this.choiceID,
    required this.questionID,
    required this.choiceText,
    required this.rank,
  });
}

// 2. Main Quiz Screen Widget
class QuizScreenBody extends StatefulWidget {
  const QuizScreenBody({super.key});

  @override
  QuizScreenBodyState createState() => QuizScreenBodyState();
}

class QuizScreenBodyState extends State<QuizScreenBody> {
  // Static demo data
  final QuestionModel currentQuestion = QuestionModel(
    questionID: 1,
    questionText: "ما هي عاصمة المملكة العربية السعودية؟",
    isMCQ: true,
    choices: [
      Choice(
        choiceID: 1,
        questionID: 1,
        choiceText: "جدة",
        rank: 3,
      ),
      Choice(
        choiceID: 2,
        questionID: 1,
        choiceText: "الرياض",
        rank: 8,
      ),
      Choice(
        choiceID: 3,
        questionID: 1,
        choiceText: "مكة المكرمة",
        rank: 2,
      ),
      Choice(
        choiceID: 4,
        questionID: 1,
        choiceText: "الدمام",
        rank: 1,
      ),
    ],
  );

  bool isLoading = false;
  int selectedChoiceId = -1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseScaffold(
      appBartTitle: 'اختبار',
      child: Container(
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

                  // Quiz details header
                  _buildQuizHeader(),

                  SizedBox(height: size.height * 0.04),

                  // Question card
                  _buildQuestionCard(),

                  SizedBox(height: size.height * 0.04),

                  // Answer options
                  _buildAnswerOptions(currentQuestion.choices),

                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Quiz header with details
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
            spreadRadius: 0,
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
              iconColor: progressIndeicatorColor,
            ),
            Container(
              height: 40,
              width: 1,
              color: mainColor.withOpacity(0.2),
            ),
            _buildQuizDetailItem(
              icon: Icons.star_outline,
              label: '100 نقطة',
              iconColor: mainColor,
            ),
            Container(
              height: 40,
              width: 1,
              color: mainColor.withOpacity(0.2),
            ),
            _buildQuizDetailItem(
              icon: Icons.fitness_center_outlined,
              label: 'صعب',
              iconColor: secondTextColor,
            ),
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
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: mainTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Question card
  Widget _buildQuestionCard() {
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
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question number badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: mainColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'السؤال ${currentQuestion.questionID}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: mainColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Question text
            Text(
              currentQuestion.questionText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: mainTextColor,
                height: 1.5,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }

  // Build answer options
  Widget _buildAnswerOptions(List<Choice> choices) {
    return Column(
      children: choices.asMap().entries.map((entry) {
        int index = entry.key;
        Choice currentChoice = entry.value;
        bool isSelected = selectedChoiceId == currentChoice.choiceID;
        String optionLetter = String.fromCharCode(65 + index);

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedChoiceId = currentChoice.choiceID;
                  isLoading = true;
                });

                // Simulate answer processing
                Future.delayed(const Duration(milliseconds: 800), () {
                  if (!mounted) return;
                  setState(() {
                    isLoading = false;
                  });

                  // Show result
                  final isCorrectAnswer = currentChoice.rank > 5;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isCorrectAnswer ? Icons.check_circle : Icons.cancel,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              isCorrectAnswer ? 'إجابة صحيحة!' : 'إجابة خاطئة!',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      backgroundColor: isCorrectAnswer
                          ? progressIndeicatorColor
                          : Colors.red.shade500,
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    ),
                  );
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
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected 
                          ? mainColor.withOpacity(0.15)
                          : mainColor.withOpacity(0.05),
                      blurRadius: isSelected ? 15 : 10,
                      spreadRadius: 0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Option indicator
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isSelected ? mainColor : mainColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: isSelected && isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Center(
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  : Text(
                                      optionLetter,
                                      style: const TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Choice text
                    Expanded(
                      child: Text(
                        currentChoice.choiceText,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: mainTextColor,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.right,
                      ),
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