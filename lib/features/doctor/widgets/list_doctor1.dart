import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/widgets/custom_card.dart';
import 'package:skin/core/widgets/app_image.dart';
import 'package:skin/core/models/doctor_model.dart';

class ListDoctor1 extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback? onTap;

  const ListDoctor1({super.key, required this.doctor, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: CustomCard(
        width: 42.w,
        borderRadius: BorderRadius.circular(16),
        padding: EdgeInsets.symmetric(vertical: 1.8.h),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Column(
              children: [
                _buildAvatar(),
                SizedBox(height: 1.2.h),
                _buildInfo(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= Doctor Avatar =================

  Widget _buildAvatar() {
    return Container(
      height: 8.h,
      width: 8.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade200,
      ),
      child: AppImage(
        imagePath: doctor.image,
        borderRadius: BorderRadius.circular(4.h),
        fit: BoxFit.cover,
      ),
    );
  }

  // ================= Doctor Info =================

  Widget _buildInfo(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doctor.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 0.4.h),
          Text(
            doctor.specialty,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 1.2.h),
          Row(
            children: [
              _buildRating(theme),
              SizedBox(width: 2.w),
              _buildDistance(theme),
            ],
          ),
        ],
      ),
    );
  }

  // ================= Rating =================

  Widget _buildRating(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, size: 12, color: Colors.amber),
          const SizedBox(width: 3),
          Text(
            doctor.rating,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  // ================= Distance =================

  Widget _buildDistance(ThemeData theme) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 12,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Text(
              doctor.distance,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
