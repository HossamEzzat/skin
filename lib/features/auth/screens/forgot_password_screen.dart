import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/routes/no_animation_route.dart';
import 'package:skin/core/widgets/gradient_background.dart';
import 'package:skin/features/auth/presentation/widgets/email_input_tab.dart';
import 'package:skin/features/auth/screens/login_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),

                  /// Icon / Illustration placeholder
                  Container(
                    height: 10.h,
                    width: 10.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.lock_reset_rounded,
                      size: 36.sp,
                      color: theme.colorScheme.primary,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  /// Header
                  Text(
                    'Forgot your password?',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 1.5.h),

                  Text(
                    'Enter your email address and we’ll send you a secure link to reset your password.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.85,
                      ),
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  /// Email Input
                  const EmailInputTab(),

                  SizedBox(height: 3.h),

                  /// Helper text
                  Center(
                    child: Text(
                      'Didn’t receive the email?\nCheck your spam folder.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.7,
                        ),
                        height: 1.4,
                      ),
                    ),
                  ),

                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================== AppBar ==================

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        splashRadius: 24,
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: theme.colorScheme.onSurface,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            NoAnimationPageRoute(builder: (context) => const LoginScreen()),
          );
        },
      ),
    );
  }
}
