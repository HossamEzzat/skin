import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/widgets/custom_card.dart';
import 'package:skin/core/widgets/app_image.dart';
import 'package:skin/core/models/doctor_model.dart';

class DoctorListItem extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback? onTap;

  const DoctorListItem({super.key, required this.doctor, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: true,
      label:
          "Doctor ${doctor.name}, ${doctor.specialty}, rating ${doctor.rating}",
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        child: CustomCard(
          height: 16.h,
          width: double.infinity,
          borderRadius: BorderRadius.circular(18),
          padding: EdgeInsets.all(1.6.h),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            splashColor: theme.colorScheme.primary.withOpacity(0.08),
            highlightColor: Colors.transparent,
            child: Row(
              children: [
                _buildImage(),
                SizedBox(width: 4.w),
                _buildInfo(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= Doctor Image =================

  Widget _buildImage() {
    return Hero(
      tag: doctor.image,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: AppImage(
          imagePath: doctor.image,
          height: 12.h,
          width: 24.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ================= Doctor Info =================

  Widget _buildInfo(ThemeData theme) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doctor.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 0.6.h),
          Text(
            doctor.specialty,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 1.2.h),
          Row(
            children: [
              _buildRating(theme),
              SizedBox(width: 4.w),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
          const SizedBox(width: 4),
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
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 16,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(
          doctor.distance,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
