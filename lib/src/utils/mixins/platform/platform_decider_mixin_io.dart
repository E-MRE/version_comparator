import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:version_comparator/src/utils/constants/constants.dart';
import 'package:version_comparator/version_comparator.dart';

/// This mixin decides which platform runs app.
mixin PlatformDeciderMixin {
  /// Determines the platform on which the app is running.
  ///
  /// This method checks the current platform and returns the corresponding
  /// [AppPlatform] enum value. It supports Android, iOS, Linux, macOS, and
  /// Windows platforms. For Android, it further checks if the device
  /// manufacturer is Huawei and returns [AppPlatform.huawei] if true.
  ///
  /// Returns:
  /// - [AppPlatform.android] if the platform is Android and the manufacturer
  ///   is not Huawei.
  /// - [AppPlatform.huawei] if the platform is Android and the manufacturer
  ///   is Huawei.
  /// - [AppPlatform.ios] if the platform is iOS.
  /// - [AppPlatform.linux] if the platform is Linux.
  /// - [AppPlatform.macOs] if the platform is macOS.
  /// - [AppPlatform.windows] if the platform is Windows.
  /// - [AppPlatform.invalid] if the platform is none of the above.
  ///
  /// Throws:
  /// - Any exceptions thrown by the underlying platform detection or device
  ///   info retrieval mechanisms.
  Future<AppPlatform> getPlatform() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final info = await deviceInfo.androidInfo;

      return info.manufacturer.toUpperCase() ==
              kHuaweiManufacturer.toUpperCase()
          ? AppPlatform.huawei
          : AppPlatform.android;
    }

    if (Platform.isIOS) {
      return AppPlatform.ios;
    }

    if (Platform.isLinux) {
      return AppPlatform.linux;
    }

    if (Platform.isMacOS) {
      return AppPlatform.macOs;
    }

    if (Platform.isWindows) {
      return AppPlatform.windows;
    }

    return AppPlatform.invalid;
  }
}
