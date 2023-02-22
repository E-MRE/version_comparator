import '../../../models/entities/store/base_store_model.dart';
import '../../../models/version_response_model.dart';
import '../../../utils/results/data_result.dart';
import '../../abstracts/remote_data_service.dart';
import '../../abstracts/version_compare_service.dart';
import '../http_remote_data_manager.dart';

class CustomVersionCompareManager extends VersionCompareByQueryService {
  CustomVersionCompareManager({
    required this.dataService,
    required this.localVersion,
    required this.onConvertVersion,
    required this.store,
    this.customUpdateLink,
  });

  CustomVersionCompareManager.httpService({
    required this.localVersion,
    required this.onConvertVersion,
    required this.store,
    this.customUpdateLink,
  }) : dataService = HttpRemoteDataManager();

  @override
  final BaseStoreModel store;

  @override
  final RemoteDataService dataService;

  final String localVersion;
  final String? Function(String responseBody) onConvertVersion;
  final String? Function(String responseBody)? customUpdateLink;

  @override
  Future<DataResult<VersionResponseModel>> getVersion() async {
    return getStoreVersionByQuery(
      onConvertVersion: onConvertVersion,
      localVersion: localVersion,
      customUpdateLink: customUpdateLink,
    );
  }
}
