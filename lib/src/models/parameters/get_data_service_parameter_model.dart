import 'service_parameter_model.dart';

class GetDataServiceParameterModel extends ServiceParameterModel {
  final String? query;

  GetDataServiceParameterModel({
    required super.url,
    this.query,
    super.timeout,
    super.header,
  });

  @override
  String getUrl() {
    return query?.isEmpty ?? true ? url : '$url?$query';
  }
}
