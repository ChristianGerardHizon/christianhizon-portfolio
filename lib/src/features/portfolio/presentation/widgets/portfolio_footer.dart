import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/profile.dart';

/// Footer with logo, social icons, and copyright.
class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key, required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 40,
        vertical: 48,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? Column(
                  children: [
                    _buildLogo(),
                    const SizedBox(height: 24),
                    _buildSocialIcons(),
                    const SizedBox(height: 24),
                    _buildCopyright(),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLogo(),
                    _buildSocialIcons(),
                    _buildCopyright(),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFF02569B),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(
            Icons.flutter_dash,
            size: 14,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          profile.name.toUpperCase(),
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (profile.githubUrl.isNotEmpty)
          _SocialIconButton(
            onTap: () => _launchUrl(profile.githubUrl),
            child: const _GitHubIcon(),
          ),
        if (profile.linkedinUrl.isNotEmpty) ...[
          const SizedBox(width: 24),
          _SocialIconButton(
            onTap: () => _launchUrl(profile.linkedinUrl),
            child: const _LinkedInIcon(),
          ),
        ],
        if (profile.stackOverflowUrl.isNotEmpty) ...[
          const SizedBox(width: 24),
          _SocialIconButton(
            onTap: () => _launchUrl(profile.stackOverflowUrl),
            child: const _StackOverflowIcon(),
          ),
        ],
      ],
    );
  }

  Widget _buildCopyright() {
    return Text(
      '\u00a9 ${DateTime.now().year} ${profile.name}. All rights reserved.',
      style: const TextStyle(
        color: Color(0xFF94A3B8),
        fontSize: 14,
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

class _SocialIconButton extends StatelessWidget {
  const _SocialIconButton({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: child,
      ),
    );
  }
}

class _GitHubIcon extends StatelessWidget {
  const _GitHubIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.code, size: 20, color: Color(0xFF94A3B8));
  }
}

class _LinkedInIcon extends StatelessWidget {
  const _LinkedInIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.work_outline, size: 20, color: Color(0xFF94A3B8));
  }
}

class _StackOverflowIcon extends StatelessWidget {
  const _StackOverflowIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.bar_chart, size: 20, color: Color(0xFF94A3B8));
  }
}
