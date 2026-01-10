import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CollapsingCard extends HookWidget {
  final Widget header;
  final Widget child;
  final Widget? subtitle;
  final bool expanded;
  final bool canCollapse;
  final EdgeInsets? contentPadding;
  final EdgeInsets? cardMargin;

  const CollapsingCard({
    super.key,
    required this.header,
    this.subtitle,
    required this.child,
    this.expanded = true,
    this.canCollapse = true,
    this.contentPadding,
    this.cardMargin,
  });

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState<bool>(canCollapse ? expanded : true);

    return Card(
      margin:
          cardMargin ?? const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Padding(
        padding: isExpanded.value
            ? const EdgeInsets.only(bottom: 10)
            : EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                  bottomLeft: Radius.circular(isExpanded.value ? 0 : 10),
                  bottomRight: Radius.circular(isExpanded.value ? 0 : 10),
                ),
              ),
              onTap: canCollapse
                  ? () => isExpanded.value = !isExpanded.value
                  : null,
              minTileHeight: 0,
              contentPadding: contentPadding ??
                  EdgeInsets.only(
                    top: 10,
                    left: 16,
                    right: 16,
                    bottom: !isExpanded.value ? 10 : 10,
                  ),
              title: header,
              subtitle: subtitle,
              trailing: canCollapse
                  ? AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      firstChild: Transform.rotate(
                        angle: 0,
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                      secondChild: Transform.rotate(
                        angle: 3.14,
                        child: const Icon(Icons.keyboard_arrow_down),
                      ),
                      crossFadeState: isExpanded.value
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                    )
                  : const SizedBox(),
            ),
            Visibility(
              visible: isExpanded.value,
              child: const Divider(height: 1),
            ),
            isExpanded.value ? child : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
