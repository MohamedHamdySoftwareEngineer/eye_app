import 'dart:convert';

import 'package:eye/core/widgets/base_scaffold.dart';
import 'package:eye/core/widgets/option_box.dart';
import 'package:eye/features/quiz_screen/presentation/views/widgets/quiz_box.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eye/core/utils/assets.dart';

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

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    var choicesList = json['choices'] as List<dynamic>;
    List<Choice> choices =
        choicesList.map((choice) => Choice.fromJson(choice)).toList();
    return QuestionModel(
      questionID: json['questionID'],
      questionText: json['questionText'],
      isMCQ: json['isMCQ'],
      choices: choices,
    );
  }
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

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      choiceID: json['choiceID'],
      questionID: json['questionID'],
      choiceText: json['choiceText'],
      rank: json['rank'],
    );
  }
}

// 2. Main Quiz Screen Widget
class QuizScreenBody extends StatefulWidget {
  const QuizScreenBody({super.key});

  @override
  QuizScreenBodyState createState() => QuizScreenBodyState();
}

class QuizScreenBodyState extends State<QuizScreenBody> {
  late Future<QuestionModel> futureQuestion;
  bool isLoading = false;
  int selectedChoiceId = -1;

  // Theme colors
  final Color primaryColor = const Color(0xFF8B4513); // richer brown
  final Color backgroundColor =
      const Color(0xFFF5F0EA); // warm light background
  final Color accentColor = const Color(0xFFD2B48C); // tan accent
  final Color textColor = const Color(0xFF3E2723); // dark brown text

  @override
  void initState() {
    super.initState();
    futureQuestion = fetchQuestion('18');
  }

  Future<QuestionModel> fetchQuestion(String questionId) async {
    final url = Uri.parse('http://10.0.2.2:5236/api/questions/$questionId');
    // final url = Uri.parse('http://192.168.1.8:5236/api/questions/$questionId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return QuestionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load question');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseScaffold(
      child: Stack(
        children: [
          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: FutureBuilder<QuestionModel>(
                future: futureQuestion,
                builder: (context, snapshot) {
                  // While loading show a progress indicator.
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primaryColor),
                            strokeWidth: 3,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "تحميل السؤال...",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  // Handle errors by displaying an error message.
                  else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.red.shade300,
                              size: 60,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.1),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: TextStyle(
                                color: Colors.red.shade700,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                futureQuestion = fetchQuestion('18');
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              elevation: 4,
                            ),
                            child: const Text(
                              'حاول مرة أخرى',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Extract the question data.
                  final question = snapshot.data!;
                  return Column(
                    children: [
                      SizedBox(height: size.height * 0.02),

                     

                      // Quiz details
                      _buildQuizDetails(),

                      SizedBox(height: size.height * 0.04),

                      // Question text
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 24,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.15),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(
                              color: accentColor.withOpacity(0.5),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  'السؤال ${question.questionID}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                question.questionText,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                  height: 1.6,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),

                      // Answer options
                      Expanded(
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (overscroll) {
                            overscroll.disallowIndicator();
                            return true;
                          },
                          child: _buildAnswerOptions(question.choices),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Redesigned quiz details
  Widget _buildQuizDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.12),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: accentColor.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildQuizDetailItem(
              icon: Icons.timer_outlined,
              label: '60s',
              iconColor: const Color(0xFF00796B), // teal
            ),
            Container(
              height: 36,
              width: 1,
              color: accentColor.withOpacity(0.5),
            ),
            _buildQuizDetailItem(
              icon: Icons.star_outline,
              label: '100 نقطة',
              iconColor: const Color(0xFFFFA000), // amber
            ),
            Container(
              height: 36,
              width: 1,
              color: accentColor.withOpacity(0.5),
            ),
            _buildQuizDetailItem(
              icon: Icons.fitness_center_outlined,
              label: 'صعب',
              iconColor: const Color(0xFFC62828), // red
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
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  // Build answer options from the list of choices.
  Widget _buildAnswerOptions(List<Choice> choices) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: choices.length,
      itemBuilder: (context, index) {
        final currentChoice = choices[index];
        bool isSelected = selectedChoiceId == currentChoice.choiceID;
        String optionLetter = String.fromCharCode(65 + index); // A, B, C, D...

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

                // Check the answer with a short delay to show the loading state
                Future.delayed(const Duration(milliseconds: 800), () {
                  if (!mounted) return;

                  setState(() {
                    isLoading = false;
                  });

                  // Show answer result
                  final isCorrectAnswer = currentChoice.rank > 5;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isCorrectAnswer ? Icons.check_circle : Icons.cancel,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            isCorrectAnswer ? 'إجابة صحيحة!' : 'إجابة خاطئة!',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      backgroundColor: isCorrectAnswer
                          ? Colors.green.shade600
                          : Colors.red.shade600,
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                    ),
                  );
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 22,
                ),
                decoration: BoxDecoration(
                  color:
                      isSelected ? primaryColor.withOpacity(0.1) : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isSelected
                        ? primaryColor
                        : accentColor.withOpacity(0.5),
                    width: isSelected ? 2 : 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? primaryColor.withOpacity(0.2)
                          : primaryColor.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? primaryColor
                            : accentColor.withOpacity(0.3),
                      ),
                      child: isSelected && isLoading
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Center(
                              child: isSelected
                                  ? const Icon(Icons.check,
                                      color: Colors.white, size: 22)
                                  : Text(
                                      optionLetter,
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        currentChoice.choiceText,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          color: textColor,
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
      },
    );
  }
}
