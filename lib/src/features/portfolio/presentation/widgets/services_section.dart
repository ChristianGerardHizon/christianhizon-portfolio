import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/portfolio.routes.dart';
import '../../domain/portfolio_constants.dart';

/// Development services section with 2x2 card grid.
class ServicesSection extends HookConsumerWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 48),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: isMobile ? 48 : 64,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLeftColumn(context),
                const SizedBox(height: 40),
                _buildServiceCards(isMobile: true),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: _buildLeftColumn(context)),
                const SizedBox(width: 48),
                Expanded(flex: 2, child: _buildServiceCards(isMobile: false)),
              ],
            ),
    );
  }

  Widget _buildLeftColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Development\nServices',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          PortfolioConstants.servicesDescription,
          style: TextStyle(
            color: Color(0xFF475569),
            fontSize: 15,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              const TechStackRoute().go(context);
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'TECH STACK',
                  style: TextStyle(
                    color: Color(0xFF02569B),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward,
                  size: 18,
                  color: Color(0xFF02569B),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCards({required bool isMobile}) {
    if (isMobile) {
      return Column(
        children: PortfolioConstants.services
            .map((service) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _ServiceCard(service: service),
                ))
            .toList(),
      );
    }

    // Desktop: 2x2 grid
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _ServiceCard(service: PortfolioConstants.services[0]),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _ServiceCard(service: PortfolioConstants.services[1]),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _ServiceCard(service: PortfolioConstants.services[2]),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _ServiceCard(service: PortfolioConstants.services[3]),
            ),
          ],
        ),
      ],
    );
  }
}

class _ServiceCard extends HookWidget {
  const _ServiceCard({required this.service});

  final ServiceItem service;

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE1F5FE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                service.icon,
                size: 24,
                color: const Color(0xFF02569B),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              service.title,
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              service.description,
              style: const TextStyle(
                color: Color(0xFF475569),
                fontSize: 14,
                height: 1.6,
              ),
              overflow: TextOverflow.clip,
            ),
          ],
        ),
      ),
    );
  }
}
