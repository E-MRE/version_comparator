import '../../models/entities/entity_model.dart';
import '../../utils/results/data_result.dart';

abstract class JsonToVersionResponseService {
  DataResult<String> convert(EntityModel entity);
}
