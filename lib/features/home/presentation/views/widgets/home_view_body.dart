import 'package:eye/core/utils/assets.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomAppBar(),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Container(
          width: double.infinity,
          height: screenHeight * 0.08,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xffD3CCB8),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: (){},
              icon: Image.asset(
                AssetsData.eyeSplashIcon,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Image.asset(
                      AssetsData.homeIcon,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 5,),
                    Image.asset(
                      AssetsData.trophyIcon,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: (){},
              icon: Image.asset(
                AssetsData.userIcon,
                fit: BoxFit.contain,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
