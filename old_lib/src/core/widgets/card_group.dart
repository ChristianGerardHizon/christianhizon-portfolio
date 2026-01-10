import 'package:flutter/material.dart';

class CardGroup extends StatelessWidget {
  final String header;
  final List<Widget> children;

  const CardGroup({
    super.key,
    required this.header,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 0, bottom: 8),
          child: Text(
            header,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(),
          ),
        ),
        Card(
          margin:
              const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
