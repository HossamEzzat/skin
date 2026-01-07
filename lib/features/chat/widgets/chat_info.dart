import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const ChatInfo({
    super.key,
    this.title = "Consultation Started",
    this.subtitle = "You can now consult your problem with the doctor",
    this.icon = Icons.info_outline,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Center(
        child: Container(
          width: 90.w,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.6.h),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.25),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary, size: 22),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 0.4.h),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
