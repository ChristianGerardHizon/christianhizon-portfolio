import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../pos/data/dto/sale_dto.dart';
import '../../../pos/domain/order_status.dart';
import '../../../pos/domain/sale.dart';
import '../../../settings/presentation/controllers/current_branch_controller.dart';

part 'kanban_sales_controller.g.dart';

/// Sales grouped by order status for the kanban board.
class KanbanSalesData {
  const KanbanSalesData({
    required this.pending,
    required this.processing,
    required this.ready,
    required this.pickedUp,
  });

  final List<Sale> pending;
  final List<Sale> processing;
  final List<Sale> ready;
  final List<Sale> pickedUp;

  /// Returns the sales list for a given status.
  List<Sale> salesForStatus(OrderStatus status) => switch (status) {
        OrderStatus.pending => pending,
        OrderStatus.processing => processing,
        OrderStatus.ready => ready,
        OrderStatus.pickedUp => pickedUp,
      };

  /// Total count of all sales.
  int get totalCount =>
      pending.length + processing.length + ready.length + pickedUp.length;
}

/// Fetches all active sales (non-voided) grouped by order status.
/// Filtered by current branch, sorted by most recent first.
@riverpod
Future<KanbanSalesData> kanbanSales(Ref ref) async {
  final branchId = ref.watch(currentBranchIdProvider);
  final pb = ref.read(pocketbaseProvider);

  var filter = "status != 'voided'";
  if (branchId != null) {
    filter = '$filter && branch = "$branchId"';
  }

  final records =
      await pb.collection(PocketBaseCollections.sales).getFullList(
            filter: filter,
            sort: '-created',
          );

  final sales =
      records.map((record) => SaleDto.fromRecord(record).toEntity()).toList();

  return KanbanSalesData(
    pending: sales.where((s) => s.orderStatus == OrderStatus.pending).toList(),
    processing:
        sales.where((s) => s.orderStatus == OrderStatus.processing).toList(),
    ready: sales.where((s) => s.orderStatus == OrderStatus.ready).toList(),
    pickedUp:
        sales.where((s) => s.orderStatus == OrderStatus.pickedUp).toList(),
  );
}
