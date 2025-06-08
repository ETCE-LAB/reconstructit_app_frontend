import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
