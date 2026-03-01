import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/breadcrumb_nav.dart';
import '../../../../core/widgets/state/error_state.dart';
import '../../../portfolio/presentation/controllers/profile_controller.dart';
import '../widgets/profile_form.dart';

/// Admin page for editing the portfolio profile.
class AdminProfilePage extends ConsumerWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorState(
          message: 'Failed to load profile',
          onRetry: () => ref.invalidate(profileControllerProvider),
        ),
        data: (profile) => ProfileForm(profile: profile).withBreadcrumbs(),
      ),
    );
  }
}
