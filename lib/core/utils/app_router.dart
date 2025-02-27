import 'package:eye/features/home/presentation/views/home_view.dart';
import 'package:eye/features/leaderboard/presentation/views/leaderboard.dart';
import 'package:eye/features/sign_in/presentation/views/sign_in.dart';
import 'package:eye/features/sign_up/presentation/views/widgets/sign_up_body.dart';
import 'package:eye/features/splash/presentation/views/splash_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/sign_up/presentation/views/sign_up.dart';

abstract class AppRouter {
  static const rHomeView = '/HomeView';
  static const rSignIn = '/SignIn';
  static const rSignUp = '/SignUp';
  static const rLeaderboard = '/Leaderboard';
  static final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    GoRoute(path: rHomeView, builder: (context, state) => const HomeView()),
    GoRoute(path: rSignIn, builder: (context, state) => const SignIn()),
    GoRoute(path: rSignUp, builder: (context, state) => const SignUp()),
    GoRoute(path: rLeaderboard, builder: (context,state)=> const Leaderboard()),
  ]);
}
