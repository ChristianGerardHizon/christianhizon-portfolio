import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';

class DetailTile extends StatelessWidget {
  const DetailTile({
    super.key,
    this.title,
    this.titleWidget,
    this.subtitle,
    this.subtitleWidget,
    this.subtitleTextAlign = TextAlign.left,
    this.onTap,
    this.isCopyable = true,
    this.trailing,
  });

  final String? title;
  final Widget? titleWidget;
  final String? subtitle;
  final Widget? subtitleWidget;
  final TextAlign? subtitleTextAlign;
  final Function()? onTap;
  final bool isCopyable;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    ///
    ///
    ///
    toClipboard() {
      if (subtitleWidget != null) return;
      if (subtitle == null) return;
      Clipboard.setData(ClipboardData(text: subtitle.toString()));
      AppSnackBar.show(context, message: 'success');
    }

    return ListTile(
      onLongPress: isCopyable ? toClipboard : null,
      onTap: onTap,
      minTileHeight: 0,
      minVerticalPadding: 8,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18),
      trailing: trailing,
      title: titleWidget ??
          Text(
            title ?? '-',
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
      subtitle: subtitleWidget ??
          Text(
            subtitle ?? '-',
            textAlign: subtitleTextAlign,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
    );
  }
}
