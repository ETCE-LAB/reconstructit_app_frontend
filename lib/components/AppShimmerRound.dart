import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer to indicate a loading state but round e.g. for profile pictures
class AppShimmerRound extends StatelessWidget {
  final double size;

  const AppShimmerRound({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[50]!,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
