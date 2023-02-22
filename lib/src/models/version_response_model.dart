import '../utils/mixins/version_compare_mixin.dart';

class VersionResponseModel with VersionCompareMixin {
  /// The current version of the app.
  final String localVersion;

  /// The most recent version of the app in the store.
  final String storeVersion;

  /// A link to the app store page where the app can be updated.
  final String updateLink;

  ///result of compared versions between [localVersion] and [storeVersion]
  bool get isAppVersionOld => isCurrentVersionOld(currentVersion: localVersion, storeVersion: storeVersion);

  VersionResponseModel({
    required this.localVersion,
    required this.storeVersion,
    required this.updateLink,
  });
}
