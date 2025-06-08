import 'dart:io';

import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final Function() onRemove;
  final String imagePath;

  const ImageContainer({
    super.key,
    required this.imagePath,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    print(imagePath);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(7),
          child: SizedBox(
            height: 100,
            width: 100,
            child: InkWell(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                    imagePath.startsWith("http")
                        ? Image.network(imagePath, fit: BoxFit.cover)
                        : Image.file(File(imagePath), fit: BoxFit.cover),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => Scaffold(
                          appBar: AppBar(),
                          body: Image.network(imagePath),
                        ),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: InkWell(
            onTap: onRemove,
            child: Stack(
              children: [
                Icon(
                  Icons.circle,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
                Icon(
                  Icons.do_not_disturb_on,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
