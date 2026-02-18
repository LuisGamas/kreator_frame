// 🐦 Flutter imports:
import 'package:flutter/material.dart';

/// Utility class for displaying snackbars with consistent styling.
/// Provides predefined success and error snackbar patterns.
class SnackbarHelpers {
  SnackbarHelpers._();

  /// Displays a success snackbar with green color scheme.
  ///
  /// Shows a snackbar with a green background (primaryContainer) and white text.
  /// The message is styled with a maximum of 2 lines and ellipsis overflow.
  /// The snackbar is shown at the bottom of the screen and includes a close icon.
  ///
  /// Parameters:
  /// - [context]: The build context to use to show the snackbar.
  /// - [message]: The message to be displayed in the snackbar.
  /// - [color]: The color scheme to use for styling the snackbar.
  static void showSuccess({
    required BuildContext context,
    required String message,
    required ColorScheme color,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: color.primaryContainer,
          showCloseIcon: true,
          closeIconColor: color.onPrimaryContainer,
          content: Text(
            message,
            style: TextStyle(color: color.onPrimaryContainer),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
      );
  }

  /// Displays an error snackbar with red color scheme.
  ///
  /// Shows a snackbar with a red background (errorContainer) and appropriate text color.
  /// The message is styled with a maximum of 2 lines and ellipsis overflow.
  /// The snackbar is shown at the bottom of the screen and includes a close icon.
  ///
  /// Parameters:
  /// - [context]: The build context to use to show the snackbar.
  /// - [message]: The message to be displayed in the snackbar.
  /// - [color]: The color scheme to use for styling the snackbar.
  static void showError({
    required BuildContext context,
    required String message,
    required ColorScheme color,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: color.errorContainer,
          showCloseIcon: true,
          closeIconColor: color.onErrorContainer,
          content: Text(
            message,
            style: TextStyle(color: color.onErrorContainer),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
      );
  }
}
