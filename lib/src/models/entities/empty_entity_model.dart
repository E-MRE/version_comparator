import 'entity_model.dart';

class EmptyEntityModel extends EntityModel<EmptyEntityModel> {
  @override
  final String responseBody;

  final Map<String, String> jsonData;

  EmptyEntityModel({required this.jsonData, required this.responseBody});

  EmptyEntityModel.empty()
      : jsonData = {},
        responseBody = '';

  @override
  EmptyEntityModel fromJson(Map<String, String> json) {
    return EmptyEntityModel(jsonData: json, responseBody: responseBody);
  }

  @override
  Map<String, String> toJson() => jsonData;

  @override
  EmptyEntityModel fromResponseBodyString(String body) {
    return EmptyEntityModel(jsonData: {'data': body}, responseBody: body);
  }
}
