import 'package:version_comparator/version_comparator.dart';

class CustomErrorMessage extends ComparatorErrorMessage {
  @override
  String get appNotFound => 'App not found in the store.';

  @override
  String get appVersionFetchError => 'Fetch error';

  @override
  String get appBundleIdFetchError => 'App bundle id could\'t fetch.';
}
