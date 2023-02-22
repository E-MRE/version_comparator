import 'package:json_annotation/json_annotation.dart';

import '../../../utils/constants/constants.dart';
import '../entity_model.dart';

part 'huawei_app_data_model.g.dart';

@JsonSerializable()
class HuaweiAppDataModel extends EntityModel<HuaweiAppDataModel> {
  final String? versionName;
  final String? package;

  @override
  @JsonKey(includeFromJson: false)
  final String responseBody;

  HuaweiAppDataModel({this.package, this.versionName, String? responseBody}) : responseBody = responseBody ?? kEmpty;

  factory HuaweiAppDataModel.fromJson(Map<String, dynamic> json) => _$HuaweiAppDataModelFromJson(json);

  @override
  HuaweiAppDataModel fromJson(Map<String, dynamic> json) => _$HuaweiAppDataModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HuaweiAppDataModelToJson(this);
}
