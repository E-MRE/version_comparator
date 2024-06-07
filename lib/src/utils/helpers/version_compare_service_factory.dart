import '../../services/abstracts/remote_data_service.dart';
import '../../services/abstracts/version_compare_service.dart';
import '../../services/concretes/android/android_version_compare_manager.dart';
import '../../services/concretes/android/android_version_convert_manager.dart';
import '../../services/concretes/huawei/huawei_version_compare_manager.dart';
import '../../services/concretes/ios/ios_version_compare_manager.dart';
import '../constants/constants.dart';
import '../enums/app_platform.dart';

class VersionCompareServiceFactory {
  final AppPlatform platform;

  VersionCompareServiceFactory({required this.platform});

  VersionCompareService getCompareService({
    required RemoteDataService dataService,
    required String bundleId,
  }) {
    switch (platform) {
      case AppPlatform.invalid:
        throw Exception(kErrorMessage.otherPlatformsNotSupported);

      case AppPlatform.android:
        return AndroidVersionCompareManager(
          versionConvertService: AndroidVersionConvertManager(),
          dataService: dataService,
          bundleId: bundleId,
        );

      case AppPlatform.ios:
        return IosVersionCompareManager(
            dataService: dataService, bundleId: bundleId);

      case AppPlatform.huawei:
        return HuaweiVersionCompareManager(
            dataService: dataService, appId: bundleId);

      default:
        throw Exception(kErrorMessage.unHandledAppPlatformException);
    }
  }
}
