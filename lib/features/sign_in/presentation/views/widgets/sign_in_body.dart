// features/auth/presentation/widgets/sign_in_body.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:typewritertext/typewritertext.dart';

import '../../../../../core/utils/app_router.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/utils/styles.dart';

import '../../../../../core/services/api_service.dart';
import '../../../../../core/providers/auth_provider.dart';


/// The real form lives here, as a StatefulWidget
class SignInBody extends StatefulWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final emailController    = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible   = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthProvider>().login(
        username: emailController.text,
        password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the provider
    final auth = context.watch<AuthProvider>();

    // React once to success/error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (auth.status == AuthStatus.success) {
        GoRouter.of(context).go(AppRouter.rHomeView);
        auth.reset();
      } else if (auth.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(auth.errorMessage),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        auth.reset();
      }
    });

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // … your existing background decorations …
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
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.05),

                  // Logo…
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

                  const SizedBox(height: 24),

                  // Welcome text…
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          child: TypeWriter.text(
                            'مرحباً بعودتك!',
                            style: Styles.brownText18.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            duration: const Duration(milliseconds: 70),
                            maintainSize: true,
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            softWrap: false,
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

                  // The form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // … your _buildTextField calls …

                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: emailController,
                          hintText: 'البريد الإلكتروني',
                          prefixIcon: Icons.email_outlined,
                          validator: (v) =>
                              v!.isEmpty ? 'الرجاء إدخال البريد الإلكتروني' : null,
                        ),

                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: passwordController,
                          hintText: 'كلمة المرور',
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          validator: (v) =>
                              v!.isEmpty ? 'الرجاء إدخال كلمة المرور' : null,
                        ),

                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('نسيت كلمة المرور؟'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.04),

                        // Login Button driven by auth.status
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: auth.status == AuthStatus.loading
                                ? null
                                : _onLoginPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              elevation: 5,
                              shadowColor: Colors.brown.withOpacity(0.5),
                              splashFactory: NoSplash.splashFactory,
                            ),
                            child: auth.status == AuthStatus.loading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation(Colors.white),
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
                        ),

                        const SizedBox(height: 20),
                        // … “Create account?” link …
                      ],
                    ),
                  ),
                ],
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
                  onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                )
              : null,
          filled: true,
          fillColor: Colors.brown.withOpacity(0.15),
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
}
