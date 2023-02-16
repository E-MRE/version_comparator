import '../../../models/entities/huawei/huawei_version_entity_model.dart';
import '../../../models/entities/store/base_store_model.dart';
import '../../../models/entities/store/huawei_store_model.dart';
import '../../../models/version_response_model.dart';
import '../../../utils/results/data_result.dart';
import '../../abstracts/remote_data_service.dart';
import '../../abstracts/version_compare_service.dart';
import '../../abstracts/version_convert_service.dart';
import '../http_remote_data_manager.dart';
import 'huawei_version_convert_manager.dart';

class HuaweiVersionCompareManager extends VersionCompareByQueryService {
  HuaweiVersionCompareManager({
    required this.dataService,
    required this.jsonToResponseService,
    required String appId,
  }) : store = HuaweiStoreModel(appId);

  HuaweiVersionCompareManager.httpService({
    VersionConvertService? jsonToVersionResponseService,
    required String appId,
  })  : store = HuaweiStoreModel(appId),
        dataService = HttpRemoteDataManager(),
        jsonToResponseService = jsonToVersionResponseService ?? HuaweiVersionConvertManager();

  @override
  final BaseStoreModel store;

  @override
  final RemoteDataService dataService;

  @override
  final VersionConvertService jsonToResponseService;

  @override
  Future<DataResult<VersionResponseModel>> getVersion() async {
    return getVersionByQuery<HuaweiVersionEntityModel>(
      parseModel: HuaweiVersionEntityModel.empty(),
      updateLinkGetter: (parseModel) => parseModel.storeUrl(store.appId),
    );
  }
}
