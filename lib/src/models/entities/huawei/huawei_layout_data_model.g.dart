// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'huawei_layout_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HuaweiLayoutDataModel _$HuaweiLayoutDataModelFromJson(
        Map<String, dynamic> json) =>
    HuaweiLayoutDataModel(
      dataList: (json['dataList'] as List<dynamic>?)
          ?.map((e) => HuaweiAppDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HuaweiLayoutDataModelToJson(
        HuaweiLayoutDataModel instance) =>
    <String, dynamic>{
      'dataList': instance.dataList,
    };
