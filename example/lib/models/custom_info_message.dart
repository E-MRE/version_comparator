import 'package:version_comparator/version_comparator.dart';

class CustomInfoMessage implements ComparatorInfoMessage {
  @override
  String get checkVersionErrorDialogTitle => '';

  @override
  String get checkVersionLoadingMessage => '';

  @override
  String get checkVersionOkAction => '';

  @override
  String get getDataError => '';

  @override
  String get getDataSuccess => '';

  @override
  String requiredVersionDialogContent(String oldVersion, String latestVersion) {
    return '';
  }

  @override
  String get requiredVersionDialogTitle => '';

  @override
  String get sendDataError => '';

  @override
  String get sendDataSuccess => '';

  @override
  String get unExpectedError => '';

  @override
  String get versionDialogCancelAction => '';

  @override
  String versionDialogContent(String oldVersion, String latestVersion) {
    return '';
  }

  @override
  String get versionDialogTitle => '';

  @override
  String get versionDialogUpdateAction => '';
}
