import 'package:flutter/material.dart';

/// Static data for portfolio sections not backed by PocketBase.
abstract class PortfolioConstants {
  /// Navigation links for the portfolio header.
  static const navLinks = [
    NavLink(label: 'Projects', sectionKey: 'apps', routePath: '/projects'),
    NavLink(label: 'Work', sectionKey: 'about', routePath: '/work-history'),
    NavLink(label: 'Tech Stack', sectionKey: 'tech', routePath: '/tech-stack'),
    NavLink(label: "Let's Talk", sectionKey: 'contact'),
  ];

  /// Development service cards.
  static const services = [
    ServiceItem(
      icon: Icons.devices_other,
      title: 'Cross-Platform Dev',
      description:
          'Single codebase for iOS and Android using Flutter, ensuring consistent behavior and faster delivery.',
    ),
    ServiceItem(
      icon: Icons.touch_app,
      title: 'Custom UI/UX Implementation',
      description:
          'Implementation of complex, custom designs with smooth animations and intuitive user interactions.',
    ),
    ServiceItem(
      icon: Icons.api,
      title: 'API Integration',
      description:
          'Seamless connection to backend services, RESTful APIs, and third-party libraries.',
    ),
    ServiceItem(
      icon: Icons.speed,
      title: 'App Optimization',
      description:
          'Performance tuning, state management optimization, and reducing app bundle size.',
    ),
  ];

  /// CTA banner content.
  static const ctaTitle = 'HAVE AN APP IDEA?';
  static const ctaSubtitle =
      "From concept to App Store deployment, let's turn your vision into a high-performance mobile application.";
  static const ctaButtonText = 'Start a Project';

  /// Services section description.
  static const servicesDescription =
      'I specialize in building robust, scalable mobile applications that provide native performance on both iOS and Android using Flutter.';

  /// Maps iconName strings from PocketBase to Material Icons.
  static const techStackIcons = <String, IconData>{
    'dart': Icons.code,
    'flutter': Icons.flutter_dash,
    'javascript': Icons.javascript,
    'angular': Icons.change_history,
    'sql': Icons.storage,
    'riverpod': Icons.hub,
    'hooks': Icons.link,
    'pocketbase': Icons.dns,
    'firebase': Icons.local_fire_department,
    'gorouter': Icons.alt_route,
    'dart_mappable': Icons.transform,
    'fpdart': Icons.functions,
    'form_builder': Icons.dynamic_form,
    'git': Icons.merge_type,
    'vscode': Icons.edit_note,
    'github_actions': Icons.play_circle,
    'bloc': Icons.view_stream,
    'codemagic': Icons.auto_fix_high,
    'docker': Icons.inventory_2,
    'ionic': Icons.phone_android,
    'nodejs': Icons.memory,
    'shopify': Icons.shopping_bag,
    'nopcommerce': Icons.storefront,
    'opencart': Icons.shopping_cart,
  };

  /// Returns the icon for a tech stack item, with a fallback.
  static IconData techStackIcon(String iconName) {
    return techStackIcons[iconName] ?? Icons.code;
  }
}

/// A navigation link for the portfolio header.
class NavLink {
  final String label;
  final String sectionKey;
  final String? routePath;

  const NavLink({required this.label, required this.sectionKey, this.routePath});
}

/// A development service item for the services section.
class ServiceItem {
  final IconData icon;
  final String title;
  final String description;

  const ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}
