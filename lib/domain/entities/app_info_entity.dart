/// Entity representing application information.
/// Contains metadata about the application like version and package name.
class AppInfoEntity {
  final String appName;
  final String packageName;
  final String packageVersion;
  final String buildNumber;

  const AppInfoEntity({
    required this.appName,
    required this.packageName,
    required this.packageVersion,
    required this.buildNumber,
  });

  /// Creates a copy of this app info entity with modified fields.
  AppInfoEntity copyWith({
    String? appName,
    String? packageName,
    String? packageVersion,
    String? buildNumber,
  }) {
    return AppInfoEntity(
      appName: appName ?? this.appName,
      packageName: packageName ?? this.packageName,
      packageVersion: packageVersion ?? this.packageVersion,
      buildNumber: buildNumber ?? this.buildNumber,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppInfoEntity &&
          other.packageName == packageName &&
          other.packageVersion == packageVersion &&
          other.buildNumber == buildNumber;

  @override
  int get hashCode =>
      packageName.hashCode ^
      packageVersion.hashCode ^
      buildNumber.hashCode;
}