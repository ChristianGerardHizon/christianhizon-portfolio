import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/portfolio.routes.dart';
import '../../../../core/widgets/state/error_state.dart';
import '../../domain/portfolio_constants.dart';
import '../../domain/tech_stack_item.dart';
import '../controllers/profile_controller.dart';
import '../controllers/tech_stack_controller.dart';
import '../widgets/cta_banner_section.dart';
import '../widgets/portfolio_footer.dart';
import '../widgets/portfolio_header.dart';
import '../widgets/scroll_fade_in.dart';

/// Public tech stack page displayed at `/tech-stack`.
class TechStackPage extends HookConsumerWidget {
  const TechStackPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);
    final techStackAsync = ref.watch(techStackControllerProvider);
    final selectedCategory = useState('All');
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: Colors.white,
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorState(
          message: 'Failed to load portfolio',
          onRetry: () => ref.invalidate(profileControllerProvider),
        ),
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('Portfolio not configured'));
          }

          final allItems = techStackAsync.value ?? [];
          final categories = [
            'All',
            ...{
              ...allItems
                  .map((item) => item.category)
                  .where((c) => c.isNotEmpty),
            },
          ];
          final filteredItems = selectedCategory.value == 'All'
              ? allItems
              : allItems
                  .where((item) => item.category == selectedCategory.value)
                  .toList();

          // Group by category for display
          final grouped = <String, List<TechStackItem>>{};
          for (final item in filteredItems) {
            final cat = item.category.isNotEmpty ? item.category : 'Other';
            grouped.putIfAbsent(cat, () => []).add(item);
          }

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 72),
                child: Column(
                  children: [
                    // Hero section
                    _buildHero(isMobile, allItems.length),
                    // Filter + content
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 24 : 40,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 32),
                              // Category filter chips
                              _buildFilterChips(
                                categories,
                                selectedCategory,
                              ),
                              const SizedBox(height: 48),
                              // Category groups
                              ...grouped.entries.toList().asMap().entries.map(
                                    (entry) => ScrollFadeIn(
                                      delay: Duration(
                                          milliseconds: 100 * entry.key),
                                      child: _buildCategoryGroup(
                                        entry.value.key,
                                        entry.value.value,
                                        isMobile,
                                        screenWidth,
                                      ),
                                    ),
                                  ),
                              const SizedBox(height: 64),
                              ScrollFadeIn(
                                child: CtaBannerSection(profile: profile),
                              ),
                              const SizedBox(height: 48),
                            ],
                          ),
                        ),
                      ),
                    ),
                    PortfolioFooter(profile: profile),
                  ],
                ),
              ),
              // Sticky header
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: PortfolioHeader(
                  profile: profile,
                  onNavTap: (key) {
                    const PortfolioRoute().go(context);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHero(bool isMobile, int count) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF8FAFC), Color(0xFFEFF6FF)],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 40,
        vertical: isMobile ? 48 : 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Count badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF02569B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  '$count Technologies',
                  style: const TextStyle(
                    color: Color(0xFF02569B),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Tech Stack',
                style: TextStyle(
                  color: const Color(0xFF0F172A),
                  fontSize: isMobile ? 36 : 48,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: const Text(
                  'Technologies, frameworks, and tools I use to build '
                  'production-ready applications.',
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 16,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips(
    List<String> categories,
    ValueNotifier<String> selectedCategory,
  ) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        final isSelected = selectedCategory.value == category;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => selectedCategory.value = category,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF02569B) : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF02569B)
                      : const Color(0xFFE2E8F0),
                ),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF475569),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryGroup(
    String category,
    List<TechStackItem> items,
    bool isMobile,
    double screenWidth,
  ) {
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final columnCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category heading
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFF02569B),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              category,
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Card grid
        _buildGrid(items, columnCount),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildGrid(List<TechStackItem> items, int columnCount) {
    final rows = <Widget>[];
    for (var i = 0; i < items.length; i += columnCount) {
      final rowChildren = <Widget>[];
      for (var j = 0; j < columnCount; j++) {
        if (i + j < items.length) {
          rowChildren.add(
            Expanded(child: _TechStackCard(item: items[i + j])),
          );
        } else {
          rowChildren.add(const Expanded(child: SizedBox.shrink()));
        }
        if (j < columnCount - 1) {
          rowChildren.add(const SizedBox(width: 16));
        }
      }
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowChildren,
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}

class _TechStackCard extends HookWidget {
  const _TechStackCard({required this.item});

  final TechStackItem item;

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
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
            // Top row: icon + years badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1F5FE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    PortfolioConstants.techStackIcon(item.iconName),
                    size: 24,
                    color: const Color(0xFF02569B),
                  ),
                ),
                if (item.yearsOfExperience > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${item.yearsOfExperience}+ yrs',
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            // Name
            Text(
              item.name,
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            // Description
            if (item.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                item.description,
                style: const TextStyle(
                  color: Color(0xFF475569),
                  fontSize: 14,
                  height: 1.6,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            // Proficiency bar
            if (item.proficiencyLevel > 0) ...[
              const SizedBox(height: 16),
              _ProficiencyBar(level: item.proficiencyLevel),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProficiencyBar extends StatelessWidget {
  const _ProficiencyBar({required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: List.generate(5, (index) {
              final isFilled = index < level;
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: index < 4 ? 4 : 0),
                  decoration: BoxDecoration(
                    color: isFilled
                        ? const Color(0xFF02569B)
                        : const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          _levelLabel(level),
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _levelLabel(int level) {
    switch (level) {
      case 1:
        return 'Beginner';
      case 2:
        return 'Basic';
      case 3:
        return 'Intermediate';
      case 4:
        return 'Advanced';
      case 5:
        return 'Expert';
      default:
        return '';
    }
  }
}
