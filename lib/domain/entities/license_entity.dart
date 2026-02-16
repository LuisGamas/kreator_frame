/// Entity representing an open source license.
/// Contains information about a library/package and its associated licenses.
class LicenseEntity {
  final String name;
  final List<String> licenses;
  final int licenseCount;

  LicenseEntity({
    required this.name,
    required this.licenses,
    required this.licenseCount,
  });

  /// Creates a copy of this license entity with modified fields.
  LicenseEntity copyWith({
    String? name,
    List<String>? licenses,
    int? licenseCount,
  }) {
    return LicenseEntity(
      name: name ?? this.name,
      licenses: licenses ?? this.licenses,
      licenseCount: licenseCount ?? this.licenseCount,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LicenseEntity && other.name == name;

  @override
  int get hashCode => name.hashCode;
}
