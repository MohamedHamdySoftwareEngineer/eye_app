import 'package:eye/features/choice_screen/presentation/views/choice_screen.dart';
import 'package:eye/features/home/presentation/views/home_view.dart';

import 'package:eye/features/quiz_screen/presentation/views/quiz_screen.dart';
import 'package:eye/features/settings_screen/presentation/views/settings_screen.dart';
import 'package:eye/features/sign_in/presentation/views/sign_in.dart';
import 'package:eye/features/splash/presentation/views/splash_view.dart';
import 'package:eye/features/user_profile/presentation/views/user_profile.dart';
import 'package:go_router/go_router.dart';
import '../../features/sign_up/presentation/views/sign_up.dart';

abstract class AppRouter {
  static const rHomeView = '/HomeView';
  static const rSignIn = '/SignIn';
  static const rSignUp = '/SignUp';
  static const rLeaderboard = '/Leaderboard';
  static const rChoiceScreen = '/ChoiceScreen';
  static const rQuizScreen = '/QuizScreen';
  static const rSettingsScreen = '/SettingsScreen';
  static const rUserProfile = '/UserProfile';

  static final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    GoRoute(path: rHomeView, builder: (context, state) => const HomeView()),
    GoRoute(path: rSignIn, builder: (context, state) => const SignIn()),
    
    GoRoute(path: rSignUp, builder: (context, state) => const SignUp()),
    
    GoRoute(
        path: rChoiceScreen, builder: (context, state) => const ChoiceScreen()),
    GoRoute(path: rQuizScreen, builder: (context, state) => const QuizScreen()),
    GoRoute(
        path: rSettingsScreen,
        builder: (context, state) => const SettingsScreen()),
    GoRoute(path: rUserProfile, builder: (context, state) => const UserProfile()),
  ]);
}
