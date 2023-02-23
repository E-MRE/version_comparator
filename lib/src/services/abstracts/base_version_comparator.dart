import '../../../version_comparator.dart';
import '../../utils/constants/constants.dart';
import '../../utils/mixins/package_info_mixin.dart';
import '../concretes/http_remote_data_manager.dart';

///The mission of the VersionComparator class is to compare different versions of an app.
///It has two methods: platformSpecificCompare and customCompare.
///The platformSpecificCompare method is used to compare platform-specific versions, such as Android, iOS, and Huawei.
///The customCompare method is used to compare versions with custom settings.
///This method can be used when the project platform is different from Android,
///iOS or Huawei, or when comparing versions from other stores.
abstract class BaseVersionComparator with PlatformDeciderMixin, PackageInfoMixin, VersionDialogMixin {
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
  /// 1. dataService: an optional RemoteDataService object. It gets response from stores.
  /// 2. customAppId: an optional String value. It's important for `[Huawei]`.
  /// You must set this parameter if you want to compare your app from `[AppGallery]`.
  Future<DataResult<VersionResponseModel>> platformSpecificCompareByAppId({
    String? customAppId,
    RemoteDataService? dataService,
  });

  /// This function returns a Future object of type `[DataResult<VersionResponseModel>]` which is used to
  /// compare platform-specific versions. It takes three optional parameters:
  /// 1. dataService: an optional RemoteDataService object. It gets response from stores.
  /// You must set this parameter if you want to compare your app from `[AppGallery]`.
  Future<DataResult<VersionResponseModel>> platformSpecificCompare({RemoteDataService? dataService}) {
    return platformSpecificCompareByAppId(dataService: dataService);
  }

  /// Custom compares the local version of the app with the remote version.
  ///
  /// [localVersion] The current version of the app.
  /// [dataService] An optional RemoteDataService instance used to fetch remote data.
  /// [store] A BaseStoreModel instance used to store the response data.
  /// [customUpdateLink] An optional function that can be used to customize the update link in the response.
  /// [onConvertVersion] A required function that is used to convert the response body into a version string.
  ///
  /// return A Future containing a DataResult<VersionResponseModel> instance with either success or error state.
  Future<DataResult<VersionResponseModel>> customCompare({
    required String localVersion,
    RemoteDataService? dataService,
    required BaseStoreModel store,
    String? Function(String responseBody)? customUpdateLink,
    required String? Function(String responseBody) onConvertVersion,
  }) async {
    setVersionComparator(CustomVersionCompareManager(
      store: store,
      localVersion: localVersion,
      customUpdateLink: customUpdateLink,
      onConvertVersion: onConvertVersion,
      dataService: dataService ?? HttpRemoteDataManager(),
    ));

    return await versionComparator!.getVersion();
  }
}
