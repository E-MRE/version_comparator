import '../../services/abstracts/json_to_version_response_service.dart';
import '../entities/entity_model.dart';
import '../entities/store_model.dart';

class CustomVersionCompareParameterModel<TData extends EntityModel<TData>> {
  final TData parseModel;
  final String currentAppVersion;
  final JsonToVersionResponseService jsonToResponseService;
  final BaseStoreModel store;
  final String? query;

  CustomVersionCompareParameterModel({
    required this.parseModel,
    required this.currentAppVersion,
    required this.jsonToResponseService,
    required this.store,
    required this.query,
  });
}
