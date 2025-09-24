import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// A Navigate back button adjusted for the given platform (android/ios)
/// Used when there is no normal AppBar widget
class PlatformBackButton extends StatelessWidget {
  final Color? color;

  const PlatformBackButton({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Platform.isIOS
          ? Icon(CupertinoIcons.back, color: color ?? Colors.black)
          : Icon(Icons.arrow_back, color: color ?? Colors.black),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
