import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/utils/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> with SingleTickerProviderStateMixin {
  // Controllers to capture user input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  // Animation controller for the login button
  late AnimationController _loginButtonController;
  bool isLoading = false;
  bool isPasswordVisible = false;
  
  @override
  void initState() {
    super.initState();
    _loginButtonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _loginButtonController.dispose();
    super.dispose();
  }

  // API integration - keeping the same functionality
  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _loginButtonController.forward();
      
      final username = emailController.text;
      final password = passwordController.text;
      const String apiUrl = "http://10.0.2.2:5236/api/users/login";
      // const String apiUrl = "http://192.168.1.8:5236/api/users/login";
      // const String apiUrl = "http://192.168.20.30:5236/api/users/login";

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
        _loginButtonController.reverse();

        if (response.statusCode == 200) {
          GoRouter.of(context).go(AppRouter.rHomeView);
        } else {
          _showErrorDialog("Login failed. Please check your credentials.");
        }
      } catch (e) {
        if (!mounted) return;
        
        setState(() {
          isLoading = false;
        });
        _loginButtonController.reverse();
        
        _showErrorDialog("Connection error. Please check your internet connection.");
        print("An error occurred: $e");
      }
    }
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
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width * 0.4,
              height: size.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(100),
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
                            AssetsData.splash,
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
                            'مرحباً بعودتك!',
                            style: Styles.brownText18.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'تسجيل الدخول للمتابعة',
                            style: TextStyle(
                              color: Colors.brown.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: size.height * 0.05),
                    
                    // Login form
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
                          
                          const SizedBox(height: 15),
                          
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
                              child: Text(
                                'نسيت كلمة المرور؟',
                                style: TextStyle(
                                  color: Colors.brown.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(height: size.height * 0.04),
                          
                          // Login Button
                          _buildLoginButton(),
                          
                          SizedBox(height: size.height * 0.03),
                          
                          // Divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.brown.withOpacity(0.3),
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'أو',
                                  style: TextStyle(
                                    color: Colors.brown.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.brown.withOpacity(0.3),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: size.height * 0.03),
                          
                          // Social login options
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildSocialLoginButton(
                                icon: Icons.facebook,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 20),
                              _buildSocialLoginButton(
                                icon: Icons.g_mobiledata_rounded,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          
                          SizedBox(height: size.height * 0.04),
                          
                          // Create account link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ليس لديك حساب؟',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  GoRouter.of(context).push(AppRouter.rSignUp);
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
          hintStyle: TextStyle(color: Colors.grey.shade500),
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
          fillColor: Colors.brown.withOpacity(0.07),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
            borderSide: BorderSide(color: Colors.red.shade300, width: 1.5),
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
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.brown.shade50),
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
  
  Widget _buildSocialLoginButton({required IconData icon, required Color color}) {
    return InkWell(
      onTap: () {
        // Handle social login
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color,
          size: 35,
        ),
      ),
    );
  }
}