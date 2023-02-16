import 'package:package_info_plus/package_info_plus.dart';
import 'package:version_comparator/src/utils/constants/constants.dart';

import '../results/data_result.dart';

mixin PackageInfoMixin {
  Future<DataResult<String>> getCurrentAppVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return info.version.isEmpty
          ? DataResult.error(message: kErrorMessage.appVersionFetchError)
          : DataResult.success(data: info.version);
    } catch (exception) {
      return DataResult.error(message: kErrorMessage.appVersionFetchError);
    }
  }

  Future<DataResult<String>> getBundleId() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return info.packageName.isEmpty
          ? DataResult.error(message: kErrorMessage.appBundleIdFetchError)
          : DataResult.success(data: info.packageName);
    } catch (exception) {
      return DataResult.error(message: kErrorMessage.appBundleIdFetchError);
    }
  }
}
