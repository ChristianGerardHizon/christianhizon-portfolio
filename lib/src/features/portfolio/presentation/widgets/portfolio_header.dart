import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes/portfolio.routes.dart';
import '../../domain/portfolio_constants.dart';
import '../../domain/profile.dart';
import 'contact_dialog.dart';
import 'portfolio_mobile_drawer.dart';

/// Sticky portfolio header with logo, nav links, and CTA.
class PortfolioHeader extends StatelessWidget {
  const PortfolioHeader({
    super.key,
    required this.profile,
    this.onNavTap,
  });

  final Profile profile;
  final void Function(String sectionKey)? onNavTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 768;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            border: const Border(
              bottom: BorderSide(color: Color(0xFFE2E8F0)),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 40,
            vertical: 16,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo — navigates to home
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => const PortfolioRoute().go(context),
                      child: _buildLogo(),
                    ),
                  ),
                  // Desktop nav
                  if (!isMobile) _buildDesktopNav(context),
                  // Mobile hamburger
                  if (isMobile)
                    IconButton(
                      onPressed: () => _openDrawer(context),
                      icon: const Icon(
                        Icons.menu,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    // Extract short name like "CHRISTIAN H."
    final nameParts = profile.name.trim().split(' ');
    final shortName = nameParts.length > 1
        ? '${nameParts.first.toUpperCase()} ${nameParts.last[0].toUpperCase()}.'
        : profile.name.toUpperCase();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/icons/app_icon.png',
            width: 32,
            height: 32,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          shortName,
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopNav(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Nav links
        ...PortfolioConstants.navLinks.map((link) => Padding(
              padding: const EdgeInsets.only(left: 32),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if (link.routePath != null) {
                      context.go(link.routePath!);
                    } else {
                      onNavTap?.call(link.sectionKey);
                    }
                  },
                  child: Text(
                    link.label,
                    style: const TextStyle(
                      color: Color(0xFF475569),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )),
        const SizedBox(width: 32),
        // "Let's Talk" button
        FilledButton(
          onPressed: () => ContactDialog.show(context, profile),
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
            elevation: 4,
            shadowColor: const Color(0xFF0F172A).withValues(alpha: 0.2),
          ),
          child: const Text("Let's Talk"),
        ),
      ],
    );
  }

  void _openDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PortfolioMobileDrawer(
        profile: profile,
        onNavTap: (sectionKey) {
          Navigator.of(context).pop();
          onNavTap?.call(sectionKey);
        },
      ),
    );
  }

}
