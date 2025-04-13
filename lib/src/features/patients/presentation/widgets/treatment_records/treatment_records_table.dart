import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/patients/domain/patient_treatment_record.dart';
import 'package:material_table_view/material_table_view.dart';
import 'package:material_table_view/sliver_table_view.dart';

class PatientTreatmentRecordsTable extends HookWidget {
  final List<PatientTreatmentRecord> list;
  final List<int> selected;
  final Function(List<int>)? onSelected;
  final Function(int)? onRowTap;

  const PatientTreatmentRecordsTable({
    super.key,
    required this.list,
    required this.selected,
    this.onSelected,
    this.onRowTap,
  });

  @override
  Widget build(BuildContext context) {
    bool? mainCheckboxStatus(
        List<PatientTreatmentRecord> list, List<int> selected) {
      if (selected.isEmpty) {
        return false;
      }
      if (selected.length == list.length) {
        return true;
      }
      return null;
    }

    void onMainCheckboxChange(bool? value) {
      if (value != null) {
        onSelected?.call(List.generate(list.length, (index) => index));
        return;
      }

      onSelected?.call([]);
    }

    void onCellSelect(int index, bool? value) {
      final list = selected;
      if (value == true) {
        list..add(index);
      } else {
        list..remove(index);
      }

      onSelected?.call(list.toSet().toList());
    }

    return SliverTableView.builder(
      columns: [
        const TableColumn(width: 56.0, freezePriority: 100),
        const TableColumn(width: 180),
        const TableColumn(width: 180),
        const TableColumn(width: 180),
        const TableColumn(width: 180),
        // const TableColumn(width: 120),
        // TableColumn(width: 56.0, freezePriority: 100),
      ],

      headerBuilder: (context, contentBuilder) {
        return contentBuilder(
          context,
          (context, column) {
            switch (column) {
              case 0:
                return Checkbox(
                  tristate: true,
                  value: mainCheckboxStatus(list, selected),
                  onChanged: onMainCheckboxChange,
                );
              case 1:
                return Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Date',
                    style: TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              case 2:
                return Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Follow Up Date',
                    style: TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              case 3:
                return Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Type',
                    style: TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              case 4:
                return Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Notes',
                    style: TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              default:
                return SizedBox();
            }
          },
        );
      },
      rowCount: list.length,
      rowHeight: 56.0,
      rowBuilder: (context, row, contentBuilder) {
        // if (noDataYetFor(row)) {
        //   return null; // to use a placeholder
        // }

        final record = list[row];

        return InkWell(
          onTap: () {
            onRowTap?.call(row);
          },

          ///
          /// Content
          ///
          child: contentBuilder(
            context,
            (context, column) {
              switch (column) {
                case 0:
                  return Checkbox(
                      value: selected.contains(row),
                      onChanged: (value) => onCellSelect(row, value));
                case 1:
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      (record.date?.yyyyMMddHHmm())
                          .optional(placeholder: 'N/A'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                case 2:
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      (record.followUpDate?.yyyyMMddHHmm())
                          .optional(placeholder: 'N/A'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                case 3:
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      (record.expand?.type?.name).optional(placeholder: 'N/A'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                case 4:
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      (record.notes).optional(placeholder: 'N/A'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                default:
                  return Align(
                    alignment: Alignment.center,
                    child: Icon(MIcons.arrowRight, size: 18),
                  );
              }
            }, // build a cell widget
          ),
        );
      },
      // specify other parameters for other features
    );
  }
}
