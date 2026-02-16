// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:kreator_frame/config/config.dart';

enum CustomButtonType { filled, tonal, outlined, text }

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final CustomButtonType type;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final String? tooltip;
  final BorderRadius? borderRadius;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.type = CustomButtonType.filled,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.tooltip,
    this.borderRadius,
  });

  factory CustomButton.tonal({
    required VoidCallback? onPressed,
    required String text,
    IconData? icon,
    bool isLoading = false,
    double? width,
    double? height,
    Color? color,
    Color? textColor,
    String? tooltip,
    BorderRadius? borderRadius,
  }) => CustomButton(
    onPressed: onPressed,
    text: text,
    type: CustomButtonType.tonal,
    icon: icon,
    isLoading: isLoading,
    width: width,
    height: height,
    color: color,
    textColor: textColor,
    tooltip: tooltip,
    borderRadius: borderRadius,
  );

  factory CustomButton.outlined({
    required VoidCallback? onPressed,
    required String text,
    IconData? icon,
    bool isLoading = false,
    double? width,
    double? height,
    Color? color,
    Color? textColor,
    String? tooltip,
    BorderRadius? borderRadius,
  }) => CustomButton(
    onPressed: onPressed,
    text: text,
    type: CustomButtonType.outlined,
    icon: icon,
    isLoading: isLoading,
    width: width,
    height: height,
    color: color,
    textColor: textColor,
    tooltip: tooltip,
    borderRadius: borderRadius,
  );

  factory CustomButton.text({
    required VoidCallback? onPressed,
    required String text,
    IconData? icon,
    bool isLoading = false,
    double? width,
    double? height,
    Color? color,
    Color? textColor,
    String? tooltip,
    BorderRadius? borderRadius,
  }) => CustomButton(
    onPressed: onPressed,
    text: text,
    type: CustomButtonType.text,
    icon: icon,
    isLoading: isLoading,
    width: width,
    height: height,
    color: color,
    textColor: textColor,
    tooltip: tooltip,
    borderRadius: borderRadius,
  );

  @override
  Widget build(BuildContext context) {
    final style = _getButtonStyle(context);
    final content = _ButtonContent(
      isLoading: isLoading,
      text: text,
      icon: icon,
      height: height,
    );

    final button = switch (type) {
      CustomButtonType.filled => FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: style,
          child: content,
        ),
      CustomButtonType.tonal => FilledButton.tonal(
          onPressed: isLoading ? null : onPressed,
          style: style,
          child: content,
        ),
      CustomButtonType.outlined => OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: style,
          child: content,
        ),
      CustomButtonType.text => TextButton(
          onPressed: isLoading ? null : onPressed,
          style: style,
          child: content,
        ),
    };

    if (tooltip == null) return button;

    return Tooltip(message: tooltip, child: button);
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final Size minSize = Size(width ?? 0, height ?? 56);

    // Estas son las personalizaciones que queremos aplicar sobre el tema base
    final styleOverrides = ButtonStyle(
      minimumSize: WidgetStateProperty.all(minSize),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: borderRadius ?? AppRadius.radiusMd),
      ),
      // Colores personalizados
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.disabled)) return null;
          return color; // Aplica solo si no está desactivado
        },
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.disabled)) return null;
          return textColor;
        },
      ),
      // Estilo del borde para OutlinedButton
      side: type == CustomButtonType.outlined
          ? WidgetStateProperty.resolveWith<BorderSide?>(
              (states) {
                if (states.contains(WidgetState.disabled)) return null;
                if (color != null) return BorderSide(color: color!);
                return null;
              },
            )
          : null,
    );

    // Obtenemos el estilo del tema y lo combinamos con nuestras personalizaciones
    return switch (type) {
      CustomButtonType.filled =>
        FilledButton.styleFrom().merge(styleOverrides),
      CustomButtonType.tonal =>
        FilledButton.styleFrom().merge(styleOverrides),
      CustomButtonType.outlined =>
        OutlinedButton.styleFrom().merge(styleOverrides),
      CustomButtonType.text => TextButton.styleFrom().merge(styleOverrides),
    };
  }
}

class _ButtonContent extends StatelessWidget {
  final bool isLoading;
  final String text;
  final double? height;
  final IconData? icon;

  const _ButtonContent({
    required this.isLoading,
    required this.text,
    required this.height,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // El color del contenido lo hereda automáticamente del `foregroundColor` del ButtonStyle
    // final contentColor = IconTheme.of(context).color ?? Theme.of(context).colorScheme.primary;

    return AnimatedSwitcher(
      duration: AppDurations.fast,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: isLoading
          ? SizedBox(
              key: const ValueKey('loading'),
              height: (height ?? 56) * 0.5,
              width: (height ?? 56) * 0.5,
              child: const CircularProgressIndicator(
                strokeWidth: 2.5,
                strokeCap: StrokeCap.round,
              ),
            )
          : Row(
              key: const ValueKey('content'),
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: AppIconSizes.md),
                  const Gap(AppSpacing.sm),
                ],
                Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
    );
  }
}
