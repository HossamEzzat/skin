import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ArticleItem extends StatelessWidget {
  final String title;
  final String date;
  final String duration;
  final String image;
  final VoidCallback? onTap;

  const ArticleItem({
    super.key,
    required this.title,
    required this.date,
    required this.duration,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Material(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.06),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            height: 11.h,
            padding: EdgeInsets.all(1.2.h),
            child: Row(
              children: [
                _buildImage(),
                SizedBox(width: 3.w),
                _buildContent(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= Image =================

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(image, height: 8.h, width: 18.w, fit: BoxFit.cover),
    );
  }

  // ================= Text Content =================

  Widget _buildContent(ThemeData theme) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          SizedBox(height: 0.8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                duration,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
