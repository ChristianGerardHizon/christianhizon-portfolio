import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../../core/routing/routes/portfolio.routes.dart';
import '../../../../core/widgets/state/error_state.dart';
import '../controllers/profile_controller.dart';
import '../../domain/project.dart';
import '../controllers/projects_controller.dart';
import '../widgets/cta_banner_section.dart';
import '../widgets/portfolio_footer.dart';
import '../widgets/portfolio_header.dart';
import '../widgets/scroll_fade_in.dart';

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
                                  ScrollFadeIn(
                                    child: isMobile
                                        ? Column(
                                            children: [
                                              _buildMainContent(
                                                project,
                                                thumbnailUrl,
                                                galleryUrls,
                                                isMobile,
                                                context,
                                              ),
                                              const SizedBox(height: 32),
                                              _buildSidebar(project),
                                            ],
                                          )
                                        : Row(
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
                                                  context,
                                                ),
                                              ),
                                              const SizedBox(width: 40),
                                              Expanded(
                                                flex: 1,
                                                child:
                                                    _buildSidebar(project),
                                              ),
                                            ],
                                          ),
                                  ),
                                  const SizedBox(height: 48),
                                  // Other Projects
                                  _OtherProjectsSection(
                                    currentProjectId: project.id,
                                  ),
                                  const SizedBox(height: 64),
                                  // CTA
                                  ScrollFadeIn(
                                    child: CtaBannerSection(
                                        profile: profile),
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
    Project project,
    String thumbnailUrl,
    List<String> galleryUrls,
    bool isMobile,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project thumbnail
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: thumbnailUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: thumbnailUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: const Color(0xFFF8FAFC),
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (_, __, ___) =>
                        _buildPlaceholder(project),
                  )
                : _buildPlaceholder(project),
          ),
        ),
        const SizedBox(height: 40),
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
        // Key Features
        if (project.features.isNotEmpty) ...[
          const Text(
            'Key Features',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          ...project.features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(
                        Icons.check_circle,
                        size: 18,
                        color: Color(0xFF02569B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 40),
        ],
        // My Contributions
        if (project.responsibilities.isNotEmpty) ...[
          const Text(
            'My Contributions',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          ...project.responsibilities.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(
                        Icons.arrow_right,
                        size: 20,
                        color: Color(0xFF02569B),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
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
          _buildGalleryGrid(galleryUrls, isMobile, context),
        ],
      ],
    );
  }

  Widget _buildGalleryGrid(
    List<String> galleryUrls,
    bool isMobile,
    BuildContext context,
  ) {
    final columnCount = isMobile ? 1 : 2;
    final rows = <Widget>[];

    for (var i = 0; i < galleryUrls.length; i += columnCount) {
      final rowChildren = <Widget>[];
      for (var j = 0; j < columnCount; j++) {
        final index = i + j;
        if (index < galleryUrls.length) {
          rowChildren.add(
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _openGalleryLightbox(
                    context,
                    galleryUrls,
                    index,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: CachedNetworkImage(
                        imageUrl: galleryUrls[index],
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: const Color(0xFFF8FAFC),
                          child: const Center(
                            child:
                                CircularProgressIndicator(strokeWidth: 2),
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

  void _openGalleryLightbox(
    BuildContext context,
    List<String> galleryUrls,
    int initialIndex,
  ) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => _GalleryLightbox(
        galleryUrls: galleryUrls,
        initialIndex: initialIndex,
      ),
    );
  }

  Widget _buildSidebar(Project project) {
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
          // Platform icons
          if (project.platforms.isNotEmpty) ...[
            const SizedBox(height: 8),
            const Text(
              'Platforms',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: project.platforms.map((platform) {
                return _buildPlatformChip(platform);
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
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

  Widget _buildPlaceholder(Project project) {
    final hash = project.title.hashCode;
    const palettes = [
      [Color(0xFF0F172A), Color(0xFF1E3A5F)],
      [Color(0xFF1A1A2E), Color(0xFF16213E)],
      [Color(0xFF0D1B2A), Color(0xFF1B4965)],
      [Color(0xFF2D3436), Color(0xFF636E72)],
      [Color(0xFF141E30), Color(0xFF243B55)],
      [Color(0xFF0F2027), Color(0xFF2C5364)],
    ];
    final colors = palettes[hash.abs() % palettes.length];

    IconData icon;
    switch (project.category.toLowerCase()) {
      case 'mobile app':
        icon = Icons.phone_iphone;
        break;
      case 'web app':
        icon = Icons.language;
        break;
      case 'website':
        icon = Icons.public;
        break;
      case 'ecommerce':
        icon = Icons.shopping_bag;
        break;
      default:
        icon = Icons.code;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 56,
              color: Colors.white.withValues(alpha: 0.9),
            ),
            const SizedBox(height: 16),
            Text(
              project.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.95),
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
            if (project.techStack.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 6,
                runSpacing: 6,
                children: project.techStack.take(5).map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tech,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12,
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

  Widget _buildPlatformChip(String platform) {
    IconData icon;
    String label;
    switch (platform.toLowerCase()) {
      case 'ios':
        icon = Icons.apple;
        label = 'iOS';
        break;
      case 'android':
        icon = Icons.android;
        label = 'Android';
        break;
      case 'web':
        icon = Icons.language;
        label = 'Web';
        break;
      case 'macos':
        icon = Icons.desktop_mac;
        label = 'macOS';
        break;
      case 'windows':
        icon = Icons.desktop_windows;
        label = 'Windows';
        break;
      case 'linux':
        icon = Icons.computer;
        label = 'Linux';
        break;
      default:
        icon = Icons.devices;
        label = platform;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF475569)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF475569),
              fontSize: 12,
              fontWeight: FontWeight.w500,
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

/// Fullscreen gallery lightbox using PhotoViewGallery.
class _GalleryLightbox extends HookWidget {
  const _GalleryLightbox({
    required this.galleryUrls,
    required this.initialIndex,
  });

  final List<String> galleryUrls;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(initialIndex);
    final pageController = useMemoized(
      () => PageController(initialPage: initialIndex),
    );

    return Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: pageController,
            itemCount: galleryUrls.length,
            onPageChanged: (index) => currentIndex.value = index,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(galleryUrls[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                heroAttributes:
                    PhotoViewHeroAttributes(tag: 'gallery_$index'),
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            loadingBuilder: (_, __) => const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          ),
          // Close button
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black54,
              ),
            ),
          ),
          // Page indicator
          if (galleryUrls.length > 1)
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${currentIndex.value + 1} / ${galleryUrls.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// "Other Projects" section at the bottom of the detail page.
class _OtherProjectsSection extends ConsumerWidget {
  const _OtherProjectsSection({required this.currentProjectId});

  final String currentProjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otherAsync = ref.watch(otherProjectsProvider(currentProjectId));
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 768;

    return otherAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (projects) {
        if (projects.isEmpty) return const SizedBox.shrink();

        return ScrollFadeIn(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(color: Color(0xFFE2E8F0)),
              const SizedBox(height: 32),
              const Text(
                'Other Projects',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              isMobile
                  ? Column(
                      children: projects
                          .map((p) => Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: _OtherProjectCard(project: p),
                              ))
                          .toList(),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < projects.length; i++) ...[
                          if (i > 0) const SizedBox(width: 24),
                          Expanded(
                            child:
                                _OtherProjectCard(project: projects[i]),
                          ),
                        ],
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}

/// Compact project card used in the "Other Projects" section.
class _OtherProjectCard extends HookConsumerWidget {
  const _OtherProjectCard({required this.project});

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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: isHovered.value
                    ? Colors.black.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.03),
                blurRadius: isHovered.value ? 16 : 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: thumbnailUrl.isNotEmpty
                      ? CachedNetworkImage(
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
                              _buildPlaceholder(),
                        )
                      : _buildPlaceholder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: TextStyle(
                        color: isHovered.value
                            ? const Color(0xFF02569B)
                            : const Color(0xFF0F172A),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (project.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        project.description,
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    final hash = project.title.hashCode;
    const palettes = [
      [Color(0xFF0F172A), Color(0xFF1E3A5F)],
      [Color(0xFF1A1A2E), Color(0xFF16213E)],
      [Color(0xFF0D1B2A), Color(0xFF1B4965)],
      [Color(0xFF2D3436), Color(0xFF636E72)],
      [Color(0xFF141E30), Color(0xFF243B55)],
      [Color(0xFF0F2027), Color(0xFF2C5364)],
    ];
    final colors = palettes[hash.abs() % palettes.length];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.code,
          size: 32,
          color: Colors.white.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}
