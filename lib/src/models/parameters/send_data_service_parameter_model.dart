import '../entities/entity_model.dart';
import 'service_parameter_model.dart';

class SendDataServiceParameterModel<TData extends EntityModel<TData>>
    extends ServiceParameterModel {
  final TData body;

  SendDataServiceParameterModel({
    required super.url,
    required this.body,
    super.timeout,
    super.header,
  });

  @override
  String getUrl() => url;
}
