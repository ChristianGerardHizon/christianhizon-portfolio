import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sannjosevet/src/core/widgets/card_ink_well.dart';

class SelectableCard extends HookWidget {
  final bool selected;
  final Widget child;

  final EdgeInsets? margin;

  final Function()? onLongPress;
  final Function()? onTap;

  const SelectableCard({
    Key? key,
    required this.selected,
    required this.child,
    this.onLongPress,
    this.onTap,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final primary = theme.colorScheme.primaryContainer.withValues(alpha: .5);

    return Card(
      surfaceTintColor: theme.colorScheme.primary,
      margin: margin,
      color: selected ? primary : theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: selected ? BorderSide(color: primary, width: 1) : BorderSide.none,
      ),
      child: CardInkWell(
        onLongPress: onLongPress,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
