class WallpaperModel {
  final List<Wallpaper> wallpapers;

  WallpaperModel({
    required this.wallpapers,
  });

  // * Factory constructor to create a WallpaperModel instance from JSON data.
  factory WallpaperModel.fromJson(Map<String, dynamic> json) => WallpaperModel(
    wallpapers: List<Wallpaper>.from(
        json["wallpapers"].map((x) => Wallpaper.fromJson(x))),
  );

  // * Converts the WallpaperModel instance to a JSON format.
  Map<String, dynamic> toJson() => {
    "wallpapers": List<dynamic>.from(wallpapers.map((x) => x.toJson())),
  };
}

class Wallpaper {
  final String url;
  final String name;
  final String author;
  final String copyright;

  Wallpaper({
    required this.url,
    required this.name,
    required this.author,
    required this.copyright,
  });

  // * Factory constructor to create a Wallpaper instance from JSON data.
  factory Wallpaper.fromJson(Map<String, dynamic> json) => Wallpaper(
    url: json["url"],
    name: json["name"],
    author: json["author"],
    copyright: json["copyright"],
  );

  // * Converts the Wallpaper instance to a JSON format.
  Map<String, dynamic> toJson() => {
    "url": url,
    "name": name,
    "author": author,
    "copyright": copyright,
  };
}
