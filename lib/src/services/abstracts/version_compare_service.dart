import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/entities/store_model.dart';
import '../../models/version_response_model.dart';
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
