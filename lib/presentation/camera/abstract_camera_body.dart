import 'package:flutter/material.dart';
import 'package:reconstructitapp/presentation/camera/platform_back_button.dart';

/// The image review and the current camera image will be rendered here
/// This Screen is used to keep the same Layout in both screens
class AbstractCameraBody extends StatelessWidget {
  final Widget imagePreview;
  final bool photoTaken;
  final String? imagePath;
  final List<Widget> children;

  const AbstractCameraBody({
    super.key,
    required this.imagePreview,
    required this.photoTaken,
    this.imagePath,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned.fill(child: imagePreview),
          Positioned(top: 50, left: 10, child: PlatformBackButton()),
          Positioned(bottom: 20, child: Row(children: children)),
        ],
      ),
    );
  }
}
