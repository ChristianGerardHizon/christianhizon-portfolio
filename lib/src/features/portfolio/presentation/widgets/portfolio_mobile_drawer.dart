import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/portfolio_constants.dart';
import '../../domain/profile.dart';
import 'contact_dialog.dart';

/// Mobile navigation drawer for the portfolio.
class PortfolioMobileDrawer extends StatelessWidget {
  const PortfolioMobileDrawer({
    super.key,
    required this.profile,
    this.onNavTap,
  });

  final Profile profile;
  final void Function(String sectionKey)? onNavTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(24),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            // Logo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF02569B),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.flutter_dash,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      profile.name.toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Color(0xFF475569)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(color: Color(0xFFE2E8F0)),
            const SizedBox(height: 8),
            // Nav links
            ...PortfolioConstants.navLinks.map((link) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    link.label,
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    if (link.routePath != null) {
                      context.go(link.routePath!);
                    } else {
                      onNavTap?.call(link.sectionKey);
                    }
                  },
                )),
            const SizedBox(height: 16),
            // "Let's Talk" button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                        Navigator.of(context).pop();
                        ContactDialog.show(context, profile);
                      },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF0F172A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: const Text("Let's Talk"),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
