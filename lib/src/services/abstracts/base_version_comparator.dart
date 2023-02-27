import '../../../version_comparator.dart';
import '../../utils/constants/constants.dart';
import '../../utils/mixins/package_info_mixin.dart';
import '../concretes/http_remote_data_manager.dart';

///The mission of the VersionComparator class is to compare different versions of an app.
///It has three methods: versionCompare, versionCompareWithHuawei and customCompare.
///The versionCompare methods are used to compare platform-specific versions, such as Android, iOS, and Huawei.
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

  /// This function compares versions of an Android, iOS, and Huawei device.
  ///
  /// RemoteDataService? dataService - A service that provides remote data. default service is [HttpRemoteDataManager]
  /// String? androidId - The version ID of the Android device. It's optional. default value is [app bundle id].
  /// String? iosId - The version ID of the iOS device. It's optional. default value is [app bundle id].
  /// String huaweiId - The version ID of the Huawei device. It's required.
  /// If you set empty than function will throw exception
  ///
  /// It returns DataResult<VersionResponseModel> object containing a VersionResponseModel object.
  Future<DataResult<VersionResponseModel>> versionCompareWithHuawei({
    ///Http (GET, POST) methods manager. You can set [dataService] with custom manager.
    RemoteDataService? dataService,

    //Huawei app id. It's important for retrieve version from Huawei store.
    required String huaweiId,

    ///Custom android bundle id. If you want to compare different app, set this parameter.
    ///Default value is app bundle id
    String? androidId,

    ///Custom ios bundle id. If you want to compare different app, set this parameter.
    ///Default value is app bundle id
    String? iosId,
  });

  /// This function compares versions of an Android, iOS, and Huawei device.
  ///
  /// RemoteDataService? dataService - A service that provides remote data. default service is [HttpRemoteDataManager]
  /// String? androidId - The version ID of the Android device. It's optional. default value is [app bundle id].
  /// String? iosId - The version ID of the iOS device. It's optional. default value is [app bundle id].
  /// String? huaweiId - The version ID of the Huawei device. It's optional. Don't use that comparator if your app
  /// in the [AppGallery]. Because AppGallery app id is different from the app bundle id.
  ///
  /// It returns DataResult<VersionResponseModel> object containing a VersionResponseModel object.
  Future<DataResult<VersionResponseModel>> versionCompare({
    ///Http (GET, POST) methods manager. You can set [dataService] with custom manager.
    RemoteDataService? dataService,

    ///Custom android bundle id. If you want to compare different app, set this parameter.
    ///Default value is app bundle id
    String? androidId,

    ///Custom ios bundle id. If you want to compare different app, set this parameter.
    ///Default value is app bundle id
    String? iosId,

    ///If your app is published on the [AppGallery] (Huawei Store) you must set that id.
    String? huaweiId,

    ///Set that parameter if your app version different from current app version. Default value is app version
    String? customLocalVersion,
  }) {
    return versionCompareWithHuawei(
      dataService: dataService,
      androidId: androidId,
      iosId: iosId,
      huaweiId: huaweiId ?? kEmpty,
    );
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
