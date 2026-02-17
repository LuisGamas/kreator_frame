// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';
import 'package:kreator_frame/l10n/app_localizations.dart';
import 'package:kreator_frame/presentation/widgets/widgets.dart';

/// A reusable error view widget for displaying error states in async operations.
///
/// Displays a centered error message with optional retry button and customizable styling.
/// Compatible with `AsyncValue.when()` error callback for Riverpod providers.
///
/// Example usage:
/// ```dart
/// asyncValue.when(
///   data: (data) => ListView(...),
///   loading: () => const CircularProgressIndicator(),
///   error: (error, stackTrace) => ErrorView(
///     message: 'Failed to load data',
///     onRetry: () => ref.invalidate(myProvider),
///   ),
/// )
/// ```
class ErrorView extends StatelessWidget {
  /// Custom error message. If null, uses the default localized error message.
  final String? message;

  /// Callback triggered when the retry button is pressed.
  /// If null, no retry button is displayed.
  final VoidCallback? onRetry;

  /// Whether to show the retry button (only shown if [onRetry] is provided).
  final bool showRetry;

  /// Horizontal padding applied to the error text.
  final double horizontalPadding;

  /// Vertical padding applied to the error text.
  final double verticalPadding;

  /// Maximum number of lines for the error message.
  final int maxLines;

  /// Text alignment for the error message.
  final TextAlign textAlign;

  /// Whether the view should be centered vertically as well (useful in full screens).
  final bool centerVertically;

  const ErrorView({
    super.key,
    this.message,
    this.onRetry,
    this.showRetry = true,
    this.horizontalPadding = AppSpacing.md,
    this.verticalPadding = AppSpacing.md,
    this.maxLines = 3,
    this.textAlign = TextAlign.center,
    this.centerVertically = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context)!;
    final errorMessage = message ?? localizations.errorMessage;

    final content = SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Icon
            Icon(
              Hicon.sadOutline,
              size: AppIconSizes.xxxl,
              color: colors.error,
            ),
            const SizedBox(height: AppSpacing.md),

            // Error Message
            Text(
              errorMessage,
              textAlign: textAlign,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: textStyles.bodyLarge,
            ),

            // Retry Button
            if (onRetry != null && showRetry) ...[
              const SizedBox(height: AppSpacing.lg),
              CustomButton(
                text: 'Retry',
                width: 140,
                onPressed: onRetry!,
              ),
            ],
          ],
        ),
      ),
    );

    if (centerVertically) {
      return Center(child: content);
    }
    return content;
  }
}
