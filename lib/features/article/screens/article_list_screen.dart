import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/routes/no_animation_route.dart';
import 'package:skin/core/widgets/app_image.dart';
import 'package:skin/core/widgets/custom_card.dart';
import 'package:skin/core/widgets/gradient_background.dart';
import 'package:skin/features/article/domain/entities/article_entity.dart';
import 'package:skin/features/article/presentation/bloc/article_bloc.dart';
import 'package:skin/features/article/presentation/bloc/article_bloc_states.dart';
import 'package:skin/features/article/screens/article_details_screen.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ArticleBloc>().add(FetchArticlesRequested());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(theme),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            _buildSearchBar(theme),
            SizedBox(height: 2.5.h),
            _buildSectionTitle(theme, "Popular Articles"),
            SizedBox(height: 1.5.h),
            Expanded(child: _buildArticlesList()),
          ],
        ),
      ),
    );
  }

  // ================= AppBar =================

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 70,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: theme.colorScheme.onSurface,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Articles",
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ================= Search =================

  Widget _buildSearchBar(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: CustomCard(
        height: 6.8.h,
        borderRadius: BorderRadius.circular(30),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            context.read<ArticleBloc>().add(SearchArticlesRequested(value));
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: "Search articles...",
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () {
                      _searchController.clear();
                      context.read<ArticleBloc>().add(
                        const SearchArticlesRequested(""),
                      );
                      setState(() {});
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }

  // ================= Section Title =================

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ================= Articles List =================

  Widget _buildArticlesList() {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state is ArticleLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ArticleError) {
          return Center(child: Text(state.message));
        }

        if (state is ArticlesLoaded) {
          if (state.articles.isEmpty) {
            return const Center(child: Text("No articles found"));
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            physics: const BouncingScrollPhysics(),
            itemCount: state.articles.length,
            separatorBuilder: (_, __) => SizedBox(height: 2.h),
            itemBuilder: (_, index) {
              return _ArticleCard(article: state.articles[index]);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

// ===============================================================
// ======================= Article Card ===========================
// ===============================================================

class _ArticleCard extends StatelessWidget {
  final ArticleEntity article;

  const _ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomCard(
      borderRadius: BorderRadius.circular(18),
      padding: const EdgeInsets.all(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            NoAnimationPageRoute(
              builder: (_) => ArticleDetails(article: article),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            SizedBox(height: 1.2.h),
            Text(
              article.category.isNotEmpty ? article.category : "Health",
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 0.6.h),
            Text(
              article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(article.date.isNotEmpty ? article.date : ""),
                Text(
                  article.duration.isNotEmpty ? article.duration : "",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (article.image.isEmpty) {
      return Container(
        height: 16.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.image_not_supported),
      );
    }

    return AppImage(
      height: 16.h,
      width: double.infinity,
      imagePath: article.image,
      borderRadius: BorderRadius.circular(14),
    );
  }
}
