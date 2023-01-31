import '../constants/constants.dart';

///This class returns operation results with message.
class Result {
  ///Operation result.
  final bool isSuccess;

  ///Operation message. Also it can use for error message.
  final String message;

  ///Customizable constructor
  Result({required this.isSuccess, required this.message});

  ///Operation result is successful. Also you can add success message to [message]
  Result.success({this.message = kEmpty}) : isSuccess = true;

  ///Operation result is unsuccessful. You must add error message to [message]
  Result.error({required this.message}) : isSuccess = false;

  ///Operation result is unsuccessful. Error message is optional.
  Result.errorByEmptyMessage({this.message = kEmpty}) : isSuccess = false;
}
