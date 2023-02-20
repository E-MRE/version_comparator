///Version Comparator info messages.
abstract class ComparatorInfoMessage {
  ///It is used to retrieve an error message when there is an issue with data retrieval.
  String get getDataError => 'Get Data Error';

  ///It is used to retrieve an error message when there is an issue with data sending.
  String get getDataSuccess => 'Get Data Success';

  ///It is used to retrieve an success message when data retrieval is success.
  String get sendDataError => 'Send Data Error';

  ///It is used to retrieve an success message when data sending is success.
  String get sendDataSuccess => 'Send Data Success';

  ///It is used to retrieve an error message when unexpected error happens.
  String get unExpectedError => 'Unexpected Error';

  ///Version update AlertDialog title text.
  String get versionDialogTitle => 'Update Available';

  ///Required update AlertDialog title text.
  String get requiredVersionDialogTitle => 'Update Required';

  ///Cancel dialog action
  String get versionDialogCancelAction => 'Cancel';

  ///Update version dialog action
  String get versionDialogUpdateAction => 'Update Now!';

  ///New version is available message text.
  String versionDialogContent(String oldVersion, String latestVersion) =>
      'App version ($oldVersion) out of date. New version is available ($latestVersion). Would you like to update?';

  ///Required version message text.
  String requiredVersionDialogContent(String oldVersion, String latestVersion) =>
      'App version ($oldVersion) out of date. Please update app to latest version ($latestVersion).';
}
