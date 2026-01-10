import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/extensions/num.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/features/products/adjustments/presentation/widgets/product_adjustment_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/sliver_dynamic_table_view.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/dynamic_table_column.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/core/strings/table_controller_keys.dart';
import 'package:sannjosevet/src/features/products/adjustments/domain/product_adjustment.dart';
import 'package:sannjosevet/src/features/products/adjustments/presentation/controllers/product_adjustment_table_controller.dart';
import 'package:sannjosevet/src/core/widgets/refresh_button.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';

class ProductAdjustmentsPage extends HookConsumerWidget {
  const ProductAdjustmentsPage(
      {Key? key, this.productId, this.productStockId, this.showAppBar = true})
      : super(key: key);

  final String? productId;
  final String? productStockId;
  final bool showAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchCtrl = useTextEditingController();
    final tableKey = TableControllerKeys.product;
    final provider = tableControllerProvider(tableKey);
    final notifier = ref.read(provider.notifier);
    final listProvider = productAdjustmentTableControllerProvider(
      tableKey,
      productId: productId,
      productStockId: productStockId,
    );
    final listState = ref.watch(listProvider);

    void onRefresh() {
      ref.invalidate(productAdjustmentTableControllerProvider);
      ref.invalidate(provider);
      notifier.clearSelection();
    }

    void onDelete(List<ProductAdjustment> items) async {
      // Implement delete logic/modal as needed
    }

    void onCreate() {
      // Implement navigation to create form
    }

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: const Text('Product Adjustments'),
              actions: [
                RefreshButton(onPressed: onRefresh),
              ],
            )
          : null,
      body: SliverDynamicTableView<ProductAdjustment>(
        tableKey: tableKey,
        error: FailureMessage.asyncValue(listState),
        isLoading: listState.isLoading,
        items: listState.value ?? [],
        onDelete: onDelete,
        onRowTap: (item) {},
        searchCtrl: searchCtrl,
        onCreate: onCreate,
        columns: [
          DynamicTableColumn(
            header: 'Date',
            width: 180,
            builder: (context, data, row, column) => Center(
                child: Text((data.created?.toLocal().fullDateTime).optional())),
          ),
          DynamicTableColumn(
            header: 'Reason',
            width: 200,
            builder: (context, data, row, column) => Align(
              alignment: Alignment.center,
              child: Text(data.reason.optional()),
            ),
          ),
          DynamicTableColumn(
            header: 'Value',
            width: 120,
            builder: (context, data, row, column) {
              return Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: '${data.oldValue} ',
                      ),
                      const TextSpan(text: '-> '),
                      TextSpan(text: data.newValue.optional()),
                    ],
                  ),
                ),
              );
            },
          ),
          // TableColumn(
          //   header: 'Actions',
          //   width: 120,
          //   builder: (context, data, row, column) =>
          //       const Icon(Icons.more_horiz),
          // ),
        ],
        mobileBuilder: (context, index, productAdjustment, selected) {
          return ProductAdjustmentCard(
            productAdjustment: productAdjustment,
            selected: selected,
            onTap: () {
              if (selected) {
                notifier.toggleRow(index);
              } else {
                // Implement navigation or selection logic here if needed
              }
            },
            onLongPress: () {
              notifier.toggleRow(index);
            },
          );
        },
      ),
    );
  }
}
