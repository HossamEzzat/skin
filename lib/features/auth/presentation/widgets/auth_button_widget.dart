import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.label,
    required this.filled,
    required this.onTap,
  });

  final String label;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 7.h,
      width: 75.w,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: filled ? 3 : 0,
          backgroundColor: filled
              ? theme.colorScheme.primary
              : Colors.transparent,
          foregroundColor: filled
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: filled
                ? BorderSide.none
                : BorderSide(
                    color: theme.colorScheme.primary.withOpacity(0.4),
                    width: 1.5,
                  ),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
