import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/styles.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void navigateToChoice() {
      // Directly navigate to quiz screen
      GoRouter.of(context).go(AppRouter.rChoiceScreen);
    }

    return Stack(
      children: [
        // Background design
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.05),

                  // App logo
                  Container(
                    width: 100,
                    height: 100,
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
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.08),

                  // Quiz app title
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      'اختبر معلوماتك!',
                      style: Styles.brownText18.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

                  // Description text
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      'تحدى نفسك واختبر معلوماتك مع مجموعة متنوعة من الأسئلة',
                      style: TextStyle(
                        color: Colors.brown.withOpacity(0.9),
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: size.height * 0.2),

                  // Simple button without touch ripple
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: navigateToChoice,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                        shadowColor: Colors.brown.withOpacity(0.5),
                      ).copyWith(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ابدأ الاختبار',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
