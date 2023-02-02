import '../utils/mixins/version_compare_mixin.dart';

class VersionResponseModel with VersionCompareMixin {
  /// The current version of the app.
  final String appVersion;

  /// The most recent version of the app in the store.
  final String storeVersion;

  /// A link to the app store page where the app can be updated.
  final String updateLink;

  ///result of compared versions between [appVersion] and [storeVersion]
  bool get isAppVersionOld => isCurrentVersionOld(currentVersion: appVersion, storeVersion: storeVersion);

  VersionResponseModel({
    required this.appVersion,
    required this.storeVersion,
    required this.updateLink,
  });
}
