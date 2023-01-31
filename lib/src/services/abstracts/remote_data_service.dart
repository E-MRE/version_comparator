import '../../models/entity_model.dart';
import '../../models/parameters/get_data_service_parameter_model.dart';
import '../../models/parameters/send_data_service_parameter_model.dart';
import '../../utils/results/data_result.dart';
import '../../utils/results/result.dart';

abstract class RemoteDataService {
  Map<String, String> get baseHeader => {'content-type': 'application/json'};

  Future<DataResult<TData>> getData<TData extends EntityModel<TData>>(
      GetDataServiceParameterModel<TData> parameterModel);

  Future<Result> sendData<TData extends EntityModel<TData>>(SendDataServiceParameterModel<TData> parameterModel);
}
