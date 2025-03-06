import 'package:flutter/material.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';

class ToggleFieldItem extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final bool readOnly;
  final bool enabled;
  final Function()? onCancel;
  final bool isCard;
  final EdgeInsets padding;

  const ToggleFieldItem({
    super.key,
    this.title,
    this.leading,
    this.subtitle,
    this.readOnly = false,
    this.enabled = true,
    this.onCancel,
    this.isCard = false,
    this.padding = EdgeInsets.zero,
  });

  static Widget card({
    Widget? title,
    Widget? subtitle,
    Widget? leading,
    bool readOnly = false,
    bool enabled = true,
    EdgeInsets padding = EdgeInsets.zero,
    Function()? onCancel,
  }) {
    return ToggleFieldItem(
      title: title,
      leading: leading,
      subtitle: subtitle,
      readOnly: readOnly,
      enabled: enabled,
      onCancel: onCancel,
      padding: padding,
      isCard: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final borderColor =
        Theme.of(context).inputDecorationTheme.border?.borderSide.color ??
            Colors.grey;

    final content = ListTile(
      leading: leading,
      title: title,
      trailing: !readOnly
          ? IconButton(
              onPressed: enabled ? onCancel : null,
              icon: Icon(MIcons.close),
            )
          : null,
    );
    return Opacity(
      opacity: enabled ? 1 : .5,
      child: Builder(
        builder: (context) {
          ///
          /// card
          ///
          if (isCard) {
            return Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: padding,
                child: content,
              ),
            );
          }

          ///
          /// content
          ///
          return Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: content,
          );
        },
      ),
    );
  }
}
