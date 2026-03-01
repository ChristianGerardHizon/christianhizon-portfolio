import 'package:flutter/material.dart';

/// Static data for portfolio sections not backed by PocketBase.
abstract class PortfolioConstants {
  /// Navigation links for the portfolio header.
  static const navLinks = [
    NavLink(label: 'Projects', sectionKey: 'apps', routePath: '/projects'),
    NavLink(label: 'Work', sectionKey: 'about'),
    NavLink(label: 'Tech Stack', sectionKey: 'tech'),
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
