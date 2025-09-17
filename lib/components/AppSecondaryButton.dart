import 'package:flutter/material.dart';

import 'AppButton.dart';

/// This Button is Used for secondary actions e.g. cancel an action
class AppSecondaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const AppSecondaryButton({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Theme.of(context).colorScheme.surface,
          onPrimary: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: AppButton(onPressed: onPressed, child: child),
    );
  }
}
