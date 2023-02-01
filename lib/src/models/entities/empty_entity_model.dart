import 'entity_model.dart';

class EmptyEntityModel extends EntityModel<EmptyEntityModel> {
  final Map<String, String> jsonData;

  EmptyEntityModel({required this.jsonData});

  EmptyEntityModel.empty() : jsonData = {};

  @override
  EmptyEntityModel fromJson(Map<String, String> json) {
    return EmptyEntityModel(jsonData: json);
  }

  @override
  Map<String, String> toJson() => jsonData;
}
