import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version_comparator/src/models/entities/entity_model.dart';

import '../../models/entities/store_model.dart';
import '../../models/parameters/get_data_service_parameter_model.dart';
import '../../models/version_response_model.dart';
import '../../utils/constants/constants.dart';
import '../../utils/enums/error_message.dart';
import '../../utils/results/data_result.dart';
import '../../utils/results/result.dart';
import 'json_to_version_response_service.dart';
import 'remote_data_service.dart';

abstract class VersionCompareService {
  BaseStoreModel get store;
  RemoteDataService get dataService;
  JsonToVersionResponseService get jsonToResponseService;

  PackageInfo? _info;

  Future<DataResult<VersionResponseModel>> getVersion();

  Future<Result> launchStoreLink(String storeLink) async {
    if (await canLaunchUrl(Uri.parse(storeLink))) {
      final isLaunched = await launchUrl(Uri.parse(storeLink), mode: LaunchMode.externalApplication);
      return isLaunched ? Result.success() : Result.error(message: ErrorMessage.notLaunchUrl.message);
    } else {
      return Result.error(message: ErrorMessage.notLaunchUrl.message);
    }
  }

  Future<DataResult<String>> getCurrentAppVersion() async {
    try {
      _info ??= await PackageInfo.fromPlatform();
      return _info?.version == null || (_info?.version.isEmpty ?? true)
          ? DataResult.byErrorMessageEnum(error: ErrorMessage.appVersionFetchError)
          : DataResult.success(data: _info!.version);
    } catch (exception) {
      return DataResult.error(message: exception.toString());
    }
  }

  Future<DataResult<String>> getBundleId() async {
    try {
      _info ??= await PackageInfo.fromPlatform();
      return _info?.version == null || (_info?.packageName.isEmpty ?? true)
          ? DataResult.byErrorMessageEnum(error: ErrorMessage.appBundleIdFetchError)
          : DataResult.success(data: _info!.packageName);
    } catch (exception) {
      return DataResult.error(message: exception.toString());
    }
  }
}

abstract class VersionCompareByQueryService extends VersionCompareService {
  Future<DataResult<VersionResponseModel>> getVersionByQuery<TData extends EntityModel<TData>>({
    required String query,
    required TData parseModel,
    String? Function(TData parseModel)? updateLinkGetter,
  }) async {
    final appVersionResult = await getCurrentAppVersion();
    if (appVersionResult.isNotSuccess) return DataResult.error(message: appVersionResult.message);

    return getStoreVersionByQuery<TData>(
      query: query,
      parseModel: parseModel,
      updateLinkGetter: updateLinkGetter,
      currentVersion: appVersionResult.data ?? kEmpty,
    );
  }

  Future<DataResult<VersionResponseModel>> getStoreVersionByQuery<TData extends EntityModel<TData>>({
    required String query,
    required TData parseModel,
    required String currentVersion,
    String? Function(TData parseModel)? updateLinkGetter,
  }) async {
    final parameter = GetDataServiceParameterModel<TData>(
      baseUrl: store.baseUrl,
      endpoint: store.endpoint,
      parseModel: parseModel,
      query: query,
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
