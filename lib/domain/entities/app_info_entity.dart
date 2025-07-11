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
}