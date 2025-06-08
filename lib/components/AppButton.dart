import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const AppButton({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onPressed, style: ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    ), child: child,);
  }
}
