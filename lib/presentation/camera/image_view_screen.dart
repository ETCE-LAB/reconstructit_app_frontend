import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reconstructitapp/components/app_icon_button.dart';

import 'abstract_camera_body.dart';

/// This screen shows the chosen picture via the [imagePath]
/// Screen provides three actions:
/// - retake the photo with [retakeImage]
/// - use this image and call [toNextScreenWithImage]
/// - not use the image and don't retake it with [toNextScreenWithoutImage]
///   if = null the opportunity to skip is not given
class ImageViewScreen extends StatelessWidget {
  final String imagePath;
  final Function toNextScreenWithImage;
  final Function? toNextScreenWithoutImage;
  final Function retakeImage;

  const ImageViewScreen({
    super.key,
    required this.imagePath,
    required this.toNextScreenWithImage,
    this.toNextScreenWithoutImage,
    required this.retakeImage,
  });

  @override
  Widget build(BuildContext context) {
    return  AbstractCameraBody(
        imagePreview: Image.file(File(imagePath), fit: BoxFit.fitHeight),
        photoTaken: true,
        imagePath: imagePath,

        children: [
          AppIconButton(
            onPressed: () {
              retakeImage();
            },
            icon: const Icon(Icons.rotate_left_rounded, size: 42),
          ),
          const SizedBox(width: 40),
          AppIconButton(
            onPressed: () {
              toNextScreenWithImage();
            },
            icon: const Icon(Icons.check, size: 42),
          ),
        ],

    );
  }
}
