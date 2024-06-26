import '../constants/constants.dart';
import 'result.dart';

///This class returns operation results with message and data. [TData] must be defined.
class DataResult<TData> extends Result {
  ///Operation data.
  final TData? data;

  ///Operation code.
  final int code;

  ///Customizable constructor
  DataResult(
      {required super.isSuccess,
      required super.message,
      this.data,
      this.code = kZero});

  ///Operation result is successful. Also you can add success message to [message]. [data] is required.
  DataResult.success({super.message, required this.data, this.code = kZero})
      : super.success();

  ///Operation result is unsuccessful. You must add error message to [message]
  DataResult.error({required super.message, this.data, this.code = kZero})
      : super.error();

  ///Operation result is unsuccessful. Error message is optional.
  DataResult.errorByEmptyMessage({super.message, this.data, this.code = kZero})
      : super.errorByEmptyMessage();
}
