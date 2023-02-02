import '../../models/entities/entity_model.dart';
import '../../models/entities/store_model.dart';
import '../../models/parameters/get_data_service_parameter_model.dart';
import '../../models/version_response_model.dart';
import '../../utils/constants/constants.dart';
import '../../utils/results/data_result.dart';
import '../abstracts/json_to_version_response_service.dart';
import '../abstracts/remote_data_service.dart';
import '../abstracts/version_compare_service.dart';
import 'http_remote_data_manager.dart';

class CustomVersionCompareManager<TData extends EntityModel<TData>> extends VersionCompareService {
  CustomVersionCompareManager({
    required this.dataService,
    required this.store,
    required this.jsonToResponseService,
    required this.currentAppVersion,
    required this.parseModel,
    required this.query,
  });

  CustomVersionCompareManager.httpService({
    required this.jsonToResponseService,
    required this.store,
    required this.currentAppVersion,
    required this.parseModel,
    required this.query,
  }) : dataService = HttpRemoteDataManager();

  @override
  final RemoteDataService dataService;

  @override
  final BaseStoreModel store;

  @override
  final JsonToVersionResponseService jsonToResponseService;

  final String? query;
  final String currentAppVersion;
  final TData parseModel;

  @override
  Future<DataResult<VersionResponseModel>> getVersion() async {
    final parameter = GetDataServiceParameterModel<TData>(
      baseUrl: store.baseUrl,
      endpoint: store.endpoint,
      parseModel: parseModel,
      query: query,
    );

    final response = await dataService.getData(parameter);
    if (response.isNotSuccess || response.data == null) {
      return DataResult.error(message: response.message);
    }

    final versionResult = jsonToResponseService.convert(response.data!);
    if (versionResult.isNotSuccess) {
      return DataResult.error(message: versionResult.message);
    }

    return DataResult.success(
      data: VersionResponseModel(
        appVersion: currentAppVersion,
        storeVersion: versionResult.data ?? kEmpty,
        updateLink: parameter.getUrl(),
      ),
    );
  }
}
