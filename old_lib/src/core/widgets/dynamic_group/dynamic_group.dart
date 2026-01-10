import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_group/dynamic_group_item.dart';

class DynamicGroup extends StatelessWidget {
  const DynamicGroup({
    super.key,
    this.header,
    this.titleStyle,
    this.headerAction,
    required this.items,
    this.helper,
    this.padding = EdgeInsets.zero,
  });

  final String? header;
  final Widget? headerAction;
  final String? helper;
  final TextStyle? titleStyle;
  final List<DynamicGroupItem> items;
  final EdgeInsetsGeometry padding;

  static sliver({
    required String header,
    Widget? headerAction,
    TextStyle? titleStyle,
    required List<DynamicGroupItem> items,
    String? helper,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) =>
      SliverToBoxAdapter(
        child: DynamicGroup(
          headerAction: headerAction,
          header: header,
          titleStyle: titleStyle,
          items: items,
          helper: helper,
          padding: padding,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        children: [
          /// header
          Container(
            margin: EdgeInsets.only(left: 8, bottom: 12),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (header != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      header!,
                      style: titleStyle ??
                          Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                if (headerAction != null) headerAction!,
              ],
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: ListView.separated(
                itemCount: items.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => Divider(
                  indent: 16,
                  endIndent: 16,
                  height: 1,
                ),
                itemBuilder: (context, index) => items[index],
              ),
            ),
          ),
          if (helper != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child:
                  Text(helper!, style: Theme.of(context).textTheme.bodySmall),
            ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
