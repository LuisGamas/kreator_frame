// 🎯 Dart imports:
import 'dart:typed_data';

/// Entity representing a widget (KWGT or KLWP).
/// Contains information about a widget and its thumbnail preview.
class WidgetEntity {
  final String nameWidget;
  final String nameDeveloper;
  final Uint8List widgetThumbnail;

  WidgetEntity({
    required this.nameWidget,
    required this.nameDeveloper,
    required this.widgetThumbnail,
  });

  /// Creates a copy of this widget entity with modified fields.
  WidgetEntity copyWith({
    String? nameWidget,
    String? nameDeveloper,
    Uint8List? widgetThumbnail,
  }) {
    return WidgetEntity(
      nameWidget: nameWidget ?? this.nameWidget,
      nameDeveloper: nameDeveloper ?? this.nameDeveloper,
      widgetThumbnail: widgetThumbnail ?? this.widgetThumbnail,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WidgetEntity && other.nameWidget == nameWidget;

  @override
  int get hashCode => nameWidget.hashCode;
}
