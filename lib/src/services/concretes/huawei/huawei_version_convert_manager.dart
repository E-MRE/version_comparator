import '../../../models/entities/huawei/huawei_version_entity_model.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/results/data_result.dart';
import '../../abstracts/version_convert_service.dart';

class HuaweiVersionConvertManager
    extends VersionConvertService<HuaweiVersionEntityModel> {
  @override
  DataResult<String> convert(HuaweiVersionEntityModel entity) {
    final version = entity.storeVersion;

    return version.isEmpty
        ? DataResult.error(message: kErrorMessage.versionNotMatch)
        : DataResult.success(data: version);
  }
}
