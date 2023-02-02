abstract class EntityModel<TModel> {
  String get responseBody;
  TModel fromJson(Map<String, dynamic> json);
  TModel fromResponseBodyString(String body);
  Map<String, dynamic> toJson();
}
