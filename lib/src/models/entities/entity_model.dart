abstract class EntityModel<TModel> {
  String get responseBody;
  TModel fromJson(Map<String, String> json);
  TModel fromResponseBodyString(String body);
  Map<String, dynamic> toJson();
}
