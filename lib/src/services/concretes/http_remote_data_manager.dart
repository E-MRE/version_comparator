import 'package:http/http.dart' as http;

import '../../models/entities/entity_model.dart';
import '../../models/parameters/get_data_service_parameter_model.dart';
import '../../models/parameters/send_data_service_parameter_model.dart';
import '../../models/parameters/service_parameter_model.dart';
import '../../utils/constants/constants.dart';
import '../../utils/results/data_result.dart';
import '../../utils/results/result.dart';
import '../abstracts/remote_data_service.dart';

class HttpRemoteDataManager extends RemoteDataService {
  HttpRemoteDataManager() : _client = http.Client();

  Uri getUri(ServiceParameterModel parameterModel) =>
      Uri.parse(parameterModel.getUrl());

  final http.Client _client;

  @override
  Future<DataResult<String>> getData(
      GetDataServiceParameterModel parameterModel) async {
    try {
      final response = await _client
          .get(getUri(parameterModel),
              headers: parameterModel.header ?? baseHeader)
          .timeout(parameterModel.timeoutDuration);

      return response.statusCode == kHttpStatusOK
          ? DataResult.success(data: response.body)
          : DataResult.error(message: kInfoMessage.getDataError);
    } catch (exception) {
      return DataResult.error(message: exception.toString());
    }
  }

  @override
  Future<Result> sendData<TData extends EntityModel<TData>>(
      SendDataServiceParameterModel<TData> parameterModel) async {
    try {
      final response = await _client
          .post(getUri(parameterModel),
              headers: parameterModel.header ?? baseHeader)
          .timeout(parameterModel.timeoutDuration);

      return response.statusCode == kHttpStatusOK
          ? Result.success(message: kInfoMessage.sendDataSuccess)
          : DataResult.error(message: kInfoMessage.sendDataError);
    } catch (exception) {
      return DataResult.error(message: exception.toString());
    }
  }
}
