import 'package:flutter/material.dart';

import '../../../../core/widgets/app_version_indicator.dart';

/// Dashboard footer widget that wraps AppVersionIndicator with padding.
class DashboardFooter extends StatelessWidget {
  const DashboardFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: AppVersionIndicator(),
      ),
    );
  }
}
