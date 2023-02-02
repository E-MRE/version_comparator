import '../../models/entities/huawei/huawei_version_entity_model.dart';
import '../../models/entities/store_model.dart';
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
    required this.appId,
  });

  HuaweiVersionCompareManager.httpService({
    JsonToVersionResponseService? jsonToVersionResponseService,
    required this.appId,
  })  : dataService = HttpRemoteDataManager(),
        jsonToResponseService = jsonToVersionResponseService ?? HuaweiJsonToVersionResponseManager();

  @override
  BaseStoreModel get store => StoreModel.huawei(appId);

  @override
  final RemoteDataService dataService;

  @override
  final JsonToVersionResponseService jsonToResponseService;

  final String appId;

  @override
  Future<DataResult<VersionResponseModel>> getVersion() async {
    return getVersionByQuery<HuaweiVersionEntityModel>(
      query: 'method=internal.getTabDetail&uri=app%7C$appId',
      parseModel: HuaweiVersionEntityModel.empty(),
      updateLinkGetter: (parseModel) => parseModel.storeUrl(appId),
    );
  }
}
