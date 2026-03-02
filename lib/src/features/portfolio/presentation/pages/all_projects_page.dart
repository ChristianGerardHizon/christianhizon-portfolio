import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../../core/routing/routes/portfolio.routes.dart';
import '../../../../core/widgets/state/error_state.dart';
import '../../domain/project.dart';
import '../controllers/profile_controller.dart';
import '../controllers/projects_controller.dart';
import '../widgets/cta_banner_section.dart';
import '../widgets/portfolio_footer.dart';
import '../widgets/portfolio_header.dart';
import '../widgets/scroll_fade_in.dart';

/// Public page showing all projects with category filtering.
class AllProjectsPage extends HookConsumerWidget {
  const AllProjectsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);
    final projectsAsync = ref.watch(projectsControllerProvider);
    final selectedCategory = useState('All');
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Scaffold(
      backgroundColor: Colors.white,
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorState(
          message: 'Failed to load portfolio',
          onRetry: () => ref.invalidate(profileControllerProvider),
        ),
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('Portfolio not configured'));
          }

          final allProjects = projectsAsync.value ?? [];
          final categories = [
            'All',
            ...{...allProjects.map((p) => p.category).where((c) => c.isNotEmpty)},
          ];
          final filteredProjects = selectedCategory.value == 'All'
              ? allProjects
              : allProjects
                  .where((p) => p.category == selectedCategory.value)
                  .toList();

          final columnCount = isMobile ? 1 : (isTablet ? 2 : 3);

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 72),
                child: Column(
                  children: [
                    // Hero section
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFF8FAFC), Color(0xFFEFF6FF)],
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 24 : 40,
                        vertical: isMobile ? 48 : 64,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Column(
                            children: [
                              // Count badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF02569B)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  '${allProjects.length} Projects',
                                  style: const TextStyle(
                                    color: Color(0xFF02569B),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'All Projects',
                                style: TextStyle(
                                  color: const Color(0xFF0F172A),
                                  fontSize: isMobile ? 36 : 48,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -1,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 600),
                                child: const Text(
                                  'A collection of apps and systems built with Flutter, '
                                  'from concept to production deployment.',
                                  style: TextStyle(
                                    color: Color(0xFF475569),
                                    fontSize: 16,
                                    height: 1.6,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Filter chips + grid
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 24 : 40,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 32),
                              // Filter chips
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: categories.map((category) {
                                  final isSelected =
                                      selectedCategory.value == category;
                                  return MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () =>
                                          selectedCategory.value = category,
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? const Color(0xFF02569B)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          border: Border.all(
                                            color: isSelected
                                                ? const Color(0xFF02569B)
                                                : const Color(0xFFE2E8F0),
                                          ),
                                        ),
                                        child: Text(
                                          category,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : const Color(0xFF475569),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 40),
                              // Project grid
                              _buildProjectGrid(
                                filteredProjects,
                                columnCount,
                              ),
                              const SizedBox(height: 64),
                              // CTA
                              ScrollFadeIn(
                                child: CtaBannerSection(profile: profile),
                              ),
                              const SizedBox(height: 48),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Footer
                    PortfolioFooter(profile: profile),
                  ],
                ),
              ),
              // Sticky header
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: PortfolioHeader(
                  profile: profile,
                  onNavTap: (key) {
                    if (key == 'home') {
                      const PortfolioRoute().go(context);
                    } else if (key == 'apps') {
                      // Already on apps page
                    } else {
                      // Navigate to homepage and scroll
                      const PortfolioRoute().go(context);
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProjectGrid(List<Project> projects, int columnCount) {
    if (projects.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 64),
          child: Column(
            children: [
              Icon(Icons.folder_open, size: 48, color: Color(0xFFCBD5E1)),
              SizedBox(height: 16),
              Text(
                'No projects found',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Build rows manually
    final rows = <Widget>[];
    for (var i = 0; i < projects.length; i += columnCount) {
      final rowIndex = i ~/ columnCount;
      final rowChildren = <Widget>[];
      for (var j = 0; j < columnCount; j++) {
        if (i + j < projects.length) {
          rowChildren.add(
            Expanded(child: _ProjectGridCard(project: projects[i + j])),
          );
        } else {
          rowChildren.add(const Expanded(child: SizedBox.shrink()));
        }
        if (j < columnCount - 1) {
          rowChildren.add(const SizedBox(width: 24));
        }
      }
      rows.add(
        ScrollFadeIn(
          delay: Duration(milliseconds: 100 * rowIndex),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rowChildren,
            ),
          ),
        ),
      );
    }

    return Column(children: rows);
  }
}

class _ProjectGridCard extends HookConsumerWidget {
  const _ProjectGridCard({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHovered = useState(false);
    final baseUrl = pocketbaseUrl;
    final thumbnailUrl = project.thumbnailUrl(baseUrl);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: GestureDetector(
        onTap: () => ProjectDetailRoute(id: project.id).go(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            AspectRatio(
              aspectRatio: 4 / 3,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: isHovered.value
                          ? Colors.black.withValues(alpha: 0.12)
                          : Colors.black.withValues(alpha: 0.06),
                      blurRadius: isHovered.value ? 24 : 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (thumbnailUrl.isNotEmpty)
                        AnimatedScale(
                          scale: isHovered.value ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 500),
                          child: CachedNetworkImage(
                            imageUrl: thumbnailUrl,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Container(
                              color: const Color(0xFFF8FAFC),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                            errorWidget: (_, __, ___) => _placeholderImage(),
                          ),
                        )
                      else
                        _placeholderImage(),
                      // Category badge
                      if (project.category.isNotEmpty)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                              ),
                            ),
                            child: Text(
                              project.category,
                              style: const TextStyle(
                                color: Color(0xFF0F172A),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Title
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style: TextStyle(
                      color: isHovered.value
                          ? const Color(0xFF02569B)
                          : const Color(0xFF0F172A),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedSlide(
                  offset: isHovered.value
                      ? const Offset(0.1, -0.1)
                      : Offset.zero,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.arrow_outward,
                    size: 18,
                    color: isHovered.value
                        ? const Color(0xFF02569B)
                        : const Color(0xFFCBD5E1),
                  ),
                ),
              ],
            ),
            if (project.description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                project.description,
                style: const TextStyle(
                  color: Color(0xFF475569),
                  fontSize: 14,
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            // Tech stack pills
            if (project.techStack.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: project.techStack.take(4).map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tech,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _placeholderImage() {
    final hash = project.title.hashCode;
    final gradientColors = _placeholderGradient(hash);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _categoryIcon(project.category),
              size: 40,
              color: Colors.white.withValues(alpha: 0.9),
            ),
            const SizedBox(height: 12),
            Text(
              project.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.95),
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
            if (project.techStack.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 6,
                runSpacing: 6,
                children: project.techStack.take(3).map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tech,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static IconData _categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'mobile app':
        return Icons.phone_iphone;
      case 'web app':
        return Icons.language;
      case 'website':
        return Icons.public;
      case 'ecommerce':
        return Icons.shopping_bag;
      default:
        return Icons.code;
    }
  }

  static List<Color> _placeholderGradient(int hash) {
    const palettes = [
      [Color(0xFF0F172A), Color(0xFF1E3A5F)],
      [Color(0xFF1A1A2E), Color(0xFF16213E)],
      [Color(0xFF0D1B2A), Color(0xFF1B4965)],
      [Color(0xFF2D3436), Color(0xFF636E72)],
      [Color(0xFF141E30), Color(0xFF243B55)],
      [Color(0xFF0F2027), Color(0xFF2C5364)],
    ];
    return palettes[hash.abs() % palettes.length];
  }
}
