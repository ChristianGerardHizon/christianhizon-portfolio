import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../../core/routing/routes/portfolio.routes.dart';
import '../../../../core/widgets/state/error_state.dart';
import '../../domain/speaking_event.dart';
import '../../domain/work_history_item.dart';
import '../controllers/profile_controller.dart';
import '../controllers/work_history_controller.dart';
import '../widgets/cta_banner_section.dart';
import '../widgets/portfolio_footer.dart';
import '../widgets/portfolio_header.dart';

/// Public work history page displayed at `/work-history`.
class WorkHistoryPage extends HookConsumerWidget {
  const WorkHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);
    final workHistoryAsync = ref.watch(workHistoryControllerProvider);
    final speakingAsync = ref.watch(speakingEventsControllerProvider);
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

          final workItems = workHistoryAsync.value ?? [];
          final speakingEvents = speakingAsync.value ?? [];

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 72),
                child: Column(
                  children: [
                    // Hero section
                    _buildHero(context, isMobile, workItems.length, profile),
                    // Content
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
                              const SizedBox(height: 48),
                              // Timeline
                              ...List.generate(workItems.length, (index) {
                                final item = workItems[index];
                                final isLast =
                                    index == workItems.length - 1;
                                return _WorkHistoryCard(
                                  item: item,
                                  isLast: isLast,
                                  isMobile: isMobile,
                                );
                              }),
                              // Speaking & Mentorship section
                              if (speakingEvents.isNotEmpty) ...[
                                const SizedBox(height: 64),
                                _buildSpeakingSection(
                                  speakingEvents,
                                  isMobile,
                                ),
                              ],
                              const SizedBox(height: 64),
                              CtaBannerSection(profile: profile),
                              const SizedBox(height: 48),
                            ],
                          ),
                        ),
                      ),
                    ),
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

  Widget _buildHero(
    BuildContext context,
    bool isMobile,
    int count,
    dynamic profile,
  ) {
    return Container(
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
                  color: const Color(0xFF02569B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  '$count Companies',
                  style: const TextStyle(
                    color: Color(0xFF02569B),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Work History',
                style: TextStyle(
                  color: const Color(0xFF0F172A),
                  fontSize: isMobile ? 36 : 48,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: const Text(
                  'Professional experience in mobile and web development, '
                  'building production apps across multiple industries.',
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 16,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Download resume button
              if (profile.resumeUrl != null &&
                  (profile.resumeUrl as String).isNotEmpty) ...[
                const SizedBox(height: 24),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      final uri = Uri.tryParse(
                        profile.resumeFileUrl(pocketbaseUrl) as String,
                      );
                      if (uri != null) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF02569B),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.download_outlined,
                            size: 16,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'DOWNLOAD RESUME',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpeakingSection(
    List<SpeakingEvent> events,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section heading
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFF02569B),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Speaking & Mentorship',
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Community involvement through talks and mentoring',
          style: TextStyle(
            color: Color(0xFF64748B),
            fontSize: 15,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        // Event cards
        ...events.map((event) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _SpeakingEventCard(event: event),
            )),
      ],
    );
  }
}

class _WorkHistoryCard extends HookWidget {
  const _WorkHistoryCard({
    required this.item,
    required this.isLast,
    required this.isMobile,
  });

  final WorkHistoryItem item;
  final bool isLast;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(true);
    final dateRange = item.endDate.isNotEmpty
        ? '${item.startDate} — ${item.endDate}'
        : '${item.startDate} — Present';

    return Stack(
      children: [
        // Timeline line
        if (!isLast)
          Positioned(
            left: 11,
            top: 22,
            bottom: 0,
            child: Container(
              width: 2,
              color: const Color(0xFFE2E8F0),
            ),
          ),
        // Content
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline dot
            SizedBox(
              width: 24,
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: item.endDate.isEmpty
                          ? const Color(0xFF02569B)
                          : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF02569B),
                        width: 2.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Card content
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 32),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => isExpanded.value = !isExpanded.value,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header: role + date
                          if (isMobile) ...[
                            Text(
                              item.role,
                              style: const TextStyle(
                                color: Color(0xFF0F172A),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              dateRange,
                              style: const TextStyle(
                                color: Color(0xFF02569B),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ] else
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.role,
                                    style: const TextStyle(
                                      color: Color(0xFF0F172A),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      dateRange,
                                      style: const TextStyle(
                                        color: Color(0xFF02569B),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    AnimatedRotation(
                                      turns: isExpanded.value ? 0.5 : 0,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: const Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 20,
                                        color: Color(0xFF94A3B8),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          const SizedBox(height: 4),
                          // Company name
                          Text(
                            item.company,
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          // Expandable content
                          AnimatedCrossFade(
                            firstChild: _buildExpandedContent(),
                            secondChild: const SizedBox.shrink(),
                            crossFadeState: isExpanded.value
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: const Duration(milliseconds: 200),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description
        if (item.description.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            item.description,
            style: const TextStyle(
              color: Color(0xFF475569),
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
        // Responsibilities
        if (item.responsibilities.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            'Responsibilities',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ...item.responsibilities.map((r) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Icon(
                        Icons.circle,
                        size: 5,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        r,
                        style: const TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
        // Achievements
        if (item.achievements.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            'Key Achievements',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ...item.achievements.map((a) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.emoji_events_outlined,
                        size: 16,
                        color: Color(0xFF02569B),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${a.title}: ',
                              style: const TextStyle(
                                color: Color(0xFF0F172A),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.6,
                              ),
                            ),
                            TextSpan(
                              text: a.description,
                              style: const TextStyle(
                                color: Color(0xFF475569),
                                fontSize: 14,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
        // Tech stack pills
        if (item.techStack.isNotEmpty) ...[
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: item.techStack.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF02569B).withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  tech,
                  style: const TextStyle(
                    color: Color(0xFF02569B),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}

class _SpeakingEventCard extends HookWidget {
  const _SpeakingEventCard({required this.event});

  final SpeakingEvent event;

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHovered.value
                ? const Color(0xFF02569B).withValues(alpha: 0.5)
                : const Color(0xFFE2E8F0),
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered.value
                  ? Colors.black.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: isHovered.value ? 16 : 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: event.type == 'speaker'
                    ? const Color(0xFFEFF6FF)
                    : const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                event.type == 'speaker' ? Icons.mic_outlined : Icons.school_outlined,
                size: 24,
                color: event.type == 'speaker'
                    ? const Color(0xFF02569B)
                    : const Color(0xFF16A34A),
              ),
            ),
            const SizedBox(width: 16),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          style: const TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Type badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: event.type == 'speaker'
                              ? const Color(0xFFEFF6FF)
                              : const Color(0xFFF0FDF4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          event.type == 'speaker' ? 'Speaker' : 'Mentor',
                          style: TextStyle(
                            color: event.type == 'speaker'
                                ? const Color(0xFF02569B)
                                : const Color(0xFF16A34A),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${event.organization}  •  ${event.date}',
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  if (event.description.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      event.description,
                      style: const TextStyle(
                        color: Color(0xFF475569),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
