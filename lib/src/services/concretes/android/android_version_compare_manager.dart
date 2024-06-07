import '../../../models/entities/empty_entity_model.dart';
import '../../../models/entities/store/android_store_model.dart';
import '../../../models/entities/store/base_store_model.dart';
import '../../../models/version_response_model.dart';
import '../../../utils/results/data_result.dart';
import '../../abstracts/remote_data_service.dart';
import '../../abstracts/version_compare_service.dart';
import '../../abstracts/version_convert_service.dart';
import '../http_remote_data_manager.dart';
import 'android_version_convert_manager.dart';

class AndroidVersionCompareManager extends VersionCompareByQueryService {
  AndroidVersionCompareManager({
    required this.dataService,
    required this.versionConvertService,
    required String bundleId,
  }) : store = AndroidStoreModel(bundleId);

  AndroidVersionCompareManager.httpService({
    VersionConvertService? versionConvertService,
    required String bundleId,
  })  : store = AndroidStoreModel(bundleId),
        dataService = HttpRemoteDataManager(),
        versionConvertService =
            versionConvertService ?? AndroidVersionConvertManager();

  @override
  final BaseStoreModel store;

  @override
  final RemoteDataService dataService;

  final VersionConvertService versionConvertService;

  @override
  Future<DataResult<VersionResponseModel>> getVersion(
      {Map<String, String>? customHeader}) async {
    final bundleIdResult = await getBundleId();
    if (bundleIdResult.isNotSuccess)
      return DataResult.error(message: bundleIdResult.message);

    return getVersionByQuery(
      customHeader: customHeader,
      onConvertVersion: (responseBody) {
        final versionResult = versionConvertService
            .convert(EmptyEntityModel.fromResponse(responseBody));
        return versionResult.data;
      },
    );
  }
}
