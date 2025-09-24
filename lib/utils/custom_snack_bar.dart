import 'package:flutter/material.dart';

/// Snack bar to display failure and successes of interactions
class CustomSnackBar extends StatelessWidget {
  final String message;
  final bool isError;

  const CustomSnackBar._({required this.message, required this.isError});

  factory CustomSnackBar.success({required String successMessage}) {
    return CustomSnackBar._(message: successMessage, isError: false);
  }

  factory CustomSnackBar.failure({required String errorMessage}) {
    return CustomSnackBar._(message: errorMessage, isError: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            !isError
                ? Theme.of(context).colorScheme.tertiary
                : Theme.of(context).colorScheme.errorContainer,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color:
                !isError
                    ? Theme.of(context).colorScheme.onTertiary
                    : Theme.of(context).colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color:
                    !isError
                        ? Theme.of(context).colorScheme.onTertiary
                        : Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
