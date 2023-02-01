import '../constants/constants.dart';
import '../enums/error_message.dart';
import '../enums/service_message.dart';
import 'result.dart';

///This class returns operation results with message and data. [TData] must be defined.
class DataResult<TData> extends Result {
  ///Operation data.
  final TData? data;

  ///Operation code.
  final int code;

  ///Customizable constructor
  DataResult({required super.isSuccess, required super.message, this.data, this.code = kZero});

  ///Operation result is successful. Also you can add success message to [message]. [data] is required.
  DataResult.success({String message = kEmpty, required this.data, this.code = kZero})
      : super.success(message: message);

  ///Operation result is unsuccessful. You must add error message to [message]
  DataResult.error({required String message, this.data, this.code = kZero}) : super.error(message: message);

  ///Operation result is unsuccessful. Error message is optional.
  DataResult.errorByEmptyMessage({String message = kEmpty, this.data, this.code = kZero})
      : super.errorByEmptyMessage(message: message);

  DataResult.successByServiceMessageEnum({required ServiceMessage serviceMessage, required this.data, int? code})
      : code = code ?? serviceMessage.code,
        super.success(message: serviceMessage.message);

  DataResult.errorByServiceMessageEnum({required ServiceMessage serviceMessage, this.data, int? code})
      : code = code ?? serviceMessage.code,
        super.error(message: serviceMessage.message);

  DataResult.byErrorMessageEnum({required ErrorMessage error, this.data, int? code})
      : code = code ?? error.code,
        super.error(message: error.message);
}
