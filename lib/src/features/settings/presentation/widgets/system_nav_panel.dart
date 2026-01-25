import 'package:flutter/material.dart';

/// System management modes.
enum SystemMode { speciesBreeds, productCategories, messageTemplates, treatmentTypes, printers }

/// Vertical navigation panel for selecting system mode.
///
/// Displays icons for Species & Breeds, Product Categories, and
/// Message Templates in a NavigationRail-style layout.
class SystemNavPanel extends StatelessWidget {
  const SystemNavPanel({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  /// Currently selected mode.
  final SystemMode currentMode;

  /// Callback when mode is changed.
  final ValueChanged<SystemMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 80,
      child: Column(
        children: [
          const SizedBox(height: 8),
          // Header icon
          Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.settings,
              size: 32,
              color: theme.colorScheme.primary,
            ),
          ),
          const Divider(),
          const SizedBox(height: 8),
          // Species & Breeds button
          _NavButton(
            icon: Icons.pets_outlined,
            selectedIcon: Icons.pets,
            label: 'Species',
            isSelected: currentMode == SystemMode.speciesBreeds,
            onTap: () => onModeChanged(SystemMode.speciesBreeds),
          ),
          const SizedBox(height: 4),
          // Product Categories button
          _NavButton(
            icon: Icons.inventory_2_outlined,
            selectedIcon: Icons.inventory_2,
            label: 'Categories',
            isSelected: currentMode == SystemMode.productCategories,
            onTap: () => onModeChanged(SystemMode.productCategories),
          ),
          const SizedBox(height: 4),
          // Message Templates button
          _NavButton(
            icon: Icons.chat_bubble_outline,
            selectedIcon: Icons.chat_bubble,
            label: 'Templates',
            isSelected: currentMode == SystemMode.messageTemplates,
            onTap: () => onModeChanged(SystemMode.messageTemplates),
          ),
          const SizedBox(height: 4),
          // Treatment Types button
          _NavButton(
            icon: Icons.medical_services_outlined,
            selectedIcon: Icons.medical_services,
            label: 'Treatments',
            isSelected: currentMode == SystemMode.treatmentTypes,
            onTap: () => onModeChanged(SystemMode.treatmentTypes),
          ),
          const SizedBox(height: 4),
          // Printers button
          _NavButton(
            icon: Icons.print_outlined,
            selectedIcon: Icons.print,
            label: 'Printers',
            isSelected: currentMode == SystemMode.printers,
            onTap: () => onModeChanged(SystemMode.printers),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 64,
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.secondaryContainer : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              size: 24,
              color: isSelected
                  ? theme.colorScheme.onSecondaryContainer
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isSelected
                    ? theme.colorScheme.onSecondaryContainer
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : null,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
