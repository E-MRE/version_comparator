abstract class EntityModel<TModel> {
  String get responseBody;
  TModel fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
