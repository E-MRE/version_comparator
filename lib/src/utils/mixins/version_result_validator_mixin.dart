import '../../models/version_response_model.dart';
import '../constants/constants.dart';
import '../results/data_result.dart';
import '../results/result.dart';

mixin VersionResultValidatorMixin {
  Result isVersionResultValid(DataResult<VersionResponseModel> result) {
    if (result.isNotSuccess) {
      return Result.error(
          message: result.message.isEmpty
              ? kErrorMessage.appNotFound
              : result.message);
    } else if (result.data == null) {
      return Result.error(
          message: result.message.isEmpty
              ? kErrorMessage.versionResponseNull
              : result.message);
    }

    return Result.success();
  }
}
