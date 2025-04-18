// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class AppHelpers {
  /// Shows a success snackbar with the given message and color scheme.
  ///
  /// A snackbar with a green background color and white text is shown. The
  /// message is styled with a max line count of 2 and an ellipsis overflow.
  /// The snackbar is shown at the bottom of the screen and auto-hides after 4s.
  ///
  /// - [context]: The build context to use to show the snackbar.
  /// - [message]: The message to be displayed in the snackbar.
  /// - [color]: The color scheme to use for styling the snackbar.
  static void showSnackbarSuccess({
    required BuildContext context,
    required String message,
    required ColorScheme color,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
          SnackBar(
            elevation: 5,
            behavior: SnackBarBehavior.floating,
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
        )
      );
  }

  /// Shows an error snackbar with the given message and color scheme.
  ///
  /// A snackbar with a primary container background color and text styled
  /// with onPrimaryContainer color is shown. The message is styled to
  /// display a maximum of 2 lines with an ellipsis overflow. The snackbar
  /// includes a close icon and is displayed at the bottom of the screen.
  ///
  /// - [context]: The build context to use to show the snackbar.
  /// - [message]: The message to be displayed in the snackbar.
  /// - [color]: The color scheme to use for styling the snackbar.
  static void showSnackbarError({
    required BuildContext context,
    required String message,
    required ColorScheme color,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
          SnackBar(
            elevation: 5,
            behavior: SnackBarBehavior.floating,
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
        )
      );
  }
}
