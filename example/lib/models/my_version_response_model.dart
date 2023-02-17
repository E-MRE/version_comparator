import 'package:version_comparator/version_comparator.dart';

class MyVersionResponseModel extends EntityModel<MyVersionResponseModel> {
  @override
  final String responseBody;

  final Map<String, dynamic> jsonData;

  MyVersionResponseModel({required this.jsonData, required this.responseBody});

  MyVersionResponseModel.empty()
      : jsonData = {},
        responseBody = '';

  @override
  MyVersionResponseModel fromJson(Map<String, dynamic> json) {
    return MyVersionResponseModel(jsonData: json, responseBody: responseBody);
  }

  @override
  Map<String, dynamic> toJson() => jsonData;

  @override
  MyVersionResponseModel fromResponseBodyString(String body) {
    return MyVersionResponseModel(jsonData: {'data': body}, responseBody: body);
  }
}
