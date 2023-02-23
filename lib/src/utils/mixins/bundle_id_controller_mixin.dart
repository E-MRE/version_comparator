import '../../services/abstracts/base_version_comparator.dart';
import '../constants/constants.dart';
import '../enums/app_platform.dart';
import '../results/data_result.dart';

mixin BundleIdControllerMixin on BaseVersionComparator {
  Future<DataResult<String>> getBundleWithCustomAppId(String? customAppId, AppPlatform platform) async {
    final bundleResult = await getBundleId();

    bool isBundleNotValid =
        bundleResult.isNotSuccess || bundleResult.data == null || (bundleResult.data?.isEmpty ?? true);

    bool isAppIdNotValid = customAppId == null || customAppId.isEmpty;

    if (isAppIdNotValid && isBundleNotValid) {
      return DataResult.error(message: kErrorMessage.bundleIdAndCustomIdNotValid);
    }

    return DataResult.success(data: customAppId ?? bundleResult.data);
  }
}
