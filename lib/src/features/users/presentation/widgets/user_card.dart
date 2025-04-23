import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/selectable_card.dart';
import 'package:gym_system/src/features/users/domain/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
    required this.onLongPress,
    required this.onTap,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final bool selected;
  final User user;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      margin: EdgeInsets.all(8),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: selected,
      child: ListTile(
          leading: Icon(Icons.abc),
          title: Text(user.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name),
            ],
          )),
    );
  }
}
