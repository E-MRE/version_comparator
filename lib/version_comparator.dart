library version_comparator;

import 'src/models/version_response_model.dart';
import 'src/services/abstracts/remote_data_service.dart';
import 'src/services/abstracts/version_convert_service.dart';
import 'src/services/concretes/android/android_version_compare_manager.dart';
import 'src/services/concretes/android/android_version_convert_manager.dart';
import 'src/services/concretes/http_remote_data_manager.dart';
import 'src/services/concretes/huawei/huawei_version_compare_manager.dart';
import 'src/services/concretes/huawei/huawei_version_convert_manager.dart';
import 'src/services/concretes/ios/ios_version_compare_manager.dart';
import 'src/services/concretes/ios/ios_version_convert_manager.dart';
import 'src/utils/constants/constants.dart';
import 'src/utils/enums/app_platform.dart';
import 'src/utils/mixins/package_info_mixin.dart';
import 'src/utils/mixins/platform_decider_mixin.dart';
import 'src/services/abstracts/base_version_comparator.dart';
import 'src/utils/results/data_result.dart';

///The mission of the VersionComparator class is to compare different versions of an app.
///It has two methods: platformSpecificCompare and customCompare.
///The platformSpecificCompare method is used to compare platform-specific versions, such as Android, iOS, and Huawei.
///The customCompare method is used to compare versions with custom settings.
///This method can be used when the project platform is different from Android,
///iOS or Huawei, or when comparing versions from other stores.
class VersionComparator extends BaseVersionComparator with PlatformDeciderMixin, PackageInfoMixin {
  static VersionComparator? _instance;
  static VersionComparator get instance {
    _instance ??= VersionComparator._init();
    return _instance!;
  }

  VersionComparator._init();

  @override
  Future<DataResult<VersionResponseModel>> comparePlatformSpecific({
    String? customAppId,
    VersionConvertService? versionConvertService,
    RemoteDataService? dataService,
  }) async {
    final platform = await getPlatform();
    final bundleResult = await _getBundleWithCustomAppId(customAppId, platform);

    if (bundleResult.isNotSuccess) {
      return DataResult.error(message: bundleResult.message);
    }

    final remoteService = dataService ?? HttpRemoteDataManager();

    switch (platform) {
      case AppPlatform.invalid:
        throw Exception(kErrorMessage.otherPlatformsNotSupported);

      case AppPlatform.android:
        setVersionComparator(AndroidVersionCompareManager(
          versionConvertService: versionConvertService ?? AndroidVersionConvertManager(),
          dataService: remoteService,
          bundleId: bundleResult.data ?? kEmpty,
        ));
        break;

      case AppPlatform.ios:
        setVersionComparator(IosVersionCompareManager(
          versionConvertService: versionConvertService ?? IosVersionConvertManager(),
          dataService: remoteService,
          bundleId: bundleResult.data ?? kEmpty,
        ));
        break;

      case AppPlatform.huawei:
        setVersionComparator(HuaweiVersionCompareManager(
          versionConvertService: versionConvertService ?? HuaweiVersionConvertManager(),
          dataService: remoteService,
          appId: bundleResult.data ?? kEmpty,
        ));
        break;
    }

    return await versionComparator?.getVersion() ?? DataResult.error(message: kErrorMessage.versionComparatorNotSet);
  }

  Future<DataResult<String>> _getBundleWithCustomAppId(String? customAppId, AppPlatform platform) async {
    final bundleResult = await getBundleId();

    bool isBundleNotValid =
        bundleResult.isNotSuccess || bundleResult.data == null || (bundleResult.data?.isEmpty ?? true);

    bool isAppIdNotValid = customAppId == null || customAppId.isEmpty;

    if (isAppIdNotValid && isBundleNotValid) {
      return DataResult.error(message: kErrorMessage.bundleIdAndCustomIdNotValid);
    }

    return platform == AppPlatform.huawei
        ? DataResult.success(data: customAppId ?? bundleResult.data)
        : DataResult.success(data: bundleResult.data ?? customAppId);
  }
}
