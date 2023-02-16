import '../../../models/entities/entity_model.dart';
import '../../../models/entities/store/base_store_model.dart';
import '../../../models/version_response_model.dart';
import '../../../utils/results/data_result.dart';
import '../../abstracts/remote_data_service.dart';
import '../../abstracts/version_compare_service.dart';
import '../../abstracts/version_convert_service.dart';
import '../http_remote_data_manager.dart';

class CustomVersionCompareManager<TData extends EntityModel<TData>> extends VersionCompareByQueryService {
  CustomVersionCompareManager({
    required this.dataService,
    required this.jsonToResponseService,
    required this.currentAppVersion,
    required this.parseModel,
    required this.store,
    this.updateLinkGetter,
  });

  CustomVersionCompareManager.httpService({
    required this.jsonToResponseService,
    required this.currentAppVersion,
    required this.parseModel,
    required this.store,
    this.updateLinkGetter,
  }) : dataService = HttpRemoteDataManager();

  @override
  final BaseStoreModel store;

  @override
  final RemoteDataService dataService;

  @override
  final VersionConvertService jsonToResponseService;

  final String currentAppVersion;
  final TData parseModel;
  final String? Function(TData parseModel)? updateLinkGetter;

  @override
  Future<DataResult<VersionResponseModel>> getVersion() async {
    return getStoreVersionByQuery<TData>(
      parseModel: parseModel,
      currentVersion: currentAppVersion,
      updateLinkGetter: updateLinkGetter,
    );
  }
}
