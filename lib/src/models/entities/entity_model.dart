abstract class EntityModel<TModel> {
  TModel fromJson(Map<String, String> json);
  Map<String, String> toJson();
}
