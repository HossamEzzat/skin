import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatefulWidget {
  final String text;
  final String icon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final bool enabled;
  final String? helperText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextCapitalization textCapitalization;

  const AuthTextField({
    super.key,
    required this.text,
    required this.icon,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.textInputAction,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.helperText,
    this.maxLength,
    this.inputFormatters,
    this.suffixIcon,
    this.focusNode,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField>
    with SingleTickerProviderStateMixin {
  late bool _isObscured;
  bool _isFocused = false;
  bool _hasError = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late FocusNode _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
    _internalFocusNode = widget.focusNode ?? FocusNode();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _internalFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _internalFocusNode.hasFocus;
      if (_isFocused) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    } else {
      _internalFocusNode.removeListener(_onFocusChange);
    }
    _animationController.dispose();
    super.dispose();
  }

  Color _getBorderColor() {
    if (_hasError) return const Color(0xFFE53E3E);
    if (_isFocused) return const Color.fromARGB(255, 3, 190, 150);
    return Colors.transparent;
  }

  Color _getBackgroundColor() {
    if (!widget.enabled) return const Color(0xFFF0F0F0);
    if (_isFocused) return Colors.white;
    return const Color(0xFFF7F7F7);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isFocused
              ? [
                  BoxShadow(
                    color: const Color.fromARGB(
                      255,
                      3,
                      190,
                      150,
                    ).withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: TextFormField(
          controller: widget.controller,
          obscureText: _isObscured,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          focusNode: _internalFocusNode,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          textCapitalization: widget.textCapitalization,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: widget.enabled
                ? const Color(0xFF1A1A1A)
                : const Color(0xFF9E9E9E),
          ),
          onChanged: (value) {
            widget.onChanged?.call(value);
            // Clear error state when user starts typing
            if (_hasError && value.isNotEmpty) {
              setState(() => _hasError = false);
            }
          },
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            filled: true,
            fillColor: _getBackgroundColor(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16, right: 12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                child: Image.asset(
                  widget.icon,
                  color: _isFocused
                      ? const Color.fromARGB(255, 3, 190, 150)
                      : _hasError
                      ? const Color(0xFFE53E3E)
                      : const Color(0xFF9E9E9E),
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 52,
              minHeight: 24,
            ),
            suffixIcon: _buildSuffixIcon(),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 48,
              minHeight: 48,
            ),
            labelText: widget.text,
            labelStyle: theme.textTheme.bodyMedium?.copyWith(
              color: _isFocused
                  ? const Color.fromARGB(255, 3, 190, 150)
                  : const Color(0xFF9E9E9E),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            floatingLabelStyle: theme.textTheme.bodySmall?.copyWith(
              color: _isFocused
                  ? const Color.fromARGB(255, 3, 190, 150)
                  : const Color(0xFF9E9E9E),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            helperText: widget.helperText,
            helperStyle: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF6B6B6B),
              fontSize: 12,
            ),
            errorStyle: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFFE53E3E),
              fontSize: 12,
              height: 1.2,
            ),
            counterText: '',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: _getBorderColor(), width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _getBorderColor(), width: 1.5),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _getBorderColor(), width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFE53E3E),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFE53E3E), width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          validator: (value) {
            final error = widget.validator?.call(value);
            setState(() => _hasError = error != null);
            return error;
          },
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if (widget.obscureText) {
      return IconButton(
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: Icon(
            _isObscured
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            key: ValueKey(_isObscured),
            color: _isFocused
                ? const Color.fromARGB(255, 3, 190, 150)
                : const Color(0xFF9E9E9E),
            size: 22,
          ),
        ),
        onPressed: widget.enabled
            ? () {
                setState(() => _isObscured = !_isObscured);
                // Provide haptic feedback
                HapticFeedback.lightImpact();
              }
            : null,
        tooltip: _isObscured ? 'Show password' : 'Hide password',
        splashRadius: 24,
      );
    }

    // Clear button for non-password fields when text is present
    if (widget.controller != null &&
        widget.controller!.text.isNotEmpty &&
        _isFocused) {
      return IconButton(
        icon: const Icon(
          Icons.cancel_rounded,
          size: 20,
          color: Color(0xFF9E9E9E),
        ),
        onPressed: widget.enabled
            ? () {
                widget.controller!.clear();
                widget.onChanged?.call('');
                HapticFeedback.lightImpact();
              }
            : null,
        tooltip: 'Clear',
        splashRadius: 24,
      );
    }

    return null;
  }
}
