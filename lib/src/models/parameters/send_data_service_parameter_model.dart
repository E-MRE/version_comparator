import '../entity_model.dart';
import 'service_parameter_model.dart';

class SendDataServiceParameterModel<TData extends EntityModel<TData>> extends ServiceParameterModel {
  final TData body;

  SendDataServiceParameterModel({
    required super.baseUrl,
    required super.endpoint,
    required this.body,
    super.timeout,
    super.header,
  });

  @override
  String getUrl() => '$baseUrl/$endpoint';
}
