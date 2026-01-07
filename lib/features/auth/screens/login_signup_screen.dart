import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/routes/no_animation_route.dart';
import 'package:skin/core/widgets/gradient_background.dart';
import 'package:skin/features/auth/screens/login_screen.dart';
import 'package:skin/features/auth/screens/register_screen.dart';

import '../presentation/widgets/auth_button_widget.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: Column(
                    children: [
                      SizedBox(height: 3.h),

                      /// Logo
                      Hero(
                        tag: 'app_logo',
                        child: Container(
                          height: 26.h,
                          width: 26.h,
                          padding: EdgeInsets.all(3.h),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withOpacity(
                                  0.15,
                                ),
                                blurRadius: 30,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            "assets/images/skin disease (2).png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      SizedBox(height: 4.h),

                      /// Title
                      Text(
                        "Let’s get started",
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 1.2.h),

                      /// Subtitle
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          "Login to enjoy the features we’ve provided and stay healthy",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                      ),

                      SizedBox(height: 5.h),

                      /// Login Button
                      AuthButton(
                        label: "Login",
                        filled: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            NoAnimationPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 2.h),

                      /// Sign Up Button
                      AuthButton(
                        label: "Sign Up",
                        filled: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            NoAnimationPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 4.h),

                      /// Footer
                      Text(
                        "By continuing, you agree to our Terms & Privacy Policy",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
