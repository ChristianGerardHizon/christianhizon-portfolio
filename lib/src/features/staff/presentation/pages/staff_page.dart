import 'package:flutter/material.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/features/staff/data/staff_repository.dart';
import 'package:gym_system/src/features/staff/presentation/controllers/staff_controller.dart';
import 'package:gym_system/src/features/staff/presentation/controllers/staffs_controller.dart';
import 'package:gym_system/src/features/staff/presentation/widgets/staff_circle_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StaffPage extends HookConsumerWidget {
  final String id;

  const StaffPage(this.id, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = staffControllerProvider(id);
    final state = ref.watch(provider);

    ///
    /// onDelete
    ///
    onDelete() async {
      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;
      final repo = ref.read(staffRepositoryProvider);
      repo.softDeleteMulti([id]).run().then((result) {
            result.fold(
              (l) => AppSnackBar.rootFailure(l),
              (r) {
                ref.invalidate(staffsControllerProvider);
                AppSnackBar.root(message: 'Successfully Deleted');
                PatientsPageRoute().go(context);
              },
            );
          });
    }

    return Scaffold(
      body: state.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (staff) {
          return CustomScrollView(
            slivers: [
              ///
              /// AppBar
              ///
              SliverAppBar(
                leading: BackButton(
                  onPressed: () => StaffsPageRoute().go(context),
                ),
                title: Text(staff.name),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => StaffUpdatePageRoute(id).go(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onDelete(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () => ref.invalidate(provider),
                  )
                ],
              ),

              ///
              /// Picture
              ///
              SliverPadding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 250,
                    child: StaffCircleImage(
                      radius: 120,
                      staff: staff,
                    ),
                  ),
                ),
              ),

              ///
              /// Staff Info
              ///
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverList.list(children: [
                  ///
                  /// Header
                  ///
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 14),
                    title: Text(
                      'Staff Info',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  ///
                  /// name
                  ///
                  ListTile(
                    leading: Text('Name: '),
                    title: Text(staff.name),
                  ),
                ]),
              ),

              ///
              /// Spacer
              ///
              SliverToBoxAdapter(child: SizedBox(height: 50)),
            ],
          );
        },
      ),
    );
  }
}
