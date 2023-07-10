import '../../../models/entities/ios_version_entity_model.dart';
import '../../../models/entities/store/base_store_model.dart';
import '../../../models/entities/store/ios_store_model.dart';
import '../../../models/version_response_model.dart';
import '../../../utils/results/data_result.dart';
import '../../abstracts/remote_data_service.dart';
import '../../abstracts/version_compare_service.dart';
import '../../abstracts/version_convert_service.dart';
import '../http_remote_data_manager.dart';

class IosVersionCompareManager extends VersionCompareByQueryService {
  IosVersionCompareManager({required this.dataService, required String bundleId}) : store = IosStoreModel(bundleId);

  IosVersionCompareManager.httpService({VersionConvertService? versionConvertService, required String bundleId})
      : store = IosStoreModel(bundleId),
        dataService = HttpRemoteDataManager();

  @override
  final BaseStoreModel store;

  @override
  final RemoteDataService dataService;

  @override
  Future<DataResult<VersionResponseModel>> getVersion({Map<String, String>? customHeader}) async {
    final bundleIdResult = await getBundleId();
    if (bundleIdResult.isNotSuccess) return DataResult.error(message: bundleIdResult.message);

    return getVersionByQuery(
      customHeader: customHeader,
      customUpdateLink: (body) => IosVersionEntityModel.fromResponse(body).storeUrl,
      onConvertVersion: (responseBody) => IosVersionEntityModel.fromResponse(responseBody).storeVersion,
    );
  }
}
