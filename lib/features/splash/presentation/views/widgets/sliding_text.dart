import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../../../../core/utils/styles.dart'; // Add this package

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: AnimatedTextKit(
            animatedTexts: [
              // Word-by-word fade animation with typing effect
              TyperAnimatedText(
                'Test. Learn. Succeed. Repeat. ',
                textStyle: Styles.splashTextStyle,
                speed: const Duration(milliseconds: 90),
              ),
            ],
            isRepeatingAnimation: false,
            totalRepeatCount: 1,
          ),
        );
      },
    );
  }
}