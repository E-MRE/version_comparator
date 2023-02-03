library version_comparator;

import 'package:version_comparator/src/models/entities/entity_model.dart';
import 'package:version_comparator/src/models/parameters/custom_version_compare_parameter_model.dart';
import 'package:version_comparator/src/models/version_response_model.dart';
import 'package:version_comparator/src/services/abstracts/json_to_version_response_service.dart';
import 'package:version_comparator/src/services/abstracts/remote_data_service.dart';
import 'package:version_comparator/src/services/abstracts/version_compare_service.dart';
import 'package:version_comparator/src/services/concretes/android_json_to_version_response_manager.dart';
import 'package:version_comparator/src/services/concretes/android_version_compare_manager.dart';
import 'package:version_comparator/src/services/concretes/custom_version_compare_manager.dart';
import 'package:version_comparator/src/services/concretes/http_remote_data_manager.dart';
import 'package:version_comparator/src/services/concretes/huawei_json_to_version_response_manager.dart';
import 'package:version_comparator/src/services/concretes/huawei_version_compare_manager.dart';
import 'package:version_comparator/src/services/concretes/ios_json_to_version_response_manager.dart';
import 'package:version_comparator/src/services/concretes/ios_version_compare_manager.dart';
import 'package:version_comparator/src/utils/enums/app_platform.dart';
import 'package:version_comparator/src/utils/enums/error_message.dart';
import 'package:version_comparator/src/utils/mixins/platform_decider_mixin.dart';
import 'package:version_comparator/src/utils/results/data_result.dart';

abstract class BaseVersionComparator {
  VersionCompareService? _versionComparator;
  VersionCompareService? get versionComparator => _versionComparator;

  void setVersionComparator(VersionCompareService service) {
    _versionComparator = service;
  }

  /// This function returns a Future object of type `[DataResult<VersionResponseModel>]` which is used to
  /// compare platform-specific versions. It takes three optional parameters:
  /// 1. jsonToVersionResponseService: an optional object. It returns store version from json
  /// 2. dataService: an optional RemoteDataService object. It gets response from stores.
  /// 3. huaweiStoreAppId: an optional String value. It's important for `[Huawei]`.
  /// You must set this parameter if you want to compare your app from `[AppGallery]`.
  Future<DataResult<VersionResponseModel>> platformSpecificCompare({
    JsonToVersionResponseService? jsonToVersionResponseService,
    RemoteDataService? dataService,
    String? huaweiStoreAppId,
  });

  /// This function returns a Future object of type `[DataResult<VersionResponseModel>]` which is used to
  /// compare versions with custom settings. It takes two parameters:
  /// 1. parameterModel: an required CustomVersionCompareParameterModel object.
  /// This model includes all needed for compare app versions.
  /// 2. dataService: an optional RemoteDataService object. It gets response from stores.
  ///
  /// This function can use when project platform is different from Android, iOS or Huawei.
  /// Also it can use for compare versions from another stores.
  Future<DataResult<VersionResponseModel>> customCompare<TData extends EntityModel<TData>>({
    required CustomVersionCompareParameterModel<TData> parameterModel,
    RemoteDataService? dataService,
  }) async {
    setVersionComparator(CustomVersionCompareManager(
      query: parameterModel.query,
      store: parameterModel.store,
      parseModel: parameterModel.parseModel,
      updateLinkGetter: parameterModel.updateLinkGetter,
      dataService: dataService ?? HttpRemoteDataManager(),
      currentAppVersion: parameterModel.currentAppVersion,
      jsonToResponseService: parameterModel.jsonToResponseService,
    ));

    return await versionComparator!.getVersion();
  }
}

class VersionComparator extends BaseVersionComparator with PlatformDeciderMixin {
  @override
  Future<DataResult<VersionResponseModel>> platformSpecificCompare({
    JsonToVersionResponseService? jsonToVersionResponseService,
    RemoteDataService? dataService,
    String? huaweiStoreAppId,
  }) async {
    final platform = await getPlatform();

    final remoteService = dataService ?? HttpRemoteDataManager();

    switch (platform) {
      case AppPlatform.invalid:
        throw Exception(ErrorMessage.otherPlatformsNotSupported);

      case AppPlatform.android:
        setVersionComparator(AndroidVersionCompareManager(
          jsonToResponseService: jsonToVersionResponseService ?? AndroidJsonToVersionResponseManager(),
          dataService: remoteService,
        ));
        break;

      case AppPlatform.ios:
        setVersionComparator(IosVersionCompareManager(
          jsonToResponseService: jsonToVersionResponseService ?? IosJsonToVersionResponseManager(),
          dataService: remoteService,
        ));
        break;

      case AppPlatform.huawei:
        if (huaweiStoreAppId == null || huaweiStoreAppId.isEmpty) {
          return DataResult.byErrorMessageEnum(error: ErrorMessage.huaweiAppIdNullOrEmpty);
        }

        setVersionComparator(HuaweiVersionCompareManager(
          jsonToResponseService: jsonToVersionResponseService ?? HuaweiJsonToVersionResponseManager(),
          dataService: remoteService,
          appId: huaweiStoreAppId,
        ));
        break;
    }

    return await versionComparator?.getVersion() ??
        DataResult.byErrorMessageEnum(error: ErrorMessage.versionComparatorNotSet);
  }
}
