import '../../models/entities/entity_model.dart';
import '../../models/entities/store/base_store_model.dart';
import '../../models/parameters/get_data_service_parameter_model.dart';
import '../../models/version_response_model.dart';
import '../../utils/constants/constants.dart';
import '../../utils/mixins/launch_url_mixin.dart';
import '../../utils/mixins/package_info_mixin.dart';
import '../../utils/results/data_result.dart';
import 'version_convert_service.dart';
import 'remote_data_service.dart';

abstract class VersionCompareService with PackageInfoMixin, LaunchUrlMixin {
  BaseStoreModel get store;
  RemoteDataService get dataService;
  VersionConvertService get jsonToResponseService;

  Future<DataResult<VersionResponseModel>> getVersion();
}

abstract class VersionCompareByQueryService extends VersionCompareService {
  Future<DataResult<VersionResponseModel>> getVersionByQuery<TData extends EntityModel<TData>>({
    required TData parseModel,
    String? Function(TData parseModel)? updateLinkGetter,
  }) async {
    final appVersionResult = await getCurrentAppVersion();
    if (appVersionResult.isNotSuccess) return DataResult.error(message: appVersionResult.message);

    return getStoreVersionByQuery<TData>(
      parseModel: parseModel,
      updateLinkGetter: updateLinkGetter,
      currentVersion: appVersionResult.data ?? kEmpty,
    );
  }

  Future<DataResult<VersionResponseModel>> getStoreVersionByQuery<TData extends EntityModel<TData>>({
    required TData parseModel,
    required String currentVersion,
    String? Function(TData parseModel)? updateLinkGetter,
  }) async {
    final parameter = GetDataServiceParameterModel<TData>(
      url: store.storeUrl,
      parseModel: parseModel,
      query: store.versionQuery,
    );

    final response = await dataService.getData(parameter);
    if (response.isNotSuccess || response.data == null) {
      return DataResult.error(message: response.message);
    }

    final versionResult = jsonToResponseService.convert(response.data!);
    if (versionResult.isNotSuccess) {
      return DataResult.error(message: versionResult.message);
    }

    return DataResult.success(
      data: VersionResponseModel(
        appVersion: currentVersion,
        storeVersion: versionResult.data ?? kEmpty,
        updateLink: updateLinkGetter?.call(response.data!) ?? parameter.getUrl(),
      ),
    );
  }
}
