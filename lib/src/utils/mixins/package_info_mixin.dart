import 'package:package_info_plus/package_info_plus.dart';

import '../enums/error_message.dart';
import '../results/data_result.dart';

mixin PackageInfoMixin {
  Future<DataResult<String>> getCurrentAppVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return info.version.isEmpty
          ? DataResult.byErrorMessageEnum(error: ErrorMessage.appVersionFetchError)
          : DataResult.success(data: info.version);
    } catch (exception) {
      return DataResult.byErrorMessageEnum(error: ErrorMessage.appVersionFetchError);
    }
  }

  Future<DataResult<String>> getBundleId() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return info.packageName.isEmpty
          ? DataResult.byErrorMessageEnum(error: ErrorMessage.appBundleIdFetchError)
          : DataResult.success(data: info.packageName);
    } catch (exception) {
      return DataResult.byErrorMessageEnum(error: ErrorMessage.appBundleIdFetchError);
    }
  }
}
