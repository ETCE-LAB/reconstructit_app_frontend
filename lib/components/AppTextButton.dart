import 'package:flutter/material.dart';

/// Button used for secondary or tertiary actions without background color
class AppTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const AppTextButton({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    ), child: child,);
  }
}
