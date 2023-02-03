import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import '../constants/constants.dart';
import '../enums/app_platform.dart';

mixin PlatformDeciderMixin {
  Future<AppPlatform> getPlatform() async {
    if (Platform.isIOS) return AppPlatform.ios;
    if (!Platform.isAndroid) return AppPlatform.invalid;

    final deviceInfo = DeviceInfoPlugin();
    final info = await deviceInfo.androidInfo;

    return info.manufacturer.toUpperCase() == kHuaweiManufacturer.toUpperCase()
        ? AppPlatform.huawei
        : AppPlatform.android;
  }
}
