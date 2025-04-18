import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:typewritertext/typewritertext.dart';
import '../../../../../core/utils/app_router.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/utils/styles.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody>
    with SingleTickerProviderStateMixin {
  // Controllers to capture user input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Animation controller for the login button
  // late AnimationController _loginButtonController;
  bool isLoading = false;
  bool isPasswordVisible = false;

  @override
  // void initState() {
  //   super.initState();
  //   _loginButtonController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 1500),
  //   );
  // }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // _loginButtonController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    // run all your validators and tell me if everything is good.
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      // _loginButtonController.forward();

      final username = emailController.text;
      final password = passwordController.text;
      // const String apiUrl = "http://10.0.2.2:5236/api/users/login";
      const String apiUrl = "http://192.168.1.8:5236/api/users/login";

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'username': username,
            'password': password,
          }),
        );

        if (!mounted) return;

        setState(() {
          isLoading = false;
        });
        // _loginButtonController.reverse();

        if (response.statusCode == 200) {
          GoRouter.of(context).go(AppRouter.rHomeView);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login failed. Please check your credentials."),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });
        // _loginButtonController.reverse();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Connection error. Please check your internet connection."),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );

        print("An error occurred: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.05),

                    // App logo
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
                    // Within the 'Welcome text' section
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            // Add fixed height container
                            height:
                                40, // Adjust this value based on your text size
                            child: TypeWriter.text(
                              'مرحباً بعودتك!',
                              style: Styles.brownText18.copyWith(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                              duration: const Duration(milliseconds: 70),
                              // ← keep the layout at its final size
                              maintainSize: true,
                              // ← force it to render on one line
                              maxLines: 1,
                              // ← control wrapping/overflow
                              overflow: TextOverflow.visible,
                              softWrap: false,
                              // ← optional: align text in its box
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'تسجيل الدخول للمتابعة',
                            style: TextStyle(
                              color: Colors.brown.withOpacity(0.9),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),

                    // Login form
                    // Form is a widget that groups together form fields (e.g. TextFormField) and provides an easy way to validate and save them as a single unit.
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email field
                          _buildTextField(
                            controller: emailController,
                            hintText: 'البريد الإلكتروني',
                            prefixIcon: Icons.email_outlined,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال البريد الإلكتروني';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          // Password field
                          _buildTextField(
                            controller: passwordController,
                            hintText: 'كلمة المرور',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال كلمة المرور';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 8),

                          // Forgot password
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                // Handle forgot password
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(50, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'نسيت كلمة المرور؟',
                                style: TextStyle(
                                  color: Colors.brown,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: size.height * 0.04),

                          // Login Button
                          _buildLoginButton(),

                          SizedBox(height: size.height * 0.03),

                          // Create account link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  GoRouter.of(context).push(AppRouter.rSignUp);
                                },
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                ),
                                child: const Text(
                                  'إنشاء حساب',
                                  style: TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Text(
                                'ليس لديك حساب؟',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
    String? Function(String?)? validator,
  }) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !isPasswordVisible,
        validator: validator,
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.brown),
          prefixIcon: Icon(prefixIcon, color: Colors.brown),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.brown.withOpacity(0.7),
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.brown.withOpacity(0.15),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.brown, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red.shade200, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading ? null : _signIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
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
                'تسجيل الدخول',
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
