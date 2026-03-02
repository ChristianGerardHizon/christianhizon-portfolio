import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/profile.dart';

/// Work history timeline section showing professional experience.
class WorkHistorySection extends ConsumerWidget {
  const WorkHistorySection({super.key, required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (profile.experience.isEmpty) return const SizedBox.shrink();

    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: title + download resume
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Work History',
                style: TextStyle(
                  color: const Color(0xFF0F172A),
                  fontSize: isMobile ? 28 : 32,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Professional experience in mobile development',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              if (profile.resumeUrl.isNotEmpty) ...[
                const SizedBox(height: 16),
                _DownloadResumeButton(
                  resumeUrl: profile.resumeFileUrl(pocketbaseUrl),
                ),
              ],
            ],
          ),
          const SizedBox(height: 40),
          // Timeline entries
          ...List.generate(profile.experience.length, (index) {
            final exp = profile.experience[index];
            final isLast = index == profile.experience.length - 1;
            return _TimelineEntry(
              experience: exp,
              isLast: isLast,
              isMobile: isMobile,
            );
          }),
        ],
      ),
    );
  }
}

class _DownloadResumeButton extends StatelessWidget {
  const _DownloadResumeButton({required this.resumeUrl});

  final String resumeUrl;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.tryParse(resumeUrl);
          if (uri != null) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'DOWNLOAD RESUME',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
            SizedBox(width: 6),
            Icon(
              Icons.download_outlined,
              size: 16,
              color: Color(0xFF64748B),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.experience,
    required this.isLast,
    required this.isMobile,
  });

  final Experience experience;
  final bool isLast;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final dateRange = experience.endDate != null
        ? '${experience.startDate} — ${experience.endDate}'
        : '${experience.startDate} — Present';

    // Parse bullet points from description (split by newline)
    final bullets = experience.description
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    return Stack(
      children: [
        // Timeline line (behind content, stretches full height)
        if (!isLast)
          Positioned(
            left: 11, // Center of the 24px rail (12px dot center)
            top: 22, // Below the dot (6 + 12 + 4)
            bottom: 0,
            child: Container(
              width: 2,
              color: const Color(0xFFE2E8F0),
            ),
          ),
        // Main content row
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
                      color: Colors.white,
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
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Role + Date row
                    if (isMobile) ...[
                      Text(
                        experience.role,
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
                              experience.role,
                              style: const TextStyle(
                                color: Color(0xFF0F172A),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            dateRange,
                            style: const TextStyle(
                              color: Color(0xFF02569B),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 4),
                    // Company name
                    Text(
                      experience.company,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    // Bullet points
                    if (bullets.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      ...bullets.map((bullet) => Padding(
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
                                    bullet,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
