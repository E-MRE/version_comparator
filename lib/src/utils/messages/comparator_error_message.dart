///Version Comparator error messages.
abstract class ComparatorErrorMessage {
  /// 'App isn\'t found in the store. Please check your bundle and try again.'
  String get appNotFound =>
      'App isn\'t found in the store. Please check your bundle and try again.';

  /// 'Downloaded app version can\'t fetch.'
  String get appVersionFetchError => 'Downloaded app version can\'t fetch.';

  /// 'Downloaded app bundle id can\'t fetch.'
  String get appBundleIdFetchError => 'Downloaded app bundle id can\'t fetch.';

  /// 'Version information is not found in the response'
  String get versionNotMatch =>
      'Version information is not found in the response';

  /// 'Url can\'t launch'
  String get notLaunchUrl => 'Url can\'t launch';

  /// 'Version comparator service is not set. You must set it!'
  String get versionComparatorNotSet =>
      'Version comparator service is not set. You must set it!';

  /// 'Others platforms are not supported'
  String get otherPlatformsNotSupported => 'Others platforms are not supported';

  /// 'You must add Huawei Store App Id for compare versions'
  String get huaweiAppIdNullOrEmpty =>
      'You must add Huawei Store App Id for compare versions';

  /// 'App bundle Id and custom app Id are not valid. Version compare is not possible'
  String get bundleIdAndCustomIdNotValid =>
      'App bundle Id and custom app Id are not valid. Version compare is not possible';

  /// 'This app platform is not handled'
  String get unHandledAppPlatformException =>
      'This app platform is not handled';

  ///If data is null than this message displays.
  String get versionResponseNull => 'Data is null. App version can\'t compare';
}
