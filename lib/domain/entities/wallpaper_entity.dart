/// Entity representing a wallpaper.
/// Contains metadata about a downloadable wallpaper.
class WallpaperEntity {
  final String name;
  final String author;
  final String url;
  final String copyright;

  const WallpaperEntity({
    required this.name,
    required this.author,
    required this.url,
    required this.copyright,
  });

  /// Creates a copy of this wallpaper entity with modified fields.
  WallpaperEntity copyWith({
    String? name,
    String? author,
    String? url,
    String? copyright,
  }) {
    return WallpaperEntity(
      name: name ?? this.name,
      author: author ?? this.author,
      url: url ?? this.url,
      copyright: copyright ?? this.copyright,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WallpaperEntity && other.url == url;

  @override
  int get hashCode => url.hashCode;
}