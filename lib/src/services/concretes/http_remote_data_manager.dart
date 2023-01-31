import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../models/entity_model.dart';
import '../../models/parameters/get_data_service_parameter_model.dart';
import '../../models/parameters/send_data_service_parameter_model.dart';
import '../../models/parameters/service_parameter_model.dart';
import '../../utils/enums/service_message.dart';
import '../../utils/results/data_result.dart';
import '../../utils/results/result.dart';
import '../abstracts/remote_data_service.dart';

class HttpRemoteDataManager extends RemoteDataService {
  HttpRemoteDataManager() : _client = http.Client();

  Uri getUri(ServiceParameterModel parameterModel) => Uri.parse(parameterModel.getUrl());

  final http.Client _client;

  @override
  Future<DataResult<TData>> getData<TData extends EntityModel<TData>>(
      GetDataServiceParameterModel<TData> parameterModel) async {
    try {
      final response = await _client
          .get(getUri(parameterModel), headers: parameterModel.header ?? baseHeader)
          .timeout(parameterModel.timeoutDuration);

      return response.statusCode == HttpStatus.ok
          ? DataResult.success(data: parameterModel.parseModel.fromJson(jsonDecode(response.body)))
          : DataResult.error(message: ServiceMessage.getDataError.message);
    } catch (exception) {
      return DataResult.error(message: exception.toString());
    }
  }

  @override
  Future<Result> sendData<TData extends EntityModel<TData>>(SendDataServiceParameterModel<TData> parameterModel) async {
    try {
      final response = await _client
          .post(getUri(parameterModel), headers: parameterModel.header ?? baseHeader)
          .timeout(parameterModel.timeoutDuration);

      return response.statusCode == HttpStatus.ok
          ? Result.success(message: ServiceMessage.sendDataSuccess.message)
          : DataResult.error(message: ServiceMessage.sendDataError.message);
    } catch (exception) {
      return DataResult.error(message: exception.toString());
    }
  }
}
