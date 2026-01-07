import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatDoctorItem extends StatelessWidget {
  final String name;
  final String lastSeen;
  final String image;
  final VoidCallback? onTap;
  final bool isOnline;

  const ChatDoctorItem({
    super.key,
    required this.name,
    required this.lastSeen,
    required this.image,
    this.onTap,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Material(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(1.6.h),
            child: Row(
              children: [
                _buildAvatar(theme),
                SizedBox(width: 4.w),
                _buildInfo(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= Avatar =================

  Widget _buildAvatar(ThemeData theme) {
    return Stack(
      children: [
        CircleAvatar(radius: 3.2.h, backgroundImage: AssetImage(image)),
        if (isOnline)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 1.4.h,
              width: 1.4.h,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: theme.cardColor, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  // ================= Info =================

  Widget _buildInfo(ThemeData theme) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 0.6.h),
          Text(
            lastSeen,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
