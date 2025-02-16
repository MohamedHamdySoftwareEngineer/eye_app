import 'package:eye/constants.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8,vertical: 10),
        child: Container(
          width: double.infinity,
          height: screenHeight * 0.08,
          padding: const EdgeInsets.symmetric( vertical: 10),
          decoration: BoxDecoration(
            color:  mainColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
               const SizedBox(width: 10,),
            SizedBox(
             
              child: Image.asset(
                AssetsData.eyePNG,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      width: 40,
                      AssetsData.homeIcon,
                      fit: BoxFit.contain,
                    ),
                    SvgPicture.asset(
                      width: 40,
                      AssetsData.trophyIcon,
                      fit: BoxFit.contain,
                      
                    ),
                  ],
                ),
              ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: SvgPicture.asset(
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
