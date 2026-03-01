import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/profile.dart';

/// Modal dialog showing social/contact links.
class ContactDialog extends StatelessWidget {
  const ContactDialog({super.key, required this.profile});

  final Profile profile;

  static Future<void> show(BuildContext context, Profile profile) {
    return showDialog(
      context: context,
      builder: (_) => ContactDialog(profile: profile),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 500;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isMobile ? 360 : 420),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF02569B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Let's Connect",
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Feel free to reach out through any of these channels.',
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 14,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              // Contact links
              if (profile.email.isNotEmpty)
                _ContactTile(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: profile.email,
                  onTap: () => _launch('mailto:${profile.email}'),
                  onCopy: () => _copy(context, profile.email),
                ),
              if (profile.phone.isNotEmpty) ...[
                const SizedBox(height: 12),
                _ContactTile(
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: profile.phone,
                  onTap: () => _launch('tel:${profile.phone}'),
                  onCopy: () => _copy(context, profile.phone),
                ),
              ],
              if (profile.linkedinUrl.isNotEmpty) ...[
                const SizedBox(height: 12),
                _ContactTile(
                  icon: Icons.work_outline,
                  label: 'LinkedIn',
                  value: _shortenUrl(profile.linkedinUrl),
                  onTap: () => _launch(profile.linkedinUrl),
                ),
              ],
              if (profile.githubUrl.isNotEmpty) ...[
                const SizedBox(height: 12),
                _ContactTile(
                  icon: Icons.code,
                  label: 'GitHub',
                  value: _shortenUrl(profile.githubUrl),
                  onTap: () => _launch(profile.githubUrl),
                ),
              ],
              if (profile.websiteUrl.isNotEmpty) ...[
                const SizedBox(height: 12),
                _ContactTile(
                  icon: Icons.language,
                  label: 'Website',
                  value: _shortenUrl(profile.websiteUrl),
                  onTap: () => _launch(profile.websiteUrl),
                ),
              ],
              const SizedBox(height: 24),
              // Close button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF64748B),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _shortenUrl(String url) {
    return url
        .replaceFirst('https://', '')
        .replaceFirst('http://', '')
        .replaceFirst('www.', '');
  }

  Future<void> _launch(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _copy(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied: $text'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    this.onCopy,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        hoverColor: const Color(0xFFF1F5F9),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF02569B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 18, color: const Color(0xFF02569B)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (onCopy != null) ...[
                const SizedBox(width: 8),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: onCopy,
                    child: const Icon(
                      Icons.copy,
                      size: 16,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ),
              ],
              const SizedBox(width: 8),
              const Icon(
                Icons.open_in_new,
                size: 14,
                color: Color(0xFFCBD5E1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
