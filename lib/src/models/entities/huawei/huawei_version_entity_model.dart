import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/constants/endpoint_constants.dart';
import '../entity_model.dart';
import 'huawei_layout_data_model.dart';

part 'huawei_version_entity_model.g.dart';

@JsonSerializable()
class HuaweiVersionEntityModel extends EntityModel<HuaweiVersionEntityModel> {
  HuaweiVersionEntityModel({String? responseBody, this.layoutData}) : responseBody = responseBody ?? kEmpty;

  HuaweiVersionEntityModel.empty()
      : responseBody = '',
        layoutData = null;

  @override
  @JsonKey(includeFromJson: false)
  final String responseBody;

  final List<HuaweiLayoutDataModel>? layoutData;

  String storeUrl(String appId) {
    return '${EndpointConstants.huaweiStoreUrl}/$appId';
  }

  String get storeVersion {
    if (layoutData == null || (layoutData?.isEmpty ?? true)) {
      return kEmpty;
    }

    bool isDataNullOrEmpty = layoutData!.first.dataList == null || (layoutData!.first.dataList?.isEmpty ?? true);
    if (isDataNullOrEmpty) {
      return kEmpty;
    }

    return layoutData!.first.dataList!.first.versionName ?? kEmpty;
  }

  factory HuaweiVersionEntityModel.fromJson(Map<String, dynamic> json) => _$HuaweiVersionEntityModelFromJson(json);

  factory HuaweiVersionEntityModel.fromResponse(String body) {
    final json = jsonDecode(body);
    return _$HuaweiVersionEntityModelFromJson(json);
  }

  @override
  HuaweiVersionEntityModel fromJson(Map<String, dynamic> json) => _$HuaweiVersionEntityModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HuaweiVersionEntityModelToJson(this);
}
