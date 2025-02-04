import 'package:version_comparator/src/services/concretes/android/android_version_compare_manager.dart';
import 'package:version_comparator/src/services/concretes/huawei/huawei_version_compare_manager.dart';
import 'package:version_comparator/src/services/concretes/ios/ios_version_compare_manager.dart';
import 'package:version_comparator/src/utils/constants/constants.dart';
import 'package:version_comparator/version_comparator.dart';

class VersionCompareServiceFactory {
  final AppPlatform platform;

  VersionCompareServiceFactory({required this.platform});

  VersionCompareService getCompareService({
    required RemoteDataService dataService,
    required String bundleId,
  }) {
    switch (platform) {
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

      case AppPlatform.web:
      case AppPlatform.linux:
      case AppPlatform.macOs:
      case AppPlatform.windows:
      case AppPlatform.invalid:
        throw Exception(kErrorMessage.unHandledAppPlatformException);
    }
  }
}
