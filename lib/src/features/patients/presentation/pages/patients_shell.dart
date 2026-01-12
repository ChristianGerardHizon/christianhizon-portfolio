import 'package:flutter/material.dart';

import '../../../../core/utils/breakpoints.dart';
import '../widgets/tablet_patients_layout.dart';
import 'patients_list_page.dart';

/// Adaptive shell for patients list/detail layout.
///
/// - Mobile: Shows only the list page
/// - Tablet: Shows   -pane layout with list and detail side by side
class PatientsShell extends StatelessWidget {
  const PatientsShell({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Breakpoints.isTabletOrLarger(context);

    if (isTablet) {
      // Tablet: Two-pane layout
      return const TabletPatientsLayout();
    }

    // Mobile: Just show the list
    return const PatientsListPage();
  }
}
