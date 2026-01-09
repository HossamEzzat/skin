import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin/core/routes/no_animation_route.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/widgets/custom_card.dart';
import 'package:skin/core/widgets/gradient_background.dart';
import 'package:skin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:skin/features/auth/presentation/bloc/auth_event.dart';
import 'package:skin/features/auth/presentation/bloc/auth_state.dart';
import 'package:skin/features/auth/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _nameFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _isAgreed = false;
  bool _obscurePassword = true;

  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _nameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // ================= Logic =================

  void _onRegisterPressed() {
    if (!_formKey.currentState!.validate()) return;

    if (!_isAgreed) {
      _showSnack("Please agree to the terms & conditions");
      return;
    }

    context.read<AuthBloc>().add(
      RegisterRequested(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
      ),
    );
  }

  void _showSnack(String message, {bool isError = true}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(context).colorScheme.error
            : Colors.teal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          _showSnack("Account created successfully", isError: false);
          Navigator.pushReplacement(
            context,
            NoAnimationPageRoute(builder: (context) => const LoginScreen()),
          );
        } else if (state is AuthError) {
          _showSnack(state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return GradientBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _buildAppBar(context),
            body: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: CustomCard(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 4.h,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildEmailField(isLoading),
                          SizedBox(height: 2.h),
                          _buildNameField(isLoading),
                          SizedBox(height: 2.h),
                          _buildPasswordField(isLoading),
                          SizedBox(height: 2.h),
                          _buildTerms(theme, isLoading),
                          SizedBox(height: 4.h),
                          _buildRegisterButton(theme, isLoading),
                          SizedBox(height: 3.h),
                          _buildLoginRedirect(theme, isLoading),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ================= Widgets =================

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: theme.colorScheme.onSurface,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Create Account",
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildEmailField(bool isLoading) {
    return TextFormField(
      controller: _emailController,
      enabled: !isLoading,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        labelText: "Email",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Email is required";
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return "Enter a valid email";
        }
        return null;
      },
      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_nameFocus),
    );
  }

  Widget _buildNameField(bool isLoading) {
    return TextFormField(
      controller: _nameController,
      enabled: !isLoading,
      focusNode: _nameFocus,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person_outline),
        labelText: "Name",
      ),
      validator: (value) =>
          value == null || value.isEmpty ? "Name is required" : null,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(_passwordFocus),
    );
  }

  Widget _buildPasswordField(bool isLoading) {
    return TextFormField(
      controller: _passwordController,
      enabled: !isLoading,
      focusNode: _passwordFocus,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline),
        labelText: "Password",
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
      ),
      validator: (value) {
        if (value == null || value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
    );
  }

  Widget _buildTerms(ThemeData theme, bool isLoading) {
    return Row(
      children: [
        Checkbox(
          value: _isAgreed,
          onChanged: isLoading
              ? null
              : (v) => setState(() => _isAgreed = v ?? false),
        ),
        Expanded(
          child: Text(
            "I agree to the terms and conditions",
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(ThemeData theme, bool isLoading) {
    return SizedBox(
      width: double.infinity,
      height: 7.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : _onRegisterPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          elevation: isLoading ? 0 : 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Create Account",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
              ),
      ),
    );
  }

  Widget _buildLoginRedirect(ThemeData theme, bool isLoading) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account? ", style: theme.textTheme.bodyMedium),
        GestureDetector(
          onTap: isLoading
              ? null
              : () {
                  Navigator.pushReplacement(
                    context,
                    NoAnimationPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
          child: Text(
            "Sign In",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
