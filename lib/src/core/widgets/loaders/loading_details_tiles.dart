import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/loaders/detail_tile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingDetailsTiles extends StatelessWidget {
  final int count;

  const LoadingDetailsTiles({super.key, this.count = 5});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.zone(
        child: ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: count,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return const DetailTile(
          titleWidget: Padding(
            padding: EdgeInsets.only(top: 4),
            child: Bone.text(),
          ),
          subtitleWidget: Padding(
            padding: EdgeInsets.only(top: 4),
            child: Bone.text(words: 2),
          ),
        );
      },
    ));
  }
}
