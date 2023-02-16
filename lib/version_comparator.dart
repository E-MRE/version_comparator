library version_comparator;

import 'package:version_comparator/src/models/entities/entity_model.dart';
import 'package:version_comparator/src/models/parameters/custom_version_compare_parameter_model.dart';
import 'package:version_comparator/src/models/version_response_model.dart';
import 'package:version_comparator/src/services/abstracts/version_convert_service.dart';
import 'package:version_comparator/src/services/abstracts/remote_data_service.dart';
import 'package:version_comparator/src/services/abstracts/version_compare_service.dart';
import 'package:version_comparator/src/services/concretes/android/android_version_convert_manager.dart';
import 'package:version_comparator/src/services/concretes/android/android_version_compare_manager.dart';
import 'package:version_comparator/src/services/concretes/custom/custom_version_compare_manager.dart';
import 'package:version_comparator/src/services/concretes/http_remote_data_manager.dart';
import 'package:version_comparator/src/services/concretes/huawei/huawei_version_convert_manager.dart';
import 'package:version_comparator/src/services/concretes/huawei/huawei_version_compare_manager.dart';
import 'package:version_comparator/src/services/concretes/ios/ios_version_convert_manager.dart';
import 'package:version_comparator/src/services/concretes/ios/ios_version_compare_manager.dart';
import 'package:version_comparator/src/utils/enums/app_platform.dart';
import 'package:version_comparator/src/utils/enums/error_message.dart';
import 'package:version_comparator/src/utils/mixins/platform_decider_mixin.dart';
import 'package:version_comparator/src/utils/results/data_result.dart';

///The mission of the VersionComparator class is to compare different versions of an app.
///It has two methods: platformSpecificCompare and customCompare.
///The platformSpecificCompare method is used to compare platform-specific versions, such as Android, iOS, and Huawei.
///The customCompare method is used to compare versions with custom settings.
///This method can be used when the project platform is different from Android,
///iOS or Huawei, or when comparing versions from other stores.
abstract class BaseVersionComparator {
  VersionCompareService? _versionComparator;

  ///Getter of the current VersionCompare service.
  VersionCompareService? get versionComparator => _versionComparator;

  ///This code is a method that sets the versionComparator variable to the VersionCompareService service.
  ///This service is using for the compare app versions.
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
    required String appId,
    VersionConvertService? jsonToVersionResponseService,
    RemoteDataService? dataService,
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

///The mission of the VersionComparator class is to compare different versions of an app.
///It has two methods: platformSpecificCompare and customCompare.
///The platformSpecificCompare method is used to compare platform-specific versions, such as Android, iOS, and Huawei.
///The customCompare method is used to compare versions with custom settings.
///This method can be used when the project platform is different from Android,
///iOS or Huawei, or when comparing versions from other stores.
class VersionComparator extends BaseVersionComparator with PlatformDeciderMixin {
  static VersionComparator? _instance;
  static VersionComparator get instance {
    _instance ??= VersionComparator._init();
    return _instance!;
  }

  VersionComparator._init();

  @override
  Future<DataResult<VersionResponseModel>> platformSpecificCompare({
    required String appId,
    VersionConvertService? jsonToVersionResponseService,
    RemoteDataService? dataService,
  }) async {
    final platform = await getPlatform();

    final remoteService = dataService ?? HttpRemoteDataManager();

    switch (platform) {
      case AppPlatform.invalid:
        throw Exception(ErrorMessage.otherPlatformsNotSupported);

      case AppPlatform.android:
        setVersionComparator(AndroidVersionCompareManager(
          jsonToResponseService: jsonToVersionResponseService ?? AndroidVersionConvertManager(),
          dataService: remoteService,
          bundleId: appId,
        ));
        break;

      case AppPlatform.ios:
        setVersionComparator(IosVersionCompareManager(
          jsonToResponseService: jsonToVersionResponseService ?? IosVersionConvertManager(),
          dataService: remoteService,
          bundleId: appId,
        ));
        break;

      case AppPlatform.huawei:
        setVersionComparator(HuaweiVersionCompareManager(
          jsonToResponseService: jsonToVersionResponseService ?? HuaweiVersionConvertManager(),
          dataService: remoteService,
          appId: appId,
        ));
        break;
    }

    return await versionComparator?.getVersion() ??
        DataResult.byErrorMessageEnum(error: ErrorMessage.versionComparatorNotSet);
  }
}
