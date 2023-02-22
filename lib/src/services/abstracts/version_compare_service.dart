import '../../models/entities/store/base_store_model.dart';
import '../../models/parameters/get_data_service_parameter_model.dart';
import '../../models/version_response_model.dart';
import '../../utils/constants/constants.dart';
import '../../utils/mixins/launch_url_mixin.dart';
import '../../utils/mixins/package_info_mixin.dart';
import '../../utils/results/data_result.dart';
import 'remote_data_service.dart';

abstract class VersionCompareService with PackageInfoMixin, LaunchUrlMixin {
  BaseStoreModel get store;
  RemoteDataService get dataService;

  Future<DataResult<VersionResponseModel>> getVersion();
}

abstract class VersionCompareByQueryService extends VersionCompareService {
  Future<DataResult<VersionResponseModel>> getVersionByQuery({
    required String? Function(String responseBody) onConvertVersion,
    String? Function(String responseBody)? customUpdateLink,
  }) async {
    final appVersionResult = await getCurrentAppVersion();
    if (appVersionResult.isNotSuccess) return DataResult.error(message: appVersionResult.message);

    return getStoreVersionByQuery(
      onConvertVersion: onConvertVersion,
      customUpdateLink: customUpdateLink,
      localVersion: appVersionResult.data ?? kEmpty,
    );
  }

  Future<DataResult<VersionResponseModel>> getStoreVersionByQuery({
    required String? Function(String responseBody) onConvertVersion,
    required String localVersion,
    String? Function(String responseBody)? customUpdateLink,
  }) async {
    final parameter = GetDataServiceParameterModel(url: store.storeUrl, query: store.versionQuery);

    final response = await dataService.getData(parameter);
    if (response.isNotSuccess || response.data == null) {
      return DataResult.error(message: response.message);
    }

    final version = onConvertVersion.call(response.data!);
    if (version == null || version.isEmpty) {
      return DataResult.error(message: kErrorMessage.versionResponseNull);
    }

    return DataResult.success(
      data: VersionResponseModel(
        localVersion: localVersion,
        storeVersion: version,
        updateLink: customUpdateLink?.call(response.data!) ?? parameter.getUrl(),
      ),
    );
  }
}
