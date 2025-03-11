import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/features/prescription/data/prescription_item_repository.dart';
import 'package:gym_system/src/features/prescription/domain/prescription_item.dart';
import 'package:gym_system/src/features/prescription/domain/prescription_search.dart';
import 'package:gym_system/src/features/prescription/presentation/controllers/prescription_item_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prescription_items_controller.g.dart';

@riverpod
class PrescriptionItemsController extends _$PrescriptionItemsController {
  String _buildFilter({
    String? patientId,
    PrescriptionItemSearch? params,
  }) {
    final baseFilter = '${PrescriptionItemField.isDeleted} = false';

    final medicationFilter = Option.of(params?.diagnosis)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${PrescriptionItemField.medication} ~ "$q"');

    final result = [
      medicationFilter,
      Some(baseFilter),
    ].whereType<Some<String>>().map((some) => some.value).join(' && ');

    return result;
  }

  @override
  Future<PageResults<PrescriptionItem>> build({String? id}) async {
    final pageState = ref.watch(prescriptionItemsPageControllerProvider);
    final repo = ref.read(prescriptionItemRepositoryProvider);
    final searchParams = ref.watch(prescriptionItemSearchControllerProvider);
    final result = await repo
        .list(
          filter: _buildFilter(patientId: id, params: searchParams),
          pageNo: pageState.page,
          pageSize: pageState.pageSize,
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
