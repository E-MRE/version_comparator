import '../../models/entities/empty_entity_model.dart';
import '../../models/entities/store/android_store_model.dart';
import '../../models/entities/store/base_store_model.dart';
import '../../models/version_response_model.dart';
import '../../utils/results/data_result.dart';
import '../abstracts/json_to_version_response_service.dart';
import '../abstracts/remote_data_service.dart';
import '../abstracts/version_compare_service.dart';
import 'android_json_to_version_response_manager.dart';
import 'http_remote_data_manager.dart';

class AndroidVersionCompareManager extends VersionCompareByQueryService {
  AndroidVersionCompareManager({required this.dataService, required this.jsonToResponseService, required this.appId});

  AndroidVersionCompareManager.httpService({
    JsonToVersionResponseService? jsonToVersionResponseService,
    required this.appId,
  })  : dataService = HttpRemoteDataManager(),
        jsonToResponseService = jsonToVersionResponseService ?? AndroidJsonToVersionResponseManager();

  @override
  BaseStoreModel get store => AndroidStoreModel(appId);

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

    return getVersionByQuery(query: 'id=${bundleIdResult.data}', parseModel: EmptyEntityModel.empty());
  }
}
