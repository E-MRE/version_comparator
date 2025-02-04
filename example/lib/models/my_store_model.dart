import 'package:version_comparator/version_comparator.dart';

class MyStoreModel extends BaseStoreModel {
  @override
  final String appId;

  MyStoreModel({required this.appId});

  @override
  String get storeUrl => 'https://itunes.apple.com/lookup';

  @override
  String get versionQuery => 'bundleId=com.mars.FocusId';
}
