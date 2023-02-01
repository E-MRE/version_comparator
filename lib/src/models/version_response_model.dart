import '../utils/mixins/version_converter_mixin.dart';

class VersionResponseModel with VersionConverterMixin {
  /// The current version of the app.
  final String appVersion;

  /// The most recent version of the app in the store.
  final String storeVersion;

  /// A link to the app store page where the app can be updated.
  final String updateLink;

  ///result of compared versions between [appVersion] and [storeVersion]
  bool get isAppVersionOld {
    final convertedAppVersion = convertToInt(appVersion);
    final convertedStoreVersion = convertToInt(appVersion);

    return convertedAppVersion < convertedStoreVersion;
  }

  VersionResponseModel({
    required this.appVersion,
    required this.storeVersion,
    required this.updateLink,
  });
}
