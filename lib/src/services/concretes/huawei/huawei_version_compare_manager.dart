import '../../../models/entities/huawei/huawei_version_entity_model.dart';
import '../../../models/entities/store/base_store_model.dart';
import '../../../models/entities/store/huawei_store_model.dart';
import '../../../models/version_response_model.dart';
import '../../../utils/results/data_result.dart';
import '../../abstracts/huawei_version_compare_service.dart';
import '../../abstracts/remote_data_service.dart';
import '../../abstracts/version_convert_service.dart';
import '../http_remote_data_manager.dart';

class HuaweiVersionCompareManager extends HuaweiVersionCompareService {
  HuaweiVersionCompareManager({required this.dataService, required String appId}) : store = HuaweiStoreModel(appId);

  HuaweiVersionCompareManager.httpService({VersionConvertService? versionConvertService, required String appId})
      : store = HuaweiStoreModel(appId),
        dataService = HttpRemoteDataManager();

  @override
  final BaseStoreModel store;

  @override
  final RemoteDataService dataService;

  @override
  Future<DataResult<VersionResponseModel>> getVersion({Map<String, String>? customHeader}) async {
    return await getVersionByQuery(
      customUpdateLink: (body) => HuaweiVersionEntityModel.fromResponse(body).storeUrl(store.appId),
      onConvertVersion: (body) => HuaweiVersionEntityModel.fromResponse(body).storeVersion,
      customHeader: customHeader ?? await generateHeaderByInterfaceCode(),
    );
  }
}
