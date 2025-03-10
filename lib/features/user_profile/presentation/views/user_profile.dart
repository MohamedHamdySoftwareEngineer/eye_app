import 'package:eye/features/user_profile/presentation/views/widgets/user_profile_body.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UserProfileBody(),
    );
  }
}