import 'package:flutter/material.dart';

import 'custom_snack_bar.dart';

/// Presents the custom snack bars
class Presenter {
  Presenter._internal();

  factory Presenter() => _singleton;

  static final Presenter _singleton = Presenter._internal();

  /// Handles progress failures errors in presentation layer
  /// [context] - Current BuildContext
  /// [error] - Error to be handled
  void presentFailure(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomSnackBar.failure(
          errorMessage: "Das hat leider nicht geklappt",
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  /// Handles successes in presentation layer
  /// [context] - Current BuildContext
  /// [successMessage] - Message displayed from the snackbar
  void presentSuccess(BuildContext context, String successMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomSnackBar.success(successMessage: successMessage),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
