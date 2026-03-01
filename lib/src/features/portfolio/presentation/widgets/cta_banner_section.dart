import 'package:flutter/material.dart';

import '../../domain/portfolio_constants.dart';
import '../../domain/profile.dart';
import 'contact_dialog.dart';

/// Gradient blue CTA banner section.
class CtaBannerSection extends StatelessWidget {
  const CtaBannerSection({super.key, required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 32),
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
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF02569B).withValues(alpha: 0.3),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative radial gradient overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const RadialGradient(
                  center: Alignment.topRight,
                  radius: 1.0,
                  colors: [
                    Color(0x33FFFFFF),
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.5],
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  PortfolioConstants.ctaTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    height: 1.1,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Text(
                    PortfolioConstants.ctaSubtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 16,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => ContactDialog.show(context, profile),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF02569B),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    elevation: 4,
                  ),
                  child: const Text(PortfolioConstants.ctaButtonText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
