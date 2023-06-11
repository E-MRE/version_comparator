library version_comparator;

import 'src/models/index.dart';
import 'src/services/concretes/http_remote_data_manager.dart';
import 'src/services/index.dart';
import 'src/utils/constants/constants.dart';
import 'src/utils/helpers/version_compare_service_factory.dart';
import 'src/utils/index.dart';
import 'src/utils/mixins/bundle_id_controller_mixin.dart';

export 'src/models/index.dart';
export 'src/services/index.dart';
export 'src/utils/index.dart';
export 'src/widgets/index.dart';

///The mission of the VersionComparator class is to compare different versions of an app.
///It has three methods: versionCompare, versionCompareWithHuawei and customCompare.
///The versionCompare methods are used to compare platform-specific versions, such as Android, iOS, and Huawei.
///The customCompare method is used to compare versions with custom settings.
///This method can be used when the project platform is different from Android,
///iOS or Huawei, or when comparing versions from other stores.
class VersionComparator extends BaseVersionComparator with BundleIdControllerMixin, VersionDialogMixin {
  static VersionComparator? _instance;
  static VersionComparator get instance => getInstanceByDialogService();

  ///Create a `VersionComparator` instance using with custom `VersionDialogService` (optional)
  static VersionComparator getInstanceByDialogService({VersionDialogService? dialogService}) {
    _instance ??= VersionComparator._init(dialogService: dialogService ?? VersionDialogManager());

    if (dialogService != null && (_instance!.dialogService.runtimeType != dialogService.runtimeType)) {
      _instance = VersionComparator._init(dialogService: dialogService);
    }
    return _instance!;
  }

  VersionComparator._init({required this.dialogService});

  @override

  ///Version Dialog Service
  final VersionDialogService dialogService;

  @override

  ///Compare app version between current version and store version.
  ///If your app available on AppGallery, this method recommended for you.
  ///It compares app version automatically on Popular App Stores [`PlayStore`,`AppStore`,`AppGallery`]
  Future<DataResult<VersionResponseModel>> versionCompareWithHuawei({
    ///Network Request Manager
    RemoteDataService? dataService,

    ///App's id on AppGallery. It's required for retrieve version from Huawei store.
    required String huaweiId,

    ///Custom android bundle id. If you want to compare different app, set this parameter.
    ///Default value is app bundle id
    String? androidId,

    ///Custom ios bundle id. If you want to compare different app, set this parameter.
    ///Default value is app bundle id
    String? iosId,
  }) async {
    final platform = await getPlatform();
    final bundleResult = await getBundleByOptionalId(
      platform: platform,
      androidId: androidId,
      iosId: iosId,
      huaweiId: huaweiId,
    );

    if (bundleResult.isNotSuccess) {
      return DataResult.error(message: bundleResult.message);
    }

    final remoteService = dataService ?? HttpRemoteDataManager();
    final versionComparatorService = VersionCompareServiceFactory(platform: platform).getCompareService(
      dataService: remoteService,
      bundleId: bundleResult.data ?? kEmpty,
    );

    setVersionComparator(versionComparatorService);

    return await versionComparator?.getVersion() ?? DataResult.error(message: kErrorMessage.versionComparatorNotSet);
  }
}
