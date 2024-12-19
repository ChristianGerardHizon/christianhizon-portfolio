import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double? rating;

  const StarRating({super.key, this.rating});

  @override
  Widget build(BuildContext context) {
    if (rating == null) {
      return const Text("No rating");
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        IconData icon;
        if (index < rating!.floor()) {
          icon = Icons.star; // Full star
        } else if (index < rating!.ceil() && rating! % 1 != 0) {
          icon = Icons.star_half; // Half star
        } else {
          icon = Icons.star_border; // Empty star
        }

        return Icon(
          icon,
          color: Colors.amber,
        );
      }),
    );
  }
}
