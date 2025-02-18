import 'package:eye/constants.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ClassifierItem extends StatelessWidget {
  const ClassifierItem(
      {super.key,
      required this.xAxiz,
      required this.yAxiz,
      required this.imagePath, required this.name, required this.points});

  final double xAxiz;
  final double yAxiz;
  final String imagePath;
  final String name;
  final int points;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:5),
      child: Align(
          alignment: Alignment(xAxiz, yAxiz),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 200,
                height: 35,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: borderColor, width: 1),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: shadowMainColor,
                      offset: Offset(-3, 9),
                      spreadRadius: -3,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    classifierNameText(),
                    classifierPointsText(),
                  ],
                ),
              ),
              Positioned(
                top: -10,
                left: -10,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: shadowMainColor,
                        offset: Offset(-3, 3),
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Padding classifierPointsText() {
    return  Padding(
      padding: const EdgeInsets.only(right: 1.0),
      child: Text(
        "$points PTS",
        style: Styles.classifierTextStyle,
      ),
    );
  }

  Padding classifierNameText() {
    return  Padding(
      padding: const EdgeInsets.only(left: 22),
      child: Text(
        name,
        style: Styles.classifierTextStyle,
      ),
    );
  }
}
