import '../../models/entities/huawei/huawei_version_entity_model.dart';
import '../../models/entities/store/base_store_model.dart';
import '../../models/entities/store/huawei_store_model.dart';
import '../../models/version_response_model.dart';
import '../../utils/results/data_result.dart';
import '../abstracts/json_to_version_response_service.dart';
import '../abstracts/remote_data_service.dart';
import '../abstracts/version_compare_service.dart';
import 'http_remote_data_manager.dart';
import 'huawei_json_to_version_response_manager.dart';

class HuaweiVersionCompareManager extends VersionCompareByQueryService {
  HuaweiVersionCompareManager({
    required this.dataService,
    required this.jsonToResponseService,
    required String appId,
  }) : store = HuaweiStoreModel(appId);

  HuaweiVersionCompareManager.httpService({
    JsonToVersionResponseService? jsonToVersionResponseService,
    required String appId,
  })  : store = HuaweiStoreModel(appId),
        dataService = HttpRemoteDataManager(),
        jsonToResponseService = jsonToVersionResponseService ?? HuaweiJsonToVersionResponseManager();

  @override
  final BaseStoreModel store;

  @override
  final RemoteDataService dataService;

  @override
  final JsonToVersionResponseService jsonToResponseService;

  @override
  Future<DataResult<VersionResponseModel>> getVersion() async {
    return getVersionByQuery<HuaweiVersionEntityModel>(
      parseModel: HuaweiVersionEntityModel.empty(),
      updateLinkGetter: (parseModel) => parseModel.storeUrl(store.appId),
    );
  }
}
