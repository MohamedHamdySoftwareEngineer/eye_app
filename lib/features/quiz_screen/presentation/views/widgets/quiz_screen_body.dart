import 'dart:convert';

import 'package:eye/core/widgets/base_scaffold.dart';
import 'package:eye/core/widgets/option_box.dart';
import 'package:eye/features/quiz_screen/presentation/views/widgets/quiz_box.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
   
    futureQuestion = fetchQuestion('18');
  }

  Future<QuestionModel> fetchQuestion(String questionId) async {
    // final url = Uri.parse('http://10.0.2.2:5236/api/questions/$questionId');
    final url = Uri.parse('http://192.168.1.8:5236/api/questions/$questionId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return QuestionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load question');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder<QuestionModel>(
          future: futureQuestion,
          builder: (context, snapshot) {
            // While loading show a progress indicator.
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // Handle errors by displaying an error message.
            else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            // Extract the question data.
            final question = snapshot.data!;
            return Column(
              children: [
                quizDetails(),
                const SizedBox(
                  height: 40,
                ),
                // Display the question text using QuizBox widget.
                QuizBox(
                  text: question.questionText,
                  radius: 10,
                  percOfWidth: 0.85,
                  minHeight: 70,
                  maxHeight: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Display answer options dynamically.
                answerOptions(question.choices),
              ],
            );
          },
        ),
      ),
    );
  }

  // Static quiz details (adjust if needed).
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

  // Build answer options from the list of choices.
  Widget answerOptions(List<Choice> choices) {
    return Expanded(
      child: ListView.builder(
        // For a fixed number of choices; you can adjust the layout if needed.
        itemCount: choices.length,
        itemBuilder: (context, index) {
          final currentChoice = choices[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell(
              onTap: () {
                // Check the answer based on the choice's rank or a specific flag
                // (For demonstration here, we assume rank determines the answer correctness.)
                final isCorrectAnswer = currentChoice.rank > 5;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isCorrectAnswer ? 'right answer!' : 'wrong answer!',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: OptionBox(
                text: currentChoice.choiceText,
                percOfWidth: 0.7,
              ),
            ),
          );
        },
      ),
    );
  }
}
