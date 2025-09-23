import 'package:flutter/material.dart';
import 'package:reconstructitapp/presentation/print_contract/local_components/stepper_circle.dart';

class OpenStep {
  final Widget title;
  final Widget? content;
  final bool isCompleted;

  const OpenStep({required this.title, this.content, this.isCompleted = false});
}

class OpenAllStepper extends StatelessWidget {
  final List<OpenStep> steps;
  final Color? activeColor;

  const OpenAllStepper({super.key, required this.steps, this.activeColor});

  @override
  Widget build(BuildContext context) {
    final double circleWidth = 34;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: steps.length,
      itemBuilder: (context, index) {
        final step = steps[index];
        final bool isLast = index == steps.length - 1;

        return Column(
          spacing: 10.0,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10,
              children: [
                StepperCircle(
                  index: index,
                  isCompleted: step.isCompleted,
                  circleWidth: circleWidth,
                ),
                Flexible(child: Column(children: [step.title])),
              ],
            ),

            // text and content
            Padding(
              padding: EdgeInsets.only(left: circleWidth /2, bottom: 5),
              child: IntrinsicHeight(child:Row(
                children: [
                  if (!isLast)
                    Container(
                      width: 3.0,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                   SizedBox(width:  circleWidth /2+10),
                  Expanded(child: step.content ?? const SizedBox(height: 10)),
                ],
              ),

            )),
          ],
        );
      },
    );
  }
}
