import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/widgets/custom_card.dart';

class ListIcons extends StatelessWidget {
  const ListIcons({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  final String icon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(2.w),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 🔑 مهم
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: CustomCard(
              height: 8.h,
              width: 18.w,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: EdgeInsets.all(2.w),
                child: Image.asset(icon, fit: BoxFit.contain),
              ),
            ),
          ),
          SizedBox(height: 0.6.h), // ⬅ تقليل بسيط
          SizedBox(
            width: 18.w, // ⬅ نفس عرض الكارت
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
