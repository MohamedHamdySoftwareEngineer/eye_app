import 'package:eye/core/utils/app_router.dart';
import 'package:eye/core/widgets/option_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/base_scaffold.dart';
import '../../../../settings_screen/presentation/views/widgets/build_text_field_with_label.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          userImageSection(),
          const SizedBox(height: 35),
          userProfileInfo(),
          const SizedBox(height: 35),
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.rSettingsScreen);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber.shade700,
              foregroundColor: Colors.white,
            ),
            child: const Text('إعدادات الملف الشخصي'),
          ),
        ],
      ),
    ));
  }

  Container userProfileInfo() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Form fields
          Expanded(
            child: Column(
              children: [
                // Username field
                userProfileBox('@EYE team'),
                const SizedBox(height: 15),

                // First name field
                userProfileBox('2500 PTs'),
                const SizedBox(height: 15),

                // Last name field
                userProfileBox('Hero!'),
                const SizedBox(height: 15),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const Expanded(
            child: Column(
              children: [
                // Username field
                OptionBox(text: 'Username'),
                SizedBox(height: 15),

                // First name field
                OptionBox(text: 'عدد النقاط'),
                SizedBox(height: 15),

                // Last name field
                OptionBox(text: 'السيرة الذاتية'),
                SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container userProfileBox(String text) {
    return Container(
      width: 170,
      height: 60,
      decoration: BoxDecoration(
        color: secondColor,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: Styles.customtextStyle,
      ),
    );
  }

  Container userImageSection() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.amber.shade700),
        image: const DecorationImage(
          image: AssetImage(AssetsData.classifierPhotoPNG),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
