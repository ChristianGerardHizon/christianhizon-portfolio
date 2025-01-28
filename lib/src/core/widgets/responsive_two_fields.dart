import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveTwoFields extends StatelessWidget {
  final List<Widget> children;
  final double? verticalGap;
  final double? horizontalGap;

  const ResponsiveTwoFields(
      {super.key,
      required this.children,
      this.verticalGap,
      this.horizontalGap});

  @override
  Widget build(BuildContext context) {
    List<Widget> addGap(bool isHorizontal, List<Widget> list, double? gap) {
      if (gap != null) {
        list = list.mapWithIndex((e, index) {
          if (list.length <= 1) return e;
          return index == list.length - 1
              ? e
              : Padding(
                  padding: isHorizontal
                      ? EdgeInsets.only(bottom: gap)
                      : EdgeInsets.only(right: gap),
                  child: e);
        }).toList();
      }
      return list;
    }

    return ResponsiveBuilder(builder: (context, si) {
      ///
      /// One Cloumn
      ///
      if (si.isMobile) {
        return Column(
          children:
              addGap(true, children, horizontalGap).map((e) => e).toList(),
        );
      }

      ///
      ///  Two Columns
      ///
      return Row(
        children: addGap(false, children, verticalGap)
            .map((e) => Expanded(child: e))
            .toList(),
      );
    });
  }
}
