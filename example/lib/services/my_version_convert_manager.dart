import 'package:version_comparator/version_comparator.dart';

import '../models/my_version_response_model.dart';

class MyVersionConvertManager extends VersionConvertService<MyVersionResponseModel> {
  @override
  DataResult<String> convert(EntityModel<MyVersionResponseModel> entity) {
    final firstMatch = RegExpHelper.androidVersionRegExp.firstMatch(entity.responseBody);

    return _checkRegExpVersion(firstMatch);
  }

  DataResult<String> _checkRegExpVersion(RegExpMatch? regExpMatch) {
    if (regExpMatch == null || regExpMatch.groupCount < 1) {
      return DataResult.error(message: 'Version not matched');
    }

    final version = regExpMatch.group(1);
    return version == null || version.isEmpty
        ? DataResult.error(message: 'Version not matched')
        : DataResult.success(data: version);
  }
}
