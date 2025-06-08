import 'package:flutter/material.dart';
import 'package:reconstructitapp/components/AppButton.dart';

class StartBodyWidget extends StatelessWidget {
  final void Function(int index) updateIndex;
  final int index;
  final String imagePath;
  final String description;
  final void Function() onPressed;

  const StartBodyWidget({
    super.key,
    required this.imagePath,
    required this.description,
    required this.onPressed,
    required this.index,
    required this.updateIndex,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          // image
          Expanded(child: Image.asset(imagePath, width: width, fit: BoxFit.contain,)),

          // Dot indicator
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 57),
            child: Column(
              spacing: 20.0,
              children: [
                Text(
                  description,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        updateIndex(0);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color:
                              index == 0
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(
                                    context,
                                  ).colorScheme.outlineVariant,
                        ),
                        height: index == 0 ? 7 : 5,
                        width: index == 0 ? 7 : 5,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        updateIndex(1);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color:
                              index == 1
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(
                                    context,
                                  ).colorScheme.outlineVariant,
                        ),
                        height: index == 1 ? 7 : 5,
                        width: index == 1 ? 7 : 5,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        updateIndex(2);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color:
                              index == 2
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(
                                    context,
                                  ).colorScheme.outlineVariant,
                        ),
                        height: index == 2 ? 7 : 5,
                        width: index == 2 ? 7 : 5,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        updateIndex(3);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color:
                              index == 3
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(
                                    context,
                                  ).colorScheme.outlineVariant,
                        ),
                        height: index == 3 ? 7 : 5,
                        width: index == 3 ? 7 : 5,
                      ),
                    ),
                  ],
                ),
                AppButton(onPressed: onPressed, child: Text("Jetzt starten")),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
