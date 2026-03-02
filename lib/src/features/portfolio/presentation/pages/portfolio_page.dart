import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/state/empty_state.dart';
import '../../../../core/widgets/state/error_state.dart';
import '../controllers/profile_controller.dart';
import '../controllers/projects_controller.dart';
import '../widgets/cta_banner_section.dart';
import '../widgets/featured_apps_section.dart';
import '../widgets/portfolio_footer.dart';
import '../widgets/portfolio_header.dart';
import '../widgets/portfolio_hero_section.dart';
import '../widgets/scroll_fade_in.dart';
import '../widgets/services_section.dart';
import '../widgets/work_history_section.dart';

/// Public portfolio page displayed at `/`.
class PortfolioPage extends HookConsumerWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);
    final projectsAsync = ref.watch(featuredProjectsProvider);
    final scrollController = useScrollController();

    // GlobalKeys for scroll-to-section navigation
    final appsKey = useMemoized(() => GlobalKey());
    final aboutKey = useMemoized(() => GlobalKey());
    final servicesKey = useMemoized(() => GlobalKey());
    final ctaKey = useMemoized(() => GlobalKey());

    void scrollToSection(String sectionKey) {
      final GlobalKey? targetKey;
      switch (sectionKey) {
        case 'apps':
          targetKey = appsKey;
        case 'about':
          targetKey = aboutKey;
        case 'tech':
          targetKey = servicesKey;
        case 'contact':
          targetKey = ctaKey;
        default:
          targetKey = null;
      }
      if (targetKey?.currentContext != null) {
        Scrollable.ensureVisible(
          targetKey!.currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }

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
            return const EmptyState(
              icon: Icons.person_outline,
              title: 'Portfolio not yet configured',
              subtitle: 'Log in as admin to set up your profile.',
            );
          }

          final projects = projectsAsync.value ?? [];

          final screenWidth = MediaQuery.sizeOf(context).width;
          final isMobile = screenWidth < 768;

          return Stack(
            children: [
              // Scrollable content
              SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.only(top: 72),
                child: Column(
                  children: [
                    // Main content with max width
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 24 : 40,
                          ),
                          child: Column(
                            children: [
                              PortfolioHeroSection(
                                profile: profile,
                                onViewPortfolio: () =>
                                    scrollToSection('apps'),
                              ),
                              ScrollFadeIn(
                                child: FeaturedAppsSection(
                                  key: appsKey,
                                  projects: projects,
                                ),
                              ),
                              ScrollFadeIn(
                                child: ServicesSection(key: servicesKey),
                              ),
                              ScrollFadeIn(
                                child: WorkHistorySection(
                                  key: aboutKey,
                                  profile: profile,
                                ),
                              ),
                              ScrollFadeIn(
                                child: CtaBannerSection(
                                  key: ctaKey,
                                  profile: profile,
                                ),
                              ),
                              const SizedBox(height: 48),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Footer is full-width
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
                  onNavTap: scrollToSection,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
