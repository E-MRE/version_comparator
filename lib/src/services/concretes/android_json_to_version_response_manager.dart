import 'dart:convert';

import '../../utils/enums/error_message.dart';
import '../../utils/helpers/regexp_helper.dart';
import '../../utils/results/data_result.dart';
import '../abstracts/json_to_version_response_service.dart';

class AndroidJsonToVersionResponseManager extends JsonToVersionResponseService {
  @override
  DataResult<String> convert(Map<String, String> json) {
    final firstMatch = RegExpHelper.androidVersionRegExp.firstMatch(jsonEncode(json));

    if (firstMatch == null || firstMatch.groupCount < 2) {
      return DataResult.byErrorMessageEnum(error: ErrorMessage.versionNotMatch);
    }

    final version = firstMatch.group(1);
    return version == null || version.isEmpty
        ? DataResult.byErrorMessageEnum(error: ErrorMessage.versionNotMatch)
        : DataResult.success(data: version);
  }
}
