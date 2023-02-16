library version_comparator;

import 'src/models/version_response_model.dart';
import 'src/services/abstracts/base_version_comparator.dart';
import 'src/services/abstracts/remote_data_service.dart';
import 'src/services/abstracts/version_convert_service.dart';
import 'src/services/concretes/http_remote_data_manager.dart';
import 'src/utils/constants/constants.dart';
import 'src/utils/helpers/version_compare_service_factory.dart';
import 'src/utils/mixins/bundle_id_controller_mixin.dart';
import 'src/utils/results/data_result.dart';

///The mission of the VersionComparator class is to compare different versions of an app.
///It has two methods: platformSpecificCompare and customCompare.
///The platformSpecificCompare method is used to compare platform-specific versions, such as Android, iOS, and Huawei.
///The customCompare method is used to compare versions with custom settings.
///This method can be used when the project platform is different from Android,
///iOS or Huawei, or when comparing versions from other stores.
class VersionComparator extends BaseVersionComparator with BundleIdControllerMixin {
  static VersionComparator? _instance;
  static VersionComparator get instance {
    _instance ??= VersionComparator._init();
    return _instance!;
  }

  VersionComparator._init();

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
