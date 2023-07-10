import '../../models/parameters/get_data_service_parameter_model.dart';
import '../../utils/constants/constants.dart';
import '../../utils/constants/endpoint_constants.dart';
import '../../utils/extensions/string_extension.dart';
import '../../utils/mixins/http_header_key_value_mixin.dart';
import '../../utils/results/data_result.dart';
import 'version_compare_service.dart';

abstract class HuaweiVersionCompareService extends VersionCompareByQueryService with HttpHeaderKeyValueMixin {
  Future<DataResult<String>> getInterfaceCode() async {
    final result = await dataService.getData(
      GetDataServiceParameterModel(url: EndpointConstants.huaweiInterfaceCodeUrl),
    );

    return result;
  }

  Future<Map<String, String>> generateHeaderByInterfaceCode() async {
    final interfaceCodeResult = await getInterfaceCode();

    if (interfaceCodeResult.isNotSuccess || (interfaceCodeResult.data?.isNullOrEmpty ?? true)) {
      return dataService.baseHeader;
    }

    return createInterfaceCodeHeader(interfaceCodeResult.data);
  }

  String getInterfaceCodeByTimestamp(String? code) {
    String interfaceCode = code?.replaceAll('"', kEmpty) ?? kEmpty;
    interfaceCode += '_${DateTime.now().millisecondsSinceEpoch}';
    return interfaceCode;
  }

  Map<String, String> createInterfaceCodeHeader(String? interfaceCode) {
    return Map.fromEntries([
      getApplicationJsonContentTypeEntry(),
      getInterfaceCodeEntry(getInterfaceCodeByTimestamp(interfaceCode)),
    ]);
  }
}
