class LicenseModel {
  final String name;
  final String description;
  final String? homepage;
  final String? repository;
  final List<String> authors;
  final String version;
  final String license;
  final bool isMarkdown;
  final bool isSdk;

  LicenseModel({
    required this.name,
    required this.description,
    this.homepage,
    this.repository,
    required this.authors,
    required this.version,
    required this.license,
    required this.isMarkdown,
    required this.isSdk,
  });

  factory LicenseModel.fromJson(Map<String, dynamic> json) {
    return LicenseModel(
      name: json["name"] ?? 'No name found',
      description: json["description"] ?? 'No description found',
      homepage: json["homepage"],
      repository: json["repository"],
      authors: json["authors"] != null
          ? List<String>.from(json["authors"].map((author) => author.toString()))
          : [],
      version: json["version"] ?? 'No version found',
      license: _processLicenseText(json["license"] ?? 'No license found'),
      isMarkdown: json["isMarkdown"] ?? false,
      isSdk: json["isSdk"] ?? false,
    );
  }

  static String _processLicenseText(String licenseText) {
    final lines = licenseText.split('\n');
    final processedLines = <String>[];
    bool inUppercaseBlock = false;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      
      if (line.startsWith('*')) {
        if (i > 0 && processedLines.isNotEmpty && !processedLines.last.endsWith('\n')) {
          processedLines.add('\n');
        }
        processedLines.add('$line\n');
      } else if (line == line.toUpperCase() && line.isNotEmpty) {
        if (!inUppercaseBlock && i > 0) {
          processedLines.add('\n');
        }
        processedLines.add(line.replaceAll(RegExp(r'\s+'), ' '));
        inUppercaseBlock = true;
      } else {
        if (inUppercaseBlock) {
          processedLines.add('\n');
          inUppercaseBlock = false;
        }
        if (line.isNotEmpty) {
          processedLines.add('$line ');
        }
      }
    }

    return processedLines.join('').trim();
  }
}
