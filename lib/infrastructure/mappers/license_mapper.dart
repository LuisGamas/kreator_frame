import 'package:kreator_frame/domain/domain.dart';

class LicenseMapper {
  static LicenseEntity dataToEntity({
    required String packageName,
    required List<String> licenses,
  }) => LicenseEntity(
    name: packageName,
    licenses: licenses,
    licenseCount: licenses.length,
  );
}
