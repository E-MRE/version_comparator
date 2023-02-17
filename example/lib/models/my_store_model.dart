import 'package:version_comparator/version_comparator.dart';

class MyStoreModel extends BaseStoreModel {
  @override
  final String appId;

  MyStoreModel({required this.appId});

  @override
  String get storeUrl => 'YOUR_CUSTOM_STORE_URL_WITH_ENDPOINT';

  @override
  String get versionQuery => 'QUERY_OF_STORE_URL_FOR_COMPARE';
}
