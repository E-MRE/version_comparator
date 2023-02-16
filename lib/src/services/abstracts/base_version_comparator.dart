import '../../models/entities/entity_model.dart';
import '../../models/parameters/custom_version_compare_parameter_model.dart';
import '../../models/version_response_model.dart';
import '../../utils/constants/constants.dart';
import '../../utils/messages/comparator_error_message.dart';
import '../../utils/messages/comparator_info_message.dart';
import '../../utils/mixins/package_info_mixin.dart';
import '../../utils/mixins/platform_decider_mixin.dart';
import '../../utils/results/data_result.dart';
import '../concretes/custom/custom_version_compare_manager.dart';
import '../concretes/http_remote_data_manager.dart';
import 'remote_data_service.dart';
import 'version_compare_service.dart';
import 'version_convert_service.dart';

///The mission of the VersionComparator class is to compare different versions of an app.
///It has two methods: platformSpecificCompare and customCompare.
///The platformSpecificCompare method is used to compare platform-specific versions, such as Android, iOS, and Huawei.
///The customCompare method is used to compare versions with custom settings.
///This method can be used when the project platform is different from Android,
///iOS or Huawei, or when comparing versions from other stores.
abstract class BaseVersionComparator with PlatformDeciderMixin, PackageInfoMixin {
  VersionCompareService? _versionComparator;

  ///Getter of the current VersionCompare service.
  VersionCompareService? get versionComparator => _versionComparator;

  ///This code is a method that sets the versionComparator variable to the VersionCompareService service.
  ///This service is using for the compare app versions.
  void setVersionComparator(VersionCompareService service) {
    _versionComparator = service;
  }

  ///It sets custom info messages to the package. You can use for handle the package info messages.
  void setInfoMessages(ComparatorInfoMessage infoMessage) {
    AppConstants.setInfoMessage(infoMessage);
  }

  ///It sets custom error messages to the package. You can use for handle the package error messages.
  void setErrorMessages(ComparatorErrorMessage errorMessage) {
    AppConstants.setErrorMessage(errorMessage);
  }

  /// This function returns a Future object of type `[DataResult<VersionResponseModel>]` which is used to
  /// compare platform-specific versions. It takes three optional parameters:
  /// 1. versionConvertService: an optional object. It returns store version from json
  /// 2. dataService: an optional RemoteDataService object. It gets response from stores.
  /// 3. customAppId: an optional String value. It's important for `[Huawei]`.
  /// You must set this parameter if you want to compare your app from `[AppGallery]`.
  Future<DataResult<VersionResponseModel>> comparePlatformSpecific({
    String? customAppId,
    VersionConvertService? versionConvertService,
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
      versionConvertService: parameterModel.versionConvertService,
    ));

    return await versionComparator!.getVersion();
  }
}
