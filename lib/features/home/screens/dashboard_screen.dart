import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/data/doctors_data.dart';
import 'package:skin/core/models/doctor_model.dart';
import 'package:skin/core/routes/no_animation_route.dart';
import 'package:skin/core/widgets/app_image.dart';
import 'package:skin/core/widgets/gradient_background.dart';
import 'package:skin/core/widgets/list_icons.dart';
import 'package:skin/core/widgets/custom_card.dart';
import 'package:skin/features/article/domain/entities/article_entity.dart';
import 'package:skin/features/article/presentation/bloc/article_bloc.dart';
import 'package:skin/features/article/presentation/bloc/article_bloc_states.dart';
import 'package:skin/features/article/screens/article_details_screen.dart';
import 'package:skin/features/article/screens/article_list_screen.dart';
import 'package:skin/features/doctor/screens/doctor_details_screen.dart';
import 'package:skin/features/doctor/screens/doctor_search_screen.dart';
import 'package:skin/features/doctor/screens/find_doctor_screen.dart';
import 'package:skin/features/doctor/widgets/list_doctor1.dart';
import 'package:skin/features/prediction/screens/burn_prediction_screen.dart';
import 'package:skin/features/prediction/screens/skin_cancer_prediction_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<Doctor> _topDoctors;

  @override
  void initState() {
    super.initState();
    _randomizeDoctors();
    context.read<ArticleBloc>().add(FetchArticlesRequested());
  }

  void _randomizeDoctors() {
    final random = Random();
    final shuffled = List<Doctor>.from(doctorsList)..shuffle(random);
    _topDoctors = shuffled.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(theme),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 2.h),
                _buildSearchBar(context, theme),
                SizedBox(height: 3.h),
                _buildQuickActions(context),
                SizedBox(height: 3.h),
                _buildTopDoctors(context, theme),
                SizedBox(height: 3.h),
                _buildArticles(context, theme),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= AppBar =================

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 100,
      centerTitle: false,
      titleSpacing: 20,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Hello there, 👋",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Find your desired health solution",
                  maxLines: 2,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: theme.colorScheme.primary, width: 2),
            ),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
              child: Icon(Icons.person, color: theme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
  // ================= Search =================

  Widget _buildSearchBar(BuildContext context, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SizedBox(
        height: 6.5.h,
        child: TextField(
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            final query = value.trim();
            if (query.isNotEmpty) {
              Navigator.push(
                context,
                NoAnimationPageRoute(
                  builder: (_) => DoctorSearch(initialQuery: query),
                ),
              );
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.cardColor,
            hintText: "Search doctor...",
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  // ================= Quick Actions =================

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ListIcons(
          icon: "assets/icons/Doctor.png",
          text: "Doctor",
          onTap: () => Navigator.push(
            context,
            NoAnimationPageRoute(builder: (_) => const FindDoctor()),
          ),
        ),
        ListIcons(
          icon: "assets/icons/Pharmacy.png",
          text: "Skin Prediction",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SkinDiseaseClassifier()),
          ),
        ),
        ListIcons(
          icon: "assets/icons/Hospital.png",
          text: "Burn Prediction",
          onTap: () => Navigator.push(
            context,
            NoAnimationPageRoute(builder: (_) => const BurnPredictionScreen()),
          ),
        ),
      ],
    );
  }

  // ================= Top Doctors =================

  Widget _buildTopDoctors(BuildContext context, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          _sectionHeader(
            title: "Top Doctor",
            onSeeAll: () => Navigator.push(
              context,
              NoAnimationPageRoute(builder: (_) => const DoctorSearch()),
            ),
            theme: theme,
          ),
          SizedBox(height: 2.h),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _topDoctors.length,
              itemBuilder: (context, index) {
                final doctor = _topDoctors[index];
                return ListDoctor1(
                  doctor: doctor,
                  onTap: () => Navigator.push(
                    context,
                    NoAnimationPageRoute(
                      builder: (_) => DoctorDetails(doctor: doctor),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ================= Articles =================

  Widget _buildArticles(BuildContext context, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          _sectionHeader(
            title: "Health Articles",
            onSeeAll: () => Navigator.push(
              context,
              NoAnimationPageRoute(builder: (_) => const ArticlePage()),
            ),
            theme: theme,
          ),
          SizedBox(height: 2.h),
          BlocBuilder<ArticleBloc, ArticleState>(
            builder: (context, state) {
              if (state is ArticlesLoaded && state.articles.isNotEmpty) {
                final article = state.articles.first;
                return _articleCard(theme, article);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _articleCard(ThemeData theme, ArticleEntity article) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        NoAnimationPageRoute(builder: (_) => ArticleDetails(article: article)),
      ),
      child: CustomCard(
        isGlass: true,
        padding: const EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(14),
        child: Row(
          children: [
            AppImage(
              height: 10.h,
              width: 20.w,
              imagePath: article.image,
              borderRadius: BorderRadius.circular(10),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(article.date, style: theme.textTheme.bodySmall),
                      Text(
                        article.duration,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= Section Header =================

  Widget _sectionHeader({
    required String title,
    required VoidCallback onSeeAll,
    required ThemeData theme,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: theme.textTheme.titleLarge),
        GestureDetector(
          onTap: onSeeAll,
          child: Text(
            "See all",
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
