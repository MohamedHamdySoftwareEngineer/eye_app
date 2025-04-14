import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/utils/styles.dart';

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

      // API endpoint - replace with your actual endpoint
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
          _showSuccessDialog("Account created successfully!");
        } else {
          _showErrorDialog("Registration failed. Please try again.");
        }
      } catch (e) {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });
        _signUpButtonController.reverse();

        _showErrorDialog(
            "Connection error. Please check your internet connection.");
        print("An error occurred: $e");
      }
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              GoRouter.of(context).go(AppRouter.rHomeView);
            },
            child: const Text('OK', style: TextStyle(color: Colors.brown)),
          ),
        ],
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.brown)),
          ),
        ],
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Background design elements
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.05),

                  // App logo/brand
                  Center(
                    child: Container(
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
                  ),

                  SizedBox(height: size.height * 0.04),

                  // Welcome text
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'إنشاء حساب جديد',
                          style: Styles.brownText18.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'الرجاء إدخال بياناتك',
                          style: TextStyle(
                            color: Colors.brown.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.05),

                  // Registration form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Personal information section
                        _buildSectionTitle('المعلومات الشخصية'),
                        const SizedBox(height: 15),

                        // Name fields in a row
                        Row(
                          children: [
                            // First Name
                            Expanded(
                              child: _buildTextField(
                                controller: firstNameController,
                                hintText: 'الاسم الثاني',
                                prefixIcon: Icons.person_outline,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'مطلوب';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Second Name
                            Expanded(
                              child: _buildTextField(
                                controller: secondNameController,
                                hintText: 'الاسم الأول',
                                prefixIcon: Icons.person_outline,
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

                        const SizedBox(height: 15),

                        // Last Name
                        _buildTextField(
                          controller: lastNameController,
                          hintText: 'اسم العائلة',
                          prefixIcon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'مطلوب';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 15),

                        // Gender selection
                        _buildGenderSelection(),

                        const SizedBox(height: 25),

                        // Account information section
                        _buildSectionTitle('معلومات الحساب'),
                        const SizedBox(height: 15),

                        // Email
                        _buildTextField(
                          controller: emailController,
                          hintText: 'البريد الإلكتروني',
                          prefixIcon: Icons.email_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'مطلوب';
                            } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'بريد إلكتروني غير صالح';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 15),

                        // Username
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

                        const SizedBox(height: 15),

                        // Password
                        _buildTextField(
                          controller: passwordController,
                          hintText: 'كلمة المرور',
                          prefixIcon: Icons.lock_outline,
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

                        const SizedBox(height: 15),

                        // Confirm Password
                        _buildTextField(
                          controller: confirmPasswordController,
                          hintText: 'تأكيد كلمة المرور',
                          prefixIcon: Icons.lock_outline,
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

                        const SizedBox(height: 25),

                        // Additional information section
                        _buildSectionTitle('معلومات إضافية'),
                        const SizedBox(height: 15),

                        // Address
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

                        const SizedBox(height: 15),

                        // Notes - multiline
                        _buildTextField(
                          controller: notesController,
                          hintText: 'ملاحظات (اختياري)',
                          prefixIcon: Icons.note_outlined,
                          maxLines: 3,
                        ),

                        SizedBox(height: size.height * 0.04),

                        // Sign Up Button
                        _buildSignUpButton(),

                        SizedBox(height: size.height * 0.03),

                        // Already have account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            TextButton(
                              onPressed: () {
                                GoRouter.of(context).go(AppRouter.rSignIn);
                              },
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                              ),
                              child: const Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Text(
                              'لديك حساب بالفعل؟',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: size.height * 0.02),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.brown,
              fontSize: 16,
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
      child: TextFormField(
        controller: controller,
        obscureText: (isPassword && !isPasswordVisible) ||
            (isConfirmPassword && !isConfirmPasswordVisible),
        validator: validator,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: Icon(prefixIcon, color: Colors.brown),
          suffixIcon: isPassword || isConfirmPassword
              ? IconButton(
                  icon: Icon(
                    (isPassword && isPasswordVisible) ||
                            (isConfirmPassword && isConfirmPasswordVisible)
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.brown.withOpacity(0.7),
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
          fillColor: Colors.brown.withOpacity(0.07),
          contentPadding: EdgeInsets.symmetric(
              vertical: maxLines > 1 ? 16 : 0, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.brown, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red.shade300, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.brown.withOpacity(0.07),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.person_outlined,
              color: Colors.brown,
            ),
            const SizedBox(width: 10),
            const Text(
              'الجنس:',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Row(
                children: [
                  // Male option
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('ذكر'),
                      value: 'male',
                      groupValue: selectedGender,
                      activeColor: Colors.brown,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                  ),
                  // Female option
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('أنثى'),
                      value: 'female',
                      groupValue: selectedGender,
                      activeColor: Colors.brown,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading ? null : _signUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          shadowColor: Colors.brown.withOpacity(0.5),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.brown.shade50),
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
}
