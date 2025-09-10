import 'package:flutter/material.dart';

class StepperCircle extends StatelessWidget {
  final double circleWidth;
  final int index;
  final bool isCompleted;

  const StepperCircle({
    super.key,
    required this.index,
    required this.isCompleted,
    required this.circleWidth,
  });

  @override
  Widget build(BuildContext context) {
    {
      final Color border =
          isCompleted
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).disabledColor;
      final Color fill =
          isCompleted
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).scaffoldBackgroundColor;
      final Color text =
          isCompleted
              ? Theme.of(context).colorScheme.onTertiary
              : Theme.of(context).disabledColor;

      return Container(
        height: circleWidth,
        width: circleWidth,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: fill,
          border: Border.all(color: border, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          '${index + 1}',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: text),
        ),
      );
    }
  }
}
