import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/profile.dart';

/// Hero section with gradient name, stats, photo card, and CTA buttons.
class PortfolioHeroSection extends ConsumerWidget {
  const PortfolioHeroSection({
    super.key,
    required this.profile,
    this.onViewPortfolio,
  });

  final Profile profile;
  final VoidCallback? onViewPortfolio;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 768;
    final baseUrl = pocketbaseUrl;
    final photoUrl = profile.photoUrl(baseUrl);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 48 : 80),
      child: isMobile
          ? Column(
              children: [
                if (photoUrl.isNotEmpty) ...[
                  _buildPhotoCard(photoUrl),
                  const SizedBox(height: 40),
                ],
                _buildTextContent(isMobile: true),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 55,
                  child: _buildTextContent(isMobile: false),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 45,
                  child: photoUrl.isNotEmpty
                      ? _buildPhotoCard(photoUrl)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
    );
  }

  Widget _buildTextContent({required bool isMobile}) {
    // Split name into first name and last name
    final nameParts = profile.name.trim().split(' ');
    final firstName = nameParts.first.toUpperCase();
    final lastName =
        nameParts.length > 1 ? nameParts.sublist(1).join(' ').toUpperCase() : '';

    final fontSize = isMobile ? 48.0 : 72.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Availability badge
        if (profile.availabilityStatus.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE1F5FE),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              profile.availabilityStatus.toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF02569B),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
        // Name with gradient on last name
        Text(
          firstName,
          style: TextStyle(
            color: const Color(0xFF0F172A),
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            height: 0.9,
            letterSpacing: -2,
          ),
        ),
        if (lastName.isNotEmpty)
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF02569B), Color(0xFF38BDF8)],
            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
            child: Text(
              lastName,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w900,
                height: 0.9,
                letterSpacing: -2,
              ),
            ),
          ),
        // Bio
        if (profile.bio.isNotEmpty) ...[
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              profile.bio,
              style: const TextStyle(
                color: Color(0xFF475569),
                fontSize: 17,
                height: 1.7,
              ),
            ),
          ),
        ],
        // Buttons
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: onViewPortfolio,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF02569B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
                elevation: 4,
                shadowColor: const Color(0xFF02569B).withValues(alpha: 0.3),
              ),
              child: const Text('View Portfolio'),
            ),
            if (profile.githubUrl.isNotEmpty)
              OutlinedButton(
                onPressed: () => _launchUrl(profile.githubUrl),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0F172A),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                child: const Text('GitHub Profile'),
              ),
          ],
        ),
        // Stats row
        if (profile.stats.isNotEmpty) ...[
          const SizedBox(height: 40),
          Wrap(
            spacing: 32,
            runSpacing: 16,
            children: profile.stats.map((stat) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    stat.value,
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    stat.label,
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildPhotoCard(String photoUrl) {
    return AspectRatio(
      aspectRatio: 4 / 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF02569B).withValues(alpha: 0.15),
              blurRadius: 48,
              offset: const Offset(0, 16),
            ),
          ],
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Photo
              CachedNetworkImage(
                imageUrl: photoUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: const Color(0xFFF1F5F9),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person, size: 48, color: Color(0xFFCBD5E1)),
                        SizedBox(height: 8),
                        Text(
                          'Christian Hizon',
                          style: TextStyle(
                            color: Color(0xFFCBD5E1),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: const Color(0xFFF1F5F9),
                  child: const Center(
                    child: Icon(Icons.person, size: 48, color: Color(0xFFCBD5E1)),
                  ),
                ),
              ),
              // Gradient overlay
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0x33FFFFFF),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              // "Latest Build" overlay card
              Positioned(
                bottom: 24,
                left: 24,
                right: 24,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDBEAFE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.smartphone,
                              size: 20,
                              color: Color(0xFF02569B),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Latest Build: v2.4.0',
                                  style: TextStyle(
                                    color: Color(0xFF0F172A),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Deployed to TestFlight & Play Store',
                                  style: TextStyle(
                                    color: Color(0xFF475569),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
