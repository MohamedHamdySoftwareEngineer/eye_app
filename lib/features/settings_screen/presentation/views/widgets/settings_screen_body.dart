import 'package:eye/constants.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/widgets/base_scaffold.dart';
import 'package:eye/features/settings_screen/presentation/views/widgets/build_text_field_with_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/styles.dart';

class SettingsScreenBody extends StatefulWidget {
  const SettingsScreenBody({super.key});

  @override
  State<SettingsScreenBody> createState() => _SettingsScreenBodyState();
}

class _SettingsScreenBodyState extends State<SettingsScreenBody> {
  bool showPersonalInfo = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return BaseScaffold(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Center(
              child: Text(
            'الإعدادات',
            style: Styles.brownWithoutShadow18,
          )),
          const SizedBox(
            height: 30,
          ),
          profileSettingsText(),
          const SizedBox(
            height: 20,
          ),
          settingsProfileInfo(screenHeight),
          const SizedBox(
            height: 20,
          ),
          quizSettingsSection(),
          const SizedBox(
            height: 20,
          ),
          timePerQuestionSection(),
        ],
      ),
    ));
  }

  Widget profileSettingsText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SvgPicture.asset(
          AssetsData.invertedTriangle,
          width: 15,
          height: 15,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          'إعدادات الملف الشخصي',
          style: Styles.brownWithoutShadow11.copyWith(fontSize: 14),
        ),
      ],
    );
  }

  Row quizSettingsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SvgPicture.asset(
          AssetsData.invertedTriangle,
          width: 15,
          height: 15,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          'إعدادات الكويز',
          style: Styles.brownWithoutShadow11.copyWith(fontSize: 14),
        ),
      ],
    );
  }

  Container timePerQuestionSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            AssetsData.invertedTriangle,
            width: 15,
            height: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'الوقت لكل سؤال',
            style: Styles.brownWithoutShadow11.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Container settingsProfileInfo(double screenHeight) {
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
                buildTextFieldWithLabel(
                    label: "Username", value: "Tita", isRTL: true),
                const SizedBox(height: 15),

                // First name field
                buildTextFieldWithLabel(
                    label: "First Name", value: "طارق", isRTL: true),
                const SizedBox(height: 15),

                // Last name field
                buildTextFieldWithLabel(
                    label: "Last Name", value: "عثمان", isRTL: true),
                const SizedBox(height: 15),

                // Email field
                buildTextFieldWithLabel(
                    label: "Email", value: "test@gmail.com", isRTL: true),
                const SizedBox(height: 15),

                // Password field
                buildPasswordField(label: "Password", isRTL: true),
                const SizedBox(height: 15),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Profile picture
          Column(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.amber.shade700),
                  image: const DecorationImage(
                    image: AssetImage(AssetsData.classifierPhotoPNG),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.white,
                ),
                child: const Text("تغيير الصورة"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildPasswordField({
  required String label,
  required bool isRTL,
}) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.amber.shade700),
    ),
    child: Row(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      children: [
        const Text(
          "••••••••••••••",
          style: TextStyle(fontSize: 14),
        ),
        const Spacer(),
        const Icon(Icons.visibility_outlined, size: 18, color: Colors.black45),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.amber.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
