import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/routes/no_animation_route.dart';
import 'package:skin/features/auth/screens/login_signup_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/onboarding_button.dart';
import '../widgets/onboarding_widget.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late final PageController _pageController;
  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _isLastPage = index == 2);
  }

  void _onNext() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onDone() {
    Navigator.pushReplacement(
      context,
      NoAnimationPageRoute(builder: (context) => const LoginSignup()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: const [
                OnboardingPage(
                  image: "assets/images/doctor1.png",
                  title: "Consult only with a doctor\nyou trust",
                ),
                OnboardingPage(
                  image: "assets/images/doctor2.png",
                  title: "Find a lot of specialist\ndoctors in one place",
                ),
                OnboardingPage(
                  image: "assets/images/doctor3.png",
                  title: "Get connect our Online\nConsultation",
                ),
              ],
            ),

            /// Bottom Controls
            Positioned(
              left: 0,
              right: 0,
              bottom: 6.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Skip
                    GestureDetector(
                      onTap: () => _pageController.jumpToPage(2),
                      child: Text(
                        "Skip",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),

                    /// Indicator
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: SlideEffect(
                        spacing: 6,
                        radius: 4,
                        dotWidth: 14,
                        dotHeight: 6,
                        dotColor: theme.colorScheme.primary.withOpacity(0.25),
                        activeDotColor: theme.colorScheme.primary,
                      ),
                    ),

                    /// Next / Done Button
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: OnboardingButton(
                        key: ValueKey(_isLastPage),
                        text: _isLastPage ? "Done" : "Next",
                        icon: _isLastPage ? Icons.check : Icons.arrow_forward,
                        onTap: _isLastPage ? _onDone : _onNext,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
