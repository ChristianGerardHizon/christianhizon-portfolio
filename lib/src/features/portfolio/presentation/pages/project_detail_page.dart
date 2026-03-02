import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../../core/routing/routes/portfolio.routes.dart';
import '../../../../core/widgets/state/error_state.dart';
import '../controllers/profile_controller.dart';
import '../controllers/projects_controller.dart';
import '../widgets/cta_banner_section.dart';
import '../widgets/portfolio_footer.dart';
import '../widgets/portfolio_header.dart';

/// Public page showing a single project's case study details.
class ProjectDetailPage extends HookConsumerWidget {
  const ProjectDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);
    final projectAsync = ref.watch(projectByIdProvider(id));
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 768;

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

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 72),
                child: projectAsync.when(
                  loading: () => const SizedBox(
                    height: 400,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, _) => ErrorState(
                    message: 'Failed to load project',
                    onRetry: () => ref.invalidate(projectByIdProvider(id)),
                  ),
                  data: (project) {
                    if (project == null) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(64),
                          child: Column(
                            children: [
                              const Icon(Icons.error_outline,
                                  size: 48, color: Color(0xFFCBD5E1)),
                              const SizedBox(height: 16),
                              const Text(
                                'Project not found',
                                style: TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 24),
                              TextButton.icon(
                                onPressed: () =>
                                    const AllProjectsRoute().go(context),
                                icon: const Icon(Icons.arrow_back),
                                label: const Text('Back to Projects'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final baseUrl = pocketbaseUrl;
                    final thumbnailUrl = project.thumbnailUrl(baseUrl);
                    final galleryUrls = project.galleryUrls(baseUrl);

                    return Column(
                      children: [
                        // Back link + Hero
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
                                  const SizedBox(height: 24),
                                  // Back link
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () => const AllProjectsRoute()
                                          .go(context),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.arrow_back,
                                              size: 18,
                                              color: Color(0xFF475569)),
                                          SizedBox(width: 8),
                                          Text(
                                            'Back to Projects',
                                            style: TextStyle(
                                              color: Color(0xFF475569),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  // Hero banner
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(
                                        isMobile ? 24 : 48),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF02569B),
                                          Color(0xFF01437A),
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Category badge
                                        if (project.category.isNotEmpty)
                                          Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withValues(alpha: 0.2),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            child: Text(
                                              project.category,
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withValues(alpha: 0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        if (project.category.isNotEmpty)
                                          const SizedBox(height: 16),
                                        // Title
                                        Text(
                                          project.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: isMobile ? 28 : 40,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: -0.5,
                                            height: 1.1,
                                          ),
                                        ),
                                        if (project.description.isNotEmpty) ...[
                                          const SizedBox(height: 12),
                                          Text(
                                            project.description,
                                            style: TextStyle(
                                              color: Colors.white
                                                  .withValues(alpha: 0.85),
                                              fontSize: 16,
                                              height: 1.6,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                  // Main content + sidebar
                                  if (isMobile)
                                    Column(
                                      children: [
                                        _buildMainContent(
                                          project,
                                          thumbnailUrl,
                                          galleryUrls,
                                          isMobile,
                                        ),
                                        const SizedBox(height: 32),
                                        _buildSidebar(project),
                                      ],
                                    )
                                  else
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: _buildMainContent(
                                            project,
                                            thumbnailUrl,
                                            galleryUrls,
                                            isMobile,
                                          ),
                                        ),
                                        const SizedBox(width: 40),
                                        Expanded(
                                          flex: 1,
                                          child: _buildSidebar(project),
                                        ),
                                      ],
                                    ),
                                  const SizedBox(height: 64),
                                  // CTA
                                  CtaBannerSection(profile: profile),
                                  const SizedBox(height: 48),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Footer
                        PortfolioFooter(profile: profile),
                      ],
                    );
                  },
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
                    const PortfolioRoute().go(context);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMainContent(
    project,
    String thumbnailUrl,
    List<String> galleryUrls,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project thumbnail
        if (thumbnailUrl.isNotEmpty) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: thumbnailUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: const Color(0xFFF8FAFC),
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: const Color(0xFFF8FAFC),
                  child: const Center(
                    child:
                        Icon(Icons.code, size: 48, color: Color(0xFFCBD5E1)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
        // About This Project
        if (project.longDescription.isNotEmpty) ...[
          const Text(
            'About This Project',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            project.longDescription,
            style: const TextStyle(
              color: Color(0xFF475569),
              fontSize: 15,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 40),
        ],
        // Tech Stack
        if (project.techStack.isNotEmpty) ...[
          const Text(
            'Tech Stack',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.techStack.map<Widget>((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  tech,
                  style: const TextStyle(
                    color: Color(0xFF334155),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 40),
        ],
        // Gallery
        if (galleryUrls.isNotEmpty) ...[
          const Text(
            'Gallery',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _buildGalleryGrid(galleryUrls, isMobile),
        ],
      ],
    );
  }

  Widget _buildGalleryGrid(List<String> galleryUrls, bool isMobile) {
    final columnCount = isMobile ? 1 : 2;
    final rows = <Widget>[];

    for (var i = 0; i < galleryUrls.length; i += columnCount) {
      final rowChildren = <Widget>[];
      for (var j = 0; j < columnCount; j++) {
        if (i + j < galleryUrls.length) {
          rowChildren.add(
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: CachedNetworkImage(
                    imageUrl: galleryUrls[i + j],
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: const Color(0xFFF8FAFC),
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: const Color(0xFFF8FAFC),
                      child: const Center(
                        child: Icon(Icons.image,
                            size: 32, color: Color(0xFFCBD5E1)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          rowChildren.add(const Expanded(child: SizedBox.shrink()));
        }
        if (j < columnCount - 1) {
          rowChildren.add(const SizedBox(width: 16));
        }
      }
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(children: rowChildren),
        ),
      );
    }

    return Column(children: rows);
  }

  Widget _buildSidebar(project) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Project Details',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          // Info rows
          if (project.client.isNotEmpty)
            _infoRow('Client', project.client),
          if (project.role.isNotEmpty)
            _infoRow('Role', project.role),
          if (project.timeline.isNotEmpty)
            _infoRow('Timeline', project.timeline),
          if (project.category.isNotEmpty)
            _infoRow('Category', project.category),
          const SizedBox(height: 24),
          // Action buttons
          if (project.projectUrl.isNotEmpty)
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _launchUrl(project.projectUrl),
                icon: const Icon(Icons.open_in_new, size: 18),
                label: const Text('View Live Project'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF02569B),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          if (project.projectUrl.isNotEmpty && project.sourceUrl.isNotEmpty)
            const SizedBox(height: 12),
          if (project.sourceUrl.isNotEmpty)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _launchUrl(project.sourceUrl),
                icon: const Icon(Icons.code, size: 18),
                label: const Text('View Source Code'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0F172A),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
