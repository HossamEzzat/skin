import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skin/core/widgets/gradient_background.dart';
import 'package:skin/features/article/domain/entities/article_entity.dart';
import 'package:skin/core/widgets/app_image.dart';
import 'package:skin/core/widgets/custom_card.dart';

class ArticleDetails extends StatelessWidget {
  final ArticleEntity article;

  const ArticleDetails({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(context, theme),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderImage(theme),
                SizedBox(height: 3.h),
                _buildTitle(theme),
                SizedBox(height: 1.5.h),
                _buildMeta(theme),
                SizedBox(height: 3.h),
                _buildSectionTitle(theme, "Description"),
                SizedBox(height: 1.h),
                _buildDescription(theme),
                SizedBox(height: 3.h),
                _buildSectionTitle(theme, "Recommended Tips / Ingredients"),
                SizedBox(height: 1.5.h),
                _buildIngredients(theme),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= AppBar =================

  PreferredSizeWidget _buildAppBar(BuildContext context, ThemeData theme) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: theme.colorScheme.onSurface,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Article Details",
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.share_outlined, color: theme.colorScheme.onSurface),
          onPressed: () {
            // TODO: Share logic
          },
        ),
      ],
    );
  }

  // ================= Header Image =================

  Widget _buildHeaderImage(ThemeData theme) {
    return AppImage(
      height: 26.h,
      width: double.infinity,
      imagePath: article.image,
      borderRadius: BorderRadius.circular(22),
    );
  }

  // ================= Title =================

  Widget _buildTitle(ThemeData theme) {
    return Text(
      article.title,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        height: 1.3,
      ),
    );
  }

  // ================= Meta =================

  Widget _buildMeta(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.person_outline,
                color: theme.colorScheme.primary,
                size: 18,
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              article.authorName,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.favorite_border,
              size: 18,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: 1.w),
            Text(
              "${article.likes} Likes",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ================= Description =================

  Widget _buildDescription(ThemeData theme) {
    return MarkdownBody(
      data: article.content.isNotEmpty ? article.content : article.description,
      styleSheet: MarkdownStyleSheet(
        p: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          height: 1.6,
        ),
        h1: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
        h2: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
        listBullet: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  // ================= Ingredients =================

  Widget _buildIngredients(ThemeData theme) {
    return Column(
      children: article.ingredients.map((ingredient) {
        return CustomCard(
          isGlass: true,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          borderRadius: BorderRadius.circular(14),
          child: Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(ingredient, style: theme.textTheme.bodyMedium),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ================= Section Title =================

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
