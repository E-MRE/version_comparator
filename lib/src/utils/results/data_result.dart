import '../constants/constants.dart';
import 'result.dart';

///This class returns operation results with message and data. [TData] must be defined.
class DataResult<TData> extends Result {
  ///Operation data.
  final TData? data;

  ///Customizable constructor
  DataResult({required super.isSuccess, required super.message, this.data});

  ///Operation result is successful. Also you can add success message to [message]. [data] is required.
  DataResult.success({String message = kEmpty, required this.data}) : super.success(message: message);

  ///Operation result is unsuccessful. You must add error message to [message]
  DataResult.error({required String message, this.data}) : super.error(message: message);

  ///Operation result is unsuccessful. Error message is optional.
  DataResult.errorByEmptyMessage({String message = kEmpty, this.data}) : super.errorByEmptyMessage(message: message);
}
