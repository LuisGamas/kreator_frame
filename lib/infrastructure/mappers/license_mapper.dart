import 'package:kreator_frame/domain/domain.dart';
import 'package:kreator_frame/infrastructure/infrastructure.dart';

class LicenseMapper {
  static LicenseEntity modelToEntity(LicenseModel model) => LicenseEntity(
    name: model.name,
    description: model.description,
    homepage: model.homepage,
    repository: model.repository,
    authors: model.authors,
    version: model.version,
    license: model.license,
    isMarkdown: model.isMarkdown,
    isSdk: model.isSdk,
  );
}
