import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/stack_loader.dart';
import 'package:sannjosevet/src/features/patients/core/presentation/controllers/patient_controller.dart';
import 'package:sannjosevet/src/features/patients/core/presentation/controllers/patient_table_controller.dart';
import 'package:sannjosevet/src/features/products/core/data/product_repository.dart';
import 'package:sannjosevet/src/features/products/core/domain/product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductDetailsView extends HookConsumerWidget {
  const ProductDetailsView(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// loading variable
    ///
    final isLoading = useState(false);

    ///
    /// repo
    ///
    final repo = ref.read(productRepositoryProvider);

    ///
    /// refresh
    ///
    refresh(String id) {
      ref.invalidate(patientTableControllerProvider);
      ref.invalidate(patientControllerProvider(id));
    }

    ///
    /// on tap
    ///
    editProduct(Product product) {
      ProductFormPageRoute(id: product.id).push(context);
    }

    addStockAdjustment(Product product) {
      ProductAdjustmentFormPageRoute(productId: product.id).push(context);
    }

    ///
    /// onDelete
    ///
    onDelete(Product product) async {
      final fullTask = await
          // 1. Call Confirm Modal
          ConfirmModal.taskResult(context)
              // 2. Delete Network Call
              .flatMap((_) => repo.softDeleteMulti([product.id]))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulDeleteTaskSidEffects(
                  context: context,
                  productId: product.id,
                  refresh: refresh,
                ),
              );

      isLoading.value = true;
      final result = await fullTask.run();
      isLoading.value = false;

      // 4. Handle Error
      result.match(
        (failure) => _handleFailure(context, failure),
        (_) {},
      );
    }

    return StackLoader(
      isLoading: isLoading.value,
      child: CustomScrollView(
        slivers: [
          ///
          /// Content
          ///
          SliverList.list(
            children: [
              SizedBox(height: 20),

              ///
              /// Information
              ///
              DynamicGroup(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                header: 'Product Information',
                items: [
                  DynamicGroupItem.text(
                    title: 'Name',
                    value: product.name,
                  ),
                  DynamicGroupItem.text(
                    title: 'Description',
                    value: product.description.optional(),
                  ),
                  DynamicGroupItem.text(
                    title: 'Category',
                    value: (product.expand.category?.name).optional(),
                  ),
                  DynamicGroupItem.text(
                    title: 'Branch',
                    value: (product.expand.branch?.name).optional(),
                  ),
                  DynamicGroupItem.text(
                    title: 'Last Updated',
                    value: (product.updated?.toLocal().fullReadable).optional(),
                  ),
                  DynamicGroupItem.text(
                    title: 'Created',
                    value: (product.created?.toLocal().fullReadable).optional(),
                  ),
                ],
              ),

              ///
              /// Tracking
              ///
              DynamicGroup(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                header: 'Product Tracking',
                items: [
                  DynamicGroupItem.text(
                    title: 'Is Tracked By Lot',
                    value: product.trackByLot ? 'Yes' : 'No',
                  ),
                  DynamicGroupItem.text(
                    title: 'Stock Warning',
                    value: product.stockThreshold.toString(),
                  ),
                  if (!product.trackByLot) ...[
                    DynamicGroupItem.text(
                      title: 'Quantity',
                      value: (product.quantity.toString()).optional(),
                    ),
                    DynamicGroupItem.text(
                      title: 'Expiration',
                      value: (product.expiration?.toLocal().fullReadable)
                          .optional(),
                    )
                  ],
                ],
              ),

              ///
              /// Actions
              ///
              DynamicGroup(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
                header: 'Actions',
                items: [
                  DynamicGroupItem.action(
                    onTap: () => editProduct(product),
                    leading: Icon(MIcons.fileEditOutline),
                    title: 'Edit Details',
                    trailing: Icon(MIcons.chevronRight),
                  ),
                  if (!product.trackByLot)
                    DynamicGroupItem.action(
                      onTap: () => addStockAdjustment(product),
                      leading: Icon(MIcons.cubeOutline),
                      title: 'Adjust Stock',
                      trailing: Icon(MIcons.chevronRight),
                    ),
                  DynamicGroupItem.action(
                    titleColor: Theme.of(context).colorScheme.error,
                    onTap: () => onDelete(product),
                    leading: Icon(
                      MIcons.trashCan,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    title: 'Delete',
                    trailing: Icon(MIcons.chevronRight),
                  ),
                ],
              ),

              ///
              /// Spacer
              ///
              SizedBox(height: 50),
            ],
          )
        ],
      ),
    );
  }
}

///
/// Handles post-delete side effects like showing snackbar,
/// popping navigation, and refreshing local state.
///
TaskResult<void> _handleSuccessfulDeleteTaskSidEffects({
  required BuildContext context,
  required String productId,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Deleted');
    if (context.canPop()) context.pop();
    refresh(productId);
    return null;
  }).toTaskEither<Failure>();
}

///
/// Handles Failure
/// Shows a snackbar when a failure occurs
///
void _handleFailure(BuildContext context, Failure failure) {
  if (failure is CancelledFailure) return;
  AppSnackBar.rootFailure(failure);
}
