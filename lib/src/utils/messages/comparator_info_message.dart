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
}
