import 'package:json_annotation/json_annotation.dart';

import '../../../utils/constants/constants.dart';
import '../entity_model.dart';
import 'huawei_app_data_model.dart';

part 'huawei_layout_data_model.g.dart';

@JsonSerializable()
class HuaweiLayoutDataModel extends EntityModel<HuaweiLayoutDataModel> {
  final List<HuaweiAppDataModel>? dataList;

  @override
  @JsonKey(includeFromJson: false)
  final String responseBody;

  HuaweiLayoutDataModel({this.dataList, String? responseBody})
      : responseBody = responseBody ?? kEmpty;

  factory HuaweiLayoutDataModel.fromJson(Map<String, dynamic> json) =>
      _$HuaweiLayoutDataModelFromJson(json);

  @override
  HuaweiLayoutDataModel fromJson(Map<String, dynamic> json) =>
      _$HuaweiLayoutDataModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HuaweiLayoutDataModelToJson(this);
}
