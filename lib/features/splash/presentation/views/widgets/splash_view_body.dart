import 'package:eye/constants.dart';
import 'package:eye/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
 import '../../../../../core/utils/assets.dart';
import 'sliding_text.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  
  @override
  void initState() {
    super.initState();

    initSlidingAnimation();

    navigateToHome();
  }

  void dispose() {
    super.dispose();

    animationController.dispose();
  }


  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AssetsData.eyeSplashJPG,scale: 4,),
          const SizedBox(height: 20),
          SlidingText(slidingAnimation: slidingAnimation),
        ],
      ),
    ); // / Reduces the image size to 1/4
  }

 void initSlidingAnimation() {
  // 1. Match slide duration to typing animation
  animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3000), // 2.5 seconds
  );

  // 2. Keep smooth slide configuration
  slidingAnimation = Tween<Offset>(
    begin: const Offset(-1, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: animationController,
    curve: Curves.easeOutCubic,
  ));

  animationController.forward();
}

void navigateToHome() {
  // 3. Total duration = typing + brief pause
  Future.delayed(const Duration(milliseconds: 3500), () { // 3.2 seconds
    if (mounted) context.go(AppRouter.rSignIn);
  });
}
}                                                     