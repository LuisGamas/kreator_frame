// 🐦 Flutter imports:
import 'package:flutter/material.dart';

enum CustomIconButtonType { standard, filled, tonal, outlined }

class CustomIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final CustomIconButtonType type;
  final bool isLoading;
  final double? iconSize;
  final double? buttonSize;
  final Color? color; // Color de fondo o borde
  final Color? iconColor; // Color del icono/loader personalizado
  final String? tooltip;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.type = CustomIconButtonType.standard,
    this.isLoading = false,
    this.iconSize,
    this.buttonSize,
    this.color,
    this.iconColor,
    this.tooltip,
  });

  // Constructores nombrados para mayor claridad
  factory CustomIconButton.filled({
    required VoidCallback? onPressed,
    required IconData icon,
    bool isLoading = false,
    double? iconSize,
    double? buttonSize,
    Color? color, // Color de fondo o borde
    Color? iconColor, // Color del icono/loader personalizado
    String? tooltip,
  }) => CustomIconButton(
    onPressed: onPressed,
    icon: icon,
    type: CustomIconButtonType.filled,
    isLoading: isLoading,
    iconSize: iconSize,
    buttonSize: buttonSize,
    color: color,
    iconColor: iconColor,
    tooltip: tooltip,
  );

  factory CustomIconButton.tonal({
    required VoidCallback? onPressed,
    required IconData icon,
    bool isLoading = false,
    double? iconSize,
    double? buttonSize,
    Color? color, // Color de fondo o borde
    Color? iconColor, // Color del icono/loader personalizado
    String? tooltip,
  }) => CustomIconButton(
    onPressed: onPressed,
    icon: icon,
    type: CustomIconButtonType.tonal,
    isLoading: isLoading,
    iconSize: iconSize,
    buttonSize: buttonSize,
    color: color,
    iconColor: iconColor,
    tooltip: tooltip,
  );

  factory CustomIconButton.outlined({
    required VoidCallback? onPressed,
    required IconData icon,
    bool isLoading = false,
    double? iconSize,
    double? buttonSize,
    Color? color, // Color de fondo o borde
    Color? iconColor, // Color del icono/loader personalizado
    String? tooltip,
  }) => CustomIconButton(
    onPressed: onPressed,
    icon: icon,
    type: CustomIconButtonType.outlined,
    isLoading: isLoading,
    iconSize: iconSize,
    buttonSize: buttonSize,
    color: color,
    iconColor: iconColor,
    tooltip: tooltip,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // 1. Resolvemos el color del contenido (Icono y Loader)
    final Color effectiveIconColor = _getIconColor(colors);

    // 2. Resolvemos el estilo del botón
    final ButtonStyle style = _getButtonStyle(colors);

    // 3. El contenido con animación de cambio
    final Widget content = AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: isLoading
          ? SizedBox(
              key: const ValueKey('loading'),
              width: iconSize ?? 24,
              height: iconSize ?? 24,
              child: CircularProgressIndicator(
                color: effectiveIconColor,
                strokeWidth: 2.5,
                strokeCap: StrokeCap.round,
              ),
            )
          : Icon(
              icon,
              key: const ValueKey('icon'),
              size: iconSize,
              color: effectiveIconColor,
            ),
    );

    // 4. Retorno según el tipo de IconButton de Material 3
    return switch (type) {
      CustomIconButtonType.filled => IconButton.filled(
        onPressed: isLoading ? null : onPressed,
        style: style,
        icon: content,
        tooltip: tooltip,
      ),
      CustomIconButtonType.tonal => IconButton.filledTonal(
        onPressed: isLoading ? null : onPressed,
        style: style,
        icon: content,
        tooltip: tooltip,
      ),
      CustomIconButtonType.outlined => IconButton.outlined(
        onPressed: isLoading ? null : onPressed,
        style: style,
        icon: content,
        tooltip: tooltip,
      ),
      CustomIconButtonType.standard => IconButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        icon: content,
        tooltip: tooltip,
      ),
    };
  }

  ButtonStyle _getButtonStyle(ColorScheme colors) {
    // Si se definió un tamaño de botón, lo aplicamos a las restricciones
    final double? size = buttonSize;
    final visualDensity = size != null ? VisualDensity.compact : null;

    return switch (type) {
      CustomIconButtonType.filled => IconButton.styleFrom(
        backgroundColor: color, // null usa primary por defecto
        minimumSize: size != null ? Size(size, size) : null,
        visualDensity: visualDensity,
      ),
      CustomIconButtonType.tonal => IconButton.styleFrom(
        backgroundColor: color, // null usa secondaryContainer por defecto
        minimumSize: size != null ? Size(size, size) : null,
        visualDensity: visualDensity,
      ),
      CustomIconButtonType.outlined => IconButton.styleFrom(
        side: color != null ? BorderSide(color: color!) : null,
        minimumSize: size != null ? Size(size, size) : null,
        visualDensity: visualDensity,
      ),
      CustomIconButtonType.standard => IconButton.styleFrom(
        foregroundColor: color,
        minimumSize: size != null ? Size(size, size) : null,
        visualDensity: visualDensity,
      ),
    };
  }

  Color _getIconColor(ColorScheme colors) {
    if (iconColor != null) return iconColor!;

    return switch (type) {
      CustomIconButtonType.filled =>
        color != null
            ? (ThemeData.estimateBrightnessForColor(color!) == Brightness.dark
                  ? Colors.white
                  : Colors.black)
            : colors.onPrimary,
      CustomIconButtonType.tonal => colors.onSecondaryContainer,
      CustomIconButtonType.outlined ||
      CustomIconButtonType.standard => color ?? colors.primary,
    };
  }
}
