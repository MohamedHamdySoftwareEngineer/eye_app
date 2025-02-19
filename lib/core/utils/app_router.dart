import 'package:eye/features/home/presentation/views/home_view.dart';
import 'package:eye/features/sign_in/presentation/views/sign_in.dart';
import 'package:eye/features/splash/presentation/views/splash_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const rHomeView = '/HomeView';
  static const rSignIn = '/SignIn';
  static final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    GoRoute(path: rHomeView, builder: (context, state) => const HomeView()),
    GoRoute(path: rSignIn,builder: (context,state)=> const SignIn()),
  ]);
}
