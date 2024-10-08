class LicenseEntity {
  final String name;
  final String description;
  final String? homepage;
  final String? repository;
  final List<String> authors;
  final String version;
  final String license;
  final bool isMarkdown;
  final bool isSdk;

  LicenseEntity({
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
}
