import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmerRectangular extends StatelessWidget {
  final double width;
  final double height;

  const AppShimmerRectangular({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[50]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
