import '../../services/abstracts/base_version_comparator.dart';
import '../constants/constants.dart';
import '../enums/app_platform.dart';
import '../extensions/string_extension.dart';
import '../results/data_result.dart';

mixin BundleIdControllerMixin on BaseVersionComparator {
  Future<DataResult<String>> getBundleByOptionalId({
    String? androidId,
    String? iosId,
    String? huaweiId,
    required AppPlatform platform,
  }) async {
    if (platform == AppPlatform.android && androidId.isNotNullAndNotEmpty) {
      return DataResult.success(data: androidId);
    } else if (platform == AppPlatform.ios && iosId.isNotNullAndNotEmpty) {
      return DataResult.success(data: iosId);
    } else if (platform == AppPlatform.huawei) {
      return huaweiId.isNotNullAndNotEmpty
          ? DataResult.success(data: huaweiId)
          : DataResult.error(message: kErrorMessage.huaweiAppIdNullOrEmpty);
    }

    final bundleResult = await getBundleId();

    bool isBundleNotValid =
        bundleResult.isNotSuccess || bundleResult.data == null || (bundleResult.data?.isEmpty ?? true);

    if (isBundleNotValid) {
      return DataResult.error(message: kErrorMessage.bundleIdAndCustomIdNotValid);
    }

    return bundleResult;
  }
}
