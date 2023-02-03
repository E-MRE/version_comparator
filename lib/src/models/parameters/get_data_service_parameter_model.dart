import '../entities/entity_model.dart';
import 'service_parameter_model.dart';

class GetDataServiceParameterModel<TData extends EntityModel<TData>> extends ServiceParameterModel {
  final TData parseModel;
  final String? query;

  GetDataServiceParameterModel({
    required super.url,
    required this.parseModel,
    this.query,
    super.timeout,
    super.header,
  });

  @override
  String getUrl() {
    return query?.isEmpty ?? true ? url : '$url?$query';
  }
}
