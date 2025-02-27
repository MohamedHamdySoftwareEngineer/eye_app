import 'package:eye/features/leaderboard/presentation/views/widgets/leaderboard_body.dart';
import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LeaderboardBody(),
    );
  }
}