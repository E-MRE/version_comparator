import '../../utils/mixins/version_converter_mixin.dart';
import '../../utils/results/data_result.dart';

abstract class JsonToVersionResponseService with VersionConverterMixin {
  DataResult<String> convert(Map<String, String> json);
}
