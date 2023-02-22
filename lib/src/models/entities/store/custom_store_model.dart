import 'base_store_model.dart';

///This class includes store information of app.
///[appId] it's app bundle id or specific id for access to the app.
///
///[versionQuery] it will be use for access to the app in the store.
///If your app link doesn't have query just fill with empty character.
///
///[storeUrl] is includes custom app store link (base url + endpoint)
///
///Example:
///
///```
///CustomStoreModel(
///  //!(Base url and endpoint)
///  storeUrl: 'https://play.google.com/store/apps/details',
/// //!Sometimes query can be different
///  versionQuery: 'id=com.example.bundle',
///  //!bundleId or app id in the app store.
///  appId: 'com.example.bundle',
///);
///```
class CustomStoreModel extends BaseStoreModel {
  @override

  ///Store url without query. Base url and endpoint.
  ///For example (https://play.google.com/store/apps/details)
  final String storeUrl;

  @override

  ///App bundle id or specific id for store.
  ///For example: com.example.bundleId
  ///If you don't need to the appId just pass with empty character
  final String appId;

  @override

  ///It will using to get version of your app in the store.
  ///For example: id=com.example.id
  ///If you don't need to the appId just pass with empty character
  final String versionQuery;

  CustomStoreModel({
    required this.storeUrl,
    required this.appId,
    required this.versionQuery,
  });
}
