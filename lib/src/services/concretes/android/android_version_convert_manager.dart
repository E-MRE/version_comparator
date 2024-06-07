import '../../../models/entities/empty_entity_model.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/helpers/regexp_helper.dart';
import '../../../utils/results/data_result.dart';
import '../../abstracts/version_convert_service.dart';

class AndroidVersionConvertManager
    extends VersionConvertService<EmptyEntityModel> {
  @override
  DataResult<String> convert(EmptyEntityModel entity) {
    final firstMatch =
        RegExpHelper.androidVersionRegExp.firstMatch(entity.responseBody);

    return _checkRegExpVersion(firstMatch);
  }
}

DataResult<String> _checkRegExpVersion(RegExpMatch? regExpMatch) {
  if (regExpMatch == null || regExpMatch.groupCount < 1) {
    return DataResult.error(message: kErrorMessage.versionNotMatch);
  }

  final version = regExpMatch.group(1);
  return version == null || version.isEmpty
      ? DataResult.error(message: kErrorMessage.versionNotMatch)
      : DataResult.success(data: version);
}
