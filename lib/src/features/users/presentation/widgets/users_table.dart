import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/users/domain/user.dart';
import 'package:gym_system/src/features/users/presentation/widgets/user_circle_image.dart';
import 'package:material_table_view/material_table_view.dart';
import 'package:material_table_view/sliver_table_view.dart';

class UsersTable extends HookWidget {
  final List<User> list;
  final List<int> selected;
  final Function(List<int>)? onSelected;
  final Function(int)? onRowTap;

  const UsersTable({
    super.key,
    required this.list,
    required this.selected,
    this.onSelected,
    this.onRowTap,
  });

  @override
  Widget build(BuildContext context) {
    bool? mainCheckboxStatus(List<User> list, List<int> selected) {
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
        const TableColumn(width: 60),
        const TableColumn(width: 150),
        const TableColumn(width: 120),
        TableColumn(width: 56.0, freezePriority: 100),
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
                    'Picture',
                    style: TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              case 2:
                return Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              case 3:
                return Align(
                    alignment: Alignment.centerLeft,
                    child: const Text('Email',
                        style: TextStyle(fontWeight: FontWeight.w600)));
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

        final user = list[row];

        return InkWell(
          onTap: () {
            onRowTap?.call(row);
          },
          child: contentBuilder(
            context,
            (context, column) {
              switch (column) {
                case 0:
                  return Checkbox(
                      value: selected.contains(row),
                      onChanged: (value) => onCellSelect(row, value));
                case 1:
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: UserCircleImage(radius: 120, user: user),
                  );
                case 2:
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      user.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                case 3:
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      user.email,
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
