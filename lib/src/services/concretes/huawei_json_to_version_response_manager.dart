import '../../models/entities/huawei/huawei_version_entity_model.dart';
import '../../utils/enums/error_message.dart';
import '../../utils/results/data_result.dart';
import '../abstracts/json_to_version_response_service.dart';

class HuaweiJsonToVersionResponseManager extends JsonToVersionResponseService<HuaweiVersionEntityModel> {
  @override
  DataResult<String> convert(HuaweiVersionEntityModel entity) {
    final version = entity.storeVersion;

    return version.isEmpty
        ? DataResult.byErrorMessageEnum(error: ErrorMessage.versionNotMatch)
        : DataResult.success(data: version);
  }
}
