import 'package:flutter/material.dart';

class AppErrorHandler {
  /// Handles errors and shows a user-friendly message
  static void handleError(
      BuildContext context, dynamic error, StackTrace? stackTrace) {
    // Log error for debugging
    debugPrint('Error: $error');
    if (stackTrace != null) {
      debugPrint('StackTrace: $stackTrace');
    }

    // Show user-friendly message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('An error occurred. Please try again.'),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  /// Handles database errors specifically
  static void handleDatabaseError(BuildContext context, dynamic error) {
    debugPrint('Database Error: $error');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Database error. Please restart the app.'),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  /// Handles validation errors
  static void handleValidationError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Shows a success message
  static void showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Shows an info message
  static void showInfoMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
