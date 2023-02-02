// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'huawei_version_entity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HuaweiVersionEntityModel _$HuaweiVersionEntityModelFromJson(
        Map<String, dynamic> json) =>
    HuaweiVersionEntityModel(
      layoutData: (json['layoutData'] as List<dynamic>?)
          ?.map(
              (e) => HuaweiLayoutDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HuaweiVersionEntityModelToJson(
        HuaweiVersionEntityModel instance) =>
    <String, dynamic>{
      'layoutData': instance.layoutData,
    };
