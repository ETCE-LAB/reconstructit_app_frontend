import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final int? minLines;
  final int? maxLines;
  final Color? backgroundColor;
  final Widget? trailing;
  final String hint;
  final TextEditingController? controller;

  const AppTextField({
    super.key,
    this.controller,
    required this.hint,
    this.trailing,
    this.backgroundColor,
     this.minLines,
     this.maxLines=1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:
            backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextField(
              minLines: minLines,
              maxLines: maxLines,
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                fillColor:
                    backgroundColor ??
                    Theme.of(context).colorScheme.surfaceContainer,
                contentPadding: EdgeInsets.all(16),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),

                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.5,
                    color: Colors.grey ?? Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.5,
                    color: Theme.of(context).primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
