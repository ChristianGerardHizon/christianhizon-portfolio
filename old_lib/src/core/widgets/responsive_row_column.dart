import 'package:flutter/material.dart';

class ResponsiveRowColumn extends StatelessWidget {
  final Widget first;
  final Widget? second;
  final double breakpoint;
  final MainAxisAlignment columnMainAxisAlignment;
  final MainAxisAlignment rowMainAxisAlignment;

  const ResponsiveRowColumn({
    Key? key,
    required this.first,
    this.second,
    this.breakpoint = 600, // Default breakpoint for switching layout
    this.columnMainAxisAlignment = MainAxisAlignment.center,
    this.rowMainAxisAlignment = MainAxisAlignment.spaceEvenly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > breakpoint) {
          // If the screen width is greater than the breakpoint, use Row
          return Row(
            mainAxisAlignment: rowMainAxisAlignment,
            children: [
              Expanded(child: first),
              if (second != null) Expanded(child: second!),
            ],
          );
        } else {
          // Otherwise, use Column
          return Column(
            mainAxisAlignment: columnMainAxisAlignment,
            children: [
              first,
              if (second != null) ...[
                SizedBox(height: 10),
                second!
              ], // Add spacing between widgets
            ],
          );
        }
      },
    );
  }
}
