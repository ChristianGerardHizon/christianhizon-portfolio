import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../assets/assets.gen.dart';
import '../i18n/strings.g.dart';
import '../utils/breakpoints.dart';

/// Navigation rail for tablet and desktop admin layouts.
///
/// Displays admin navigation destinations: Profile, Projects.
class TabletNavRail extends ConsumerWidget {
  const TabletNavRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final isLargeTablet = Breakpoints.isTabletLargeOrLarger(context);

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: IntrinsicHeight(
          child: NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: isLargeTablet
                ? NavigationRailLabelType.all
                : NavigationRailLabelType.selected,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Assets.icons.appIconTransparent.image(
                width: 40,
                height: 40,
              ),
            ),
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: IconButton(
                    icon: const Icon(Icons.logout),
                    tooltip: t.auth.logoutButton,
                    onPressed: () => _confirmLogout(context, ref, t),
                  ),
                ),
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.person_outlined),
                selectedIcon: Icon(Icons.person),
                label: Text('Profile'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.work_outlined),
                selectedIcon: Icon(Icons.work),
                label: Text('Projects'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context, WidgetRef ref, Translations t) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.auth.logoutButton),
        content: Text(t.auth.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(t.common.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(authControllerProvider.notifier).logout();
            },
            child: Text(t.auth.logoutButton),
          ),
        ],
      ),
    );
  }
}
