import 'package:flutter/material.dart';

/// This Button is used as the main button for primary actions when only using an icon
class AppIconButton extends StatelessWidget {
  final Widget icon;
  final void Function()? onPressed;

  const AppIconButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: icon, );
  }
}
