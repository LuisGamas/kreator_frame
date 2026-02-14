// 🐦 Flutter imports:
import 'package:flutter/material.dart';

/// A standardized circular progress indicator used throughout the app.
///
/// Wraps [CircularProgressIndicator] with [StrokeCap.round] as the default
/// stroke cap. Optionally wraps in a [SizedBox] when [size] is provided.
///
/// Supports both determinate (with [value]) and indeterminate progress.
class AppCircularProgressIndicator extends StatelessWidget {
  /// Optional fixed size for the indicator. When provided, the indicator
  /// is wrapped in a [SizedBox] with this height and width.
  final double? size;

  /// Optional progress value between 0.0 and 1.0. When null, the indicator
  /// displays indeterminate progress.
  final double? value;

  /// The width of the circular line. Defaults to 4.0.
  final double strokeWidth;

  const AppCircularProgressIndicator({
    super.key,
    this.size,
    this.value,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    final indicator = CircularProgressIndicator(
      value: value,
      strokeCap: StrokeCap.round,
      strokeWidth: strokeWidth,
    );

    if (size != null) {
      return SizedBox(
        height: size,
        width: size,
        child: indicator,
      );
    }

    return indicator;
  }
}
