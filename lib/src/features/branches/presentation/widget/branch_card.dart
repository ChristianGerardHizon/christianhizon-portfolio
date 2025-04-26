import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/selectable_card.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';

class BranchCard extends StatelessWidget {
  const BranchCard({
    super.key,
    required this.branch,
    required this.onLongPress,
    required this.onTap,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final bool selected;
  final Branch branch;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      margin: EdgeInsets.all(8),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: selected,
      child: ListTile(
          leading: Icon(Icons.abc),
          title: Text(branch.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(branch.name),
            ],
          )),
    );
  }
}
