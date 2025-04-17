import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/card_ink_well.dart';

class DynamicGroupItem extends StatelessWidget {
  const DynamicGroupItem({
    super.key,
    this.title,
    this.value,
    this.trailing,
    this.titleStyle,
    this.valueStyle,
    this.onTap,
    this.leading,
    this.onLongPress,
    this.highlightTitle = true,
    this.titleColor,
  });

  final String? title;
  final String? value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  final bool highlightTitle;
  final Color? titleColor;

  static DynamicGroupItem action({
    Widget? leading,
    Widget? trailing,
    required String title,
    Color? titleColor,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
  }) {
    return DynamicGroupItem(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: leading,
      title: title,
      highlightTitle: false,
      trailing: trailing,
      titleColor: titleColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CardInkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: ListTile(
        dense: true,
        leading: leading,
        title: title == null
            ? null
            : Text(
                title!,
                style: titleStyle ??
                    (highlightTitle
                            ? theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.primary,
                              )
                            : theme.textTheme.bodyMedium)
                        ?.copyWith(
                      color: titleColor,
                    ),
              ),
        subtitle: value == null
            ? null
            : Text(
                value!,
                style: titleStyle ?? theme.textTheme.bodySmall,
              ),
        trailing: trailing,
      ),
    );
  }
}
