import 'dart:math';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/routes/no_animation_route.dart';
import 'package:skin/core/widgets/app_image.dart';
import 'package:skin/core/widgets/custom_card.dart';
import 'package:skin/core/widgets/gradient_background.dart';
import 'package:skin/core/models/doctor_model.dart';
import 'package:skin/core/data/doctors_data.dart';
import 'package:skin/features/doctor/screens/doctor_details_screen.dart';
import 'package:skin/features/doctor/screens/doctor_search_screen.dart';
import 'package:skin/features/doctor/widgets/doctor_list_item.dart';

class FindDoctor extends StatefulWidget {
  const FindDoctor({super.key});

  @override
  State<FindDoctor> createState() => _FindDoctorState();
}

class _FindDoctorState extends State<FindDoctor> {
  late Doctor _recommendedDoctor;
  late List<Doctor> _recentDoctors;

  @override
  void initState() {
    super.initState();
    _randomizeDoctors();
  }

  void _randomizeDoctors() {
    final random = Random();
    // Pick one random doctor for recommendation
    _recommendedDoctor = doctorsList[random.nextInt(doctorsList.length)];

    // Pick 3-5 random doctors for recent, ensuring they are different if possible
    final shuffled = List<Doctor>.from(doctorsList)..shuffle(random);
    _recentDoctors = shuffled.take(3 + random.nextInt(3)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 120,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("Find Doctor", style: theme.textTheme.headlineSmall),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),

              /// 🔍 Search
              _buildSearch(context, theme),

              SizedBox(height: 3.h),

              /// ⭐ Recommended
              _buildSectionTitle(theme, "Recommended Doctors"),
              _buildDoctorItem(context, _recommendedDoctor),

              SizedBox(height: 3.h),

              /// 🕘 Recent
              _buildSectionTitle(theme, "Your Recent Doctors"),
              SizedBox(height: 1.5.h),
              _buildRecentDoctors(_recentDoctors),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }

  // ================= Search =================

  Widget _buildSearch(BuildContext context, ThemeData theme) {
    return Center(
      child: CustomCard(
        width: 90.w,
        height: 6.5.h,
        borderRadius: BorderRadius.circular(14),
        child: TextField(
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              Navigator.push(
                context,
                NoAnimationPageRoute(
                  builder: (_) => DoctorSearch(initialQuery: value.trim()),
                ),
              );
            }
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
            hintText: "Search ...",
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }

  // ================= Section Title =================

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ================= Doctor Item =================

  Widget _buildDoctorItem(BuildContext context, Doctor doctor) {
    return DoctorListItem(
      doctor: doctor,
      onTap: () {
        Navigator.push(
          context,
          NoAnimationPageRoute(builder: (_) => DoctorDetails(doctor: doctor)),
        );
      },
    );
  }

  // ================= Recent Doctors =================

  Widget _buildRecentDoctors(List<Doctor> recentDoctors) {
    return SizedBox(
      height: 16.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: recentDoctors.length,
        itemBuilder: (context, index) {
          final doctor = recentDoctors[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                NoAnimationPageRoute(
                  builder: (_) => DoctorDetails(doctor: doctor),
                ),
              );
            },
            child: _RecentDoctor(
              image: doctor.image,
              name: doctor.name
                  .split(' ')
                  .last, // Use last name/first name part
            ),
          );
        },
      ),
    );
  }
}

// ================= Recent Doctor Widget =================

class _RecentDoctor extends StatelessWidget {
  final String image;
  final String name;

  const _RecentDoctor({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.4),
                width: 2,
              ),
            ),
            child: AppImage(
              imagePath: image,
              borderRadius: BorderRadius.circular(5.h),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
