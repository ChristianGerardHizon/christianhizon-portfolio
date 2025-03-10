import 'package:flutter/material.dart';

class ResponsiveRowColumn extends StatelessWidget {
  final Widget first;
  final Widget second;
  final double breakpoint;

  const ResponsiveRowColumn({
    Key? key,
    required this.first,
    required this.second,
    this.breakpoint = 600, // Default breakpoint for switching layout
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > breakpoint) {
          // If the screen width is greater than the breakpoint, use Row
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: first),
              Expanded(child: second),
            ],
          );
        } else {
          // Otherwise, use Column
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              first,
              SizedBox(height: 10), // Add spacing between widgets
              second,
            ],
          );
        }
      },
    );
  }
}
