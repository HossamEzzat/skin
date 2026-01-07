import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/routes/no_animation_route.dart';
import 'package:skin/core/widgets/app_image.dart';
import 'package:skin/features/disease/presentation/bloc/disease_bloc.dart';
import 'package:skin/features/disease/presentation/bloc/disease_event.dart';
import 'package:skin/features/disease/presentation/bloc/disease_state.dart';
import 'package:skin/features/prediction/screens/skin_cancer_prediction_screen.dart';

import 'disease_detail_screen.dart';

class DiseaseExplorerScreen extends StatefulWidget {
  const DiseaseExplorerScreen({super.key});

  @override
  State<DiseaseExplorerScreen> createState() => _DiseaseExplorerScreenState();
}

class _DiseaseExplorerScreenState extends State<DiseaseExplorerScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize FetchDiseasesRequested when the screen is first built
    context.read<DiseaseBloc>().add(FetchDiseasesRequested());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: _buildAppBar(theme),
      body: Stack(
        children: [
          Column(
            children: [
              _buildSearchBar(theme),
              Expanded(
                child: BlocBuilder<DiseaseBloc, DiseaseState>(
                  builder: (context, state) {
                    if (state is DiseaseLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is DiseasesLoaded) {
                      if (state.diseases.isEmpty) {
                        return _buildEmptyState(theme);
                      }

                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 1.h, bottom: 10.h),
                        itemCount: state.diseases.length,
                        itemBuilder: (context, index) {
                          final disease = state.diseases[index];
                          return _buildDiseaseItem(theme, disease);
                        },
                      );
                    }

                    if (state is DiseaseError) {
                      return Center(child: Text(state.message));
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
          _buildStartScanButton(theme),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Search",
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          context.read<DiseaseBloc>().add(SearchDiseasesRequested(value));
        },
        decoration: InputDecoration(
          hintText: "search",
          prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear, size: 20),
            onPressed: () {
              _searchController.clear();
              context.read<DiseaseBloc>().add(
                const SearchDiseasesRequested(""),
              );
            },
          ),
          filled: true,
          fillColor: theme.cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildDiseaseItem(ThemeData theme, dynamic disease) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          NoAnimationPageRoute(
            builder: (_) => DiseaseDetailScreen(disease: disease),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 15.w,
                height: 15.w,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: AppImage(
                    imagePath: disease.mainImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      disease.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      disease.overview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
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

  Widget _buildStartScanButton(ThemeData theme) {
    return Positioned(
      bottom: 3.h,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SkinDiseaseClassifier()),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.qr_code_scanner, color: Colors.white),
                SizedBox(width: 2.w),
                const Text(
                  "Start Scan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Text("No diseases found", style: theme.textTheme.bodyLarge),
    );
  }
}
