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

///The mission of the VersionComparator class is to compare different versions of an app.
///It has two methods: platformSpecificCompare and customCompare.
///The platformSpecificCompare method is used to compare platform-specific versions, such as Android, iOS, and Huawei.
///The customCompare method is used to compare versions with custom settings.
///This method can be used when the project platform is different from Android,
///iOS or Huawei, or when comparing versions from other stores.
class VersionComparator extends BaseVersionComparator with BundleIdControllerMixin, VersionDialogMixin {
  static VersionComparator? _instance;
  static VersionComparator get instance => getInstanceByDialogService();

  static VersionComparator getInstanceByDialogService({VersionDialogService? dialogService}) {
    _instance ??= VersionComparator._init(dialogService: dialogService ?? VersionDialogManager());

    if (dialogService != null && (_instance!.dialogService.runtimeType != dialogService.runtimeType)) {
      _instance = VersionComparator._init(dialogService: dialogService);
    }
    return _instance!;
  }

  VersionComparator._init({required this.dialogService});

  @override
  final VersionDialogService dialogService;

  @override
  Future<DataResult<VersionResponseModel>> comparePlatformSpecific({
    String? customAppId,
    VersionConvertService? versionConvertService,
    RemoteDataService? dataService,
  }) async {
    final platform = await getPlatform();
    final bundleResult = await getBundleWithCustomAppId(customAppId, platform);

    if (bundleResult.isNotSuccess) {
      return DataResult.error(message: bundleResult.message);
    }

    final remoteService = dataService ?? HttpRemoteDataManager();
    final versionComparatorService = VersionCompareServiceFactory(platform: platform).getCompareService(
      versionConvertService: versionConvertService,
      dataService: remoteService,
      bundleId: bundleResult.data ?? kEmpty,
    );

    setVersionComparator(versionComparatorService);

    return await versionComparator?.getVersion() ?? DataResult.error(message: kErrorMessage.versionComparatorNotSet);
  }
}
