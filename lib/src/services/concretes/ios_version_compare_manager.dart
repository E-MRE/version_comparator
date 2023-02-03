import '../../models/entities/ios_version_entity_model.dart';
import '../../models/entities/store/base_store_model.dart';
import '../../models/entities/store/ios_store_model.dart';
import '../../models/version_response_model.dart';
import '../../utils/constants/endpoint_constants.dart';
import '../../utils/results/data_result.dart';
import '../abstracts/json_to_version_response_service.dart';
import '../abstracts/remote_data_service.dart';
import '../abstracts/version_compare_service.dart';
import 'http_remote_data_manager.dart';
import 'ios_json_to_version_response_manager.dart';

class IosVersionCompareManager extends VersionCompareByQueryService {
  IosVersionCompareManager({required this.dataService, required this.jsonToResponseService, required this.appId});

  IosVersionCompareManager.httpService({
    JsonToVersionResponseService? jsonToVersionResponseService,
    required this.appId,
  })  : dataService = HttpRemoteDataManager(),
        jsonToResponseService = jsonToVersionResponseService ?? IosJsonToVersionResponseManager();

  @override
  BaseStoreModel get store => IosStoreModel(appId);

  @override
  final String appId;

  @override
  final RemoteDataService dataService;

  @override
  final JsonToVersionResponseService jsonToResponseService;

  @override
  Future<DataResult<VersionResponseModel>> getVersion() async {
    final bundleIdResult = await getBundleId();
    if (bundleIdResult.isNotSuccess) return DataResult.error(message: bundleIdResult.message);

    return getVersionByQuery<IosVersionEntityModel>(
      query: 'bundleId=${bundleIdResult.data}',
      parseModel: IosVersionEntityModel(),
      updateLinkGetter: (parseModel) => parseModel.storeUrl,
    );
  }
}
