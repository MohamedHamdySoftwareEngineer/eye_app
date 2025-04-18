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
          // Background design - top right decoration
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: size.width * 0.6,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                ),
              ),
            ),
          ),
          
          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: FutureBuilder<QuestionModel>(
                future: futureQuestion,
                builder: (context, snapshot) {
                  // While loading show a progress indicator.
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
                      ),
                    );
                  }
                  // Handle errors by displaying an error message.
                  else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red.shade300,
                            size: 60,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
                              'Try Again',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                      
                      // Quiz header with logo
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.brown.withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Image.asset(
                              AssetsData.logo,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: size.height * 0.03),
                      
                      // Quiz details
                      _buildQuizDetails(),
                      
                      SizedBox(height: size.height * 0.04),
                      
                      // Question text
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.brown.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.brown.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            question.questionText,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.brown,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: size.height * 0.04),
                      
                      // Answer options
                      Expanded(
                        child: _buildAnswerOptions(question.choices),
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
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
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
            ),
            Container(
              height: 30,
              width: 1,
              color: Colors.brown.withOpacity(0.3),
            ),
            _buildQuizDetailItem(
              icon: Icons.star_outline,
              label: '100 نقطة',
            ),
            Container(
              height: 30,
              width: 1,
              color: Colors.brown.withOpacity(0.3),
            ),
            _buildQuizDetailItem(
              icon: Icons.fitness_center_outlined,
              label: 'صعب',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizDetailItem({required IconData icon, required String label}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.brown,
          size: 22,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.brown.shade700,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
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
                      content: Text(
                        isCorrectAnswer ? 'إجابة صحيحة!' : 'إجابة خاطئة!',
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: isCorrectAnswer ? Colors.green : Colors.red,
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.brown.withOpacity(0.2)
                      : Colors.brown.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                  border: isSelected
                      ? Border.all(color: Colors.brown, width: 2)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    isSelected && isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
                            ),
                          )
                        : isSelected
                            ? const Icon(Icons.check_circle, color: Colors.brown)
                            : Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.brown.withOpacity(0.7),
                                    width: 2,
                                  ),
                                ),
                              ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        currentChoice.choiceText,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: Colors.brown.shade800,
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