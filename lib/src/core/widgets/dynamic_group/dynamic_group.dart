import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group_item.dart';

class DynamicGroup extends StatelessWidget {
  const DynamicGroup({
    super.key,
    required this.header,
    this.titleStyle,
    required this.items,
    this.helper,
    this.padding = EdgeInsets.zero,
  });

  final String header;
  final String? helper;
  final TextStyle? titleStyle;
  final List<DynamicGroupItem> items;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: padding.horizontal, bottom: 12),
            width: double.infinity,
            child: Text(
              header.toUpperCase(),
              style: titleStyle ??
                  Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
            ),
          ),
          Card(
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
