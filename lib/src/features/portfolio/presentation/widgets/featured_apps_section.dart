import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../../core/routing/routes/portfolio.routes.dart';
import '../../domain/project.dart';
import 'scroll_fade_in.dart';

/// Featured apps section with staggered 2-column grid.
class FeaturedAppsSection extends ConsumerWidget {
  const FeaturedAppsSection({super.key, required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (projects.isEmpty) return const SizedBox.shrink();

    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 768;

    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(bottom: 24),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Featured Apps',
                        style: TextStyle(
                          color: const Color(0xFF0F172A),
                          fontSize: isMobile ? 28 : 36,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Recent production deployments built with Flutter',
                        style: TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isMobile)
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () =>
                          const AllProjectsRoute().go(context),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'VIEW ALL APPS',
                            style: TextStyle(
                              color: Color(0xFF02569B),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            size: 18,
                            color: Color(0xFF02569B),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Project grid
          if (isMobile)
            _buildMobileList()
          else
            _buildStaggeredGrid(),
          // Mobile "View All Apps" button
          if (isMobile) ...[
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () =>
                    const AllProjectsRoute().go(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'VIEW ALL APPS',
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMobileList() {
    return Column(
      children: [
        for (var i = 0; i < projects.length; i++)
          ScrollFadeIn(
            delay: Duration(milliseconds: 100 * i),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: _ProjectCard(project: projects[i]),
            ),
          ),
      ],
    );
  }

  Widget _buildStaggeredGrid() {
    final leftProjects = <Project>[];
    final rightProjects = <Project>[];
    for (var i = 0; i < projects.length; i++) {
      if (i.isEven) {
        leftProjects.add(projects[i]);
      } else {
        rightProjects.add(projects[i]);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column
        Expanded(
          child: Column(
            children: [
              for (var i = 0; i < leftProjects.length; i++)
                ScrollFadeIn(
                  delay: Duration(milliseconds: 150 * i),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: _ProjectCard(project: leftProjects[i]),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 32),
        // Right column — offset down by 64px for stagger
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 64),
            child: Column(
              children: [
                for (var i = 0; i < rightProjects.length; i++)
                  ScrollFadeIn(
                    delay: Duration(milliseconds: 150 * i + 100),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: _ProjectCard(project: rightProjects[i]),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProjectCard extends HookConsumerWidget {
  const _ProjectCard({required this.project});

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
        onTap: () =>
            ProjectDetailRoute(id: project.id).go(context),
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
                      // Image
                      if (thumbnailUrl.isNotEmpty)
                        AnimatedScale(
                          scale: isHovered.value ? 1.1 : 1.0,
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
                            errorWidget: (_, __, ___) =>
                                _placeholderImage(),
                          ),
                        )
                      else
                        _placeholderImage(),
                      // Hover overlay
                      AnimatedOpacity(
                        opacity: isHovered.value ? 0.0 : 0.05,
                        duration: const Duration(milliseconds: 300),
                        child: Container(color: Colors.black),
                      ),
                      // Category badge
                      if (project.category.isNotEmpty)
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Text(
                              project.category,
                              style: const TextStyle(
                                color: Color(0xFF0F172A),
                                fontSize: 12,
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
            // Title and description
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: TextStyle(
                          color: isHovered.value
                              ? const Color(0xFF02569B)
                              : const Color(0xFF0F172A),
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (project.description.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          project.description,
                          style: const TextStyle(
                            color: Color(0xFF475569),
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
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
                    size: 20,
                    color: isHovered.value
                        ? const Color(0xFF02569B)
                        : const Color(0xFFCBD5E1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: const Center(
        child: Icon(Icons.code, size: 48, color: Color(0xFFCBD5E1)),
      ),
    );
  }
}
