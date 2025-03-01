import 'package:flutter/material.dart';
import 'package:gym_system/src/core/extensions/string.dart';

class DynamicListTile extends StatelessWidget {
  final Widget? title;
  final Widget content;
  final bool forceSubtitle;
  final EdgeInsets? contentPadding;
  final Function()? onTap;
  final Widget? leading;

  const DynamicListTile({
    Key? key,
    this.title,
    required this.content,
    this.forceSubtitle = false,
    this.contentPadding,
    this.onTap,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Estimate if content fits in trailing
        final textPainter = TextPainter(
          text: TextSpan(
              text: (content is Text) ? (content as Text).data : '',
              style: TextStyle(fontSize: 16.0)),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(maxWidth: constraints.maxWidth * 0.4);

        bool fitsInTrailing = textPainter.didExceedMaxLines == false;
        bool useSubtitle = forceSubtitle || !fitsInTrailing;

        final contentStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            );

        return ListTile(
          onTap: onTap,
          leading: leading,
          contentPadding: contentPadding,
          titleTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).hintColor,
                fontWeight: FontWeight.w500,
              ),
          leadingAndTrailingTextStyle: contentStyle,
          title: title,
          trailing: useSubtitle
              ? null
              : ConstrainedBox(
                  constraints:
                      BoxConstraints(maxWidth: constraints.maxWidth * 0.4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: content,
                  ),
                ),
          subtitle: useSubtitle
              ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: constraints.maxWidth * 0.9),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Builder(
                        builder: (context) {
                          if (content is Text) {
                            final text = (content as Text);
                            return Text(text.data.optional(),
                                style: contentStyle);
                          }
                          return content;
                        },
                      ),
                    ),
                  ),
                )
              : null,
          isThreeLine: useSubtitle,
        );
      },
    );
  }
}
