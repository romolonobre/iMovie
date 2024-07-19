import 'package:flutter/material.dart';
import 'package:imovie_app/app/commons/extensions/extensions.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final int itemCount;

  const ShimmerLoading({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[700]!,
          highlightColor: Colors.grey[500]!,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 70,
            color: Colors.grey[700],
          ).borderRadius(10).paddingOnly(left: 20, right: 20),
        );
      }),
    );
  }
}
