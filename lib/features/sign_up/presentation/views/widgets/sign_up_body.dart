import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:typewritertext/typewritertext.dart';
import '../../../../../core/utils/app_router.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/utils/styles.dart';
import '../../../../../core/utils/constants.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody>
    with SingleTickerProviderStateMixin {
  // Form key and controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // States
  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  String selectedGender = 'male'; // Default gender

  // Animation controller
  late AnimationController _signUpButtonController;

  @override
  void initState() {
    super.initState();
    _signUpButtonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    addressController.dispose();
    notesController.dispose();
    _signUpButtonController.dispose();
    super.dispose();
  }

  // Sign up API function
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _signUpButtonController.forward();

      const String apiUrl = "http://10.0.2.2:5236/api/users/register";

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'firstName': firstNameController.text,
            'secondName': secondNameController.text,
            'lastName': lastNameController.text,
            'email': emailController.text,
            'username': usernameController.text,
            'password': passwordController.text,
            'address': addressController.text,
            'gender': selectedGender,
            'notes': notesController.text,
          }),
        );

        if (!mounted) return;

        setState(() {
          isLoading = false;
        });
        _signUpButtonController.reverse();

        if (response.statusCode == 200 || response.statusCode == 201) {
          _showSuccessDialog("تم إنشاء الحساب بنجاح!");
        } else {
          _showErrorDialog("فشل في التسجيل. يرجى المحاولة مرة أخرى.");
        }
      } catch (e) {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });
        _signUpButtonController.reverse();

        _showErrorDialog(
            "خطأ في الاتصال. يرجى التحقق من اتصال الإنترنت.");
        print("An error occurred: $e");
      }
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'نجح',
          style: TextStyle(
            color: mainTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(color: secondTextColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              AppRouter.toQuizScreen(context);
            },
            child: const Text(
              'موافق',
              style: TextStyle(color: mainColor),
            ),
          ),
        ],
        backgroundColor: backgroundBoxesColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'خطأ',
          style: TextStyle(
            color: wrongAnswerColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(color: secondTextColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'موافق',
              style: TextStyle(color: wrongAnswerColor),
            ),
          ),
        ],
        backgroundColor: backgroundBoxesColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: backgroundColor,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.06),
                // Logo and Welcome Section
                _buildWelcomeSection(),
                SizedBox(height: size.height * 0.05),
                // Sign Up Form Card
                _buildSignUpCard(size),
                SizedBox(height: size.height * 0.04),
                // Sign In Link
                _buildSignInSection(),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      children: [
        // Logo with gradient background
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                mainColor.withOpacity(0.8),
                progressIndeicatorColor.withOpacity(0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: mainColor.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: backgroundBoxesColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  AssetsData.logo,
                  width: 60,
                  height: 60,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Welcome Text with RTL
        Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              SizedBox(
                height: 45,
                child: TypeWriter.text(
                  'حساب جديد!',
                  style: const TextStyle(
                    color: mainTextColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  duration: const Duration(milliseconds: 70),
                  maintainSize: true,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  softWrap: false,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'الرجاء إدخال بياناتك',
                style: TextStyle(
                  color: secondTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpCard(Size size) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: backgroundBoxesColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: mainColor.withOpacity(0.1),
            blurRadius: 30,
            spreadRadius: 0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Personal Information Section
            _buildSectionTitle('المعلومات الشخصية'),
            const SizedBox(height: 20),
            
            // Name fields in a row
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: firstNameController,
                    hintText: 'الاسم الثاني',
                    prefixIcon: Icons.person_outline_rounded,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'مطلوب';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    controller: secondNameController,
                    hintText: 'الاسم الأول',
                    prefixIcon: Icons.person_outline_rounded,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'مطلوب';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            _buildTextField(
              controller: lastNameController,
              hintText: 'اسم العائلة',
              prefixIcon: Icons.person_outline_rounded,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'مطلوب';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Gender selection
            _buildGenderSelection(),
            
            const SizedBox(height: 30),
            
            // Account Information Section
            _buildSectionTitle('معلومات الحساب'),
            const SizedBox(height: 20),
            
            _buildTextField(
              controller: emailController,
              hintText: 'البريد الإلكتروني',
              prefixIcon: Icons.email_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'مطلوب';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'بريد إلكتروني غير صالح';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            _buildTextField(
              controller: usernameController,
              hintText: 'اسم المستخدم',
              prefixIcon: Icons.account_circle_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'مطلوب';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            _buildTextField(
              controller: passwordController,
              hintText: 'كلمة المرور',
              prefixIcon: Icons.lock_outline_rounded,
              isPassword: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'مطلوب';
                } else if (value.length < 6) {
                  return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            _buildTextField(
              controller: confirmPasswordController,
              hintText: 'تأكيد كلمة المرور',
              prefixIcon: Icons.lock_outline_rounded,
              isPassword: true,
              isConfirmPassword: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'مطلوب';
                } else if (value != passwordController.text) {
                  return 'كلمات المرور غير متطابقة';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 30),
            
            // Additional Information Section
            _buildSectionTitle('معلومات إضافية'),
            const SizedBox(height: 20),
            
            _buildTextField(
              controller: addressController,
              hintText: 'العنوان',
              prefixIcon: Icons.location_on_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'مطلوب';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            _buildTextField(
              controller: notesController,
              hintText: 'ملاحظات (اختياري)',
              prefixIcon: Icons.note_outlined,
              maxLines: 3,
            ),
            
            const SizedBox(height: 40),
            
            _buildSignUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  mainColor,
                  progressIndeicatorColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: mainTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool isPassword = false,
    bool isConfirmPassword = false,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: mainColor.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          obscureText: (isPassword && !isPasswordVisible) ||
              (isConfirmPassword && !isConfirmPasswordVisible),
          validator: validator,
          maxLines: maxLines,
          style: const TextStyle(
            color: mainTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: secondTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: mainColor.withOpacity(0.7),
              size: 22,
            ),
            suffixIcon: isPassword || isConfirmPassword
                ? IconButton(
                    icon: Icon(
                      (isPassword && isPasswordVisible) ||
                              (isConfirmPassword && isConfirmPasswordVisible)
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: secondTextColor,
                      size: 22,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isPassword) {
                          isPasswordVisible = !isPasswordVisible;
                        } else if (isConfirmPassword) {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        }
                      });
                    },
                  )
                : null,
            filled: true,
            fillColor: backgroundColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: maxLines > 1 ? 20 : 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: mainColor.withOpacity(0.1),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: mainColor.withOpacity(0.1),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: mainColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: wrongAnswerColor,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: wrongAnswerColor,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: mainColor.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: mainColor.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person_outline_rounded,
                  color: mainColor.withOpacity(0.7),
                  size: 22,
                ),
                const SizedBox(width: 12),
                const Text(
                  'الجنس',
                  style: TextStyle(
                    color: mainTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedGender == 'male' 
                          ? mainColor.withOpacity(0.1) 
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selectedGender == 'male' 
                            ? mainColor 
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: RadioListTile<String>(
                      title: const Text(
                        'ذكر',
                        style: TextStyle(
                          color: mainTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: 'male',
                      groupValue: selectedGender,
                      activeColor: mainColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedGender == 'female' 
                          ? mainColor.withOpacity(0.1) 
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selectedGender == 'female' 
                            ? mainColor 
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: RadioListTile<String>(
                      title: const Text(
                        'أنثى',
                        style: TextStyle(
                          color: mainTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: 'female',
                      groupValue: selectedGender,
                      activeColor: mainColor,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: mainColor.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : _signUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: mainColor,
          foregroundColor: backgroundBoxesColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ).copyWith(
          splashFactory: NoSplash.splashFactory,
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    backgroundBoxesColor,
                  ),
                ),
              )
            : const Text(
                'إنشاء حساب',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildSignInSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              AppRouter.toSignIn(context);
            },
            child: const Text(
              'تسجيل الدخول',
              style: TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const Text(
            'لديك حساب بالفعل؟ ',
            style: TextStyle(
              color: secondTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}